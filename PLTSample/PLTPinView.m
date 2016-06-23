//
//  PLTPin.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import QuartzCore;

#import "PLTPinView.h"

@interface PLTPin : UIView

@property(nonatomic, strong, nonnull) UIColor *color;
@property(nonatomic) CGFloat yPinPointCoordinate;

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithCoder:(nullable NSCoder *)aDecoder NS_UNAVAILABLE;

- (nonnull instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@end

static const CGFloat kPLTPinCircleRadius= 12.0;
static const CGFloat kPLTPinWidth = 2.0;

@implementation PLTPin

@synthesize color = _color;
@synthesize yPinPointCoordinate = _yPinPointCoordinate;

- (nonnull instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    
    _color = [UIColor blueColor];
    _yPinPointCoordinate = CGRectGetMinY(frame);
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  CGContextSetLineWidth(context, kPLTPinWidth);
  CGContextSetStrokeColorWithColor(context, [self.color CGColor]);
  CGContextMoveToPoint(context, CGRectGetMidX(rect), CGRectGetMinY(rect));
  CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMaxY(rect) - 10);
  CGContextStrokePath(context);
  
  CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
  CGRect pinCircleRect = CGRectMake(CGRectGetMidX(rect) - kPLTPinCircleRadius/2,
                                    self.yPinPointCoordinate - kPLTPinCircleRadius/2 - kPLTYOffset,
                                    kPLTPinCircleRadius, kPLTPinCircleRadius);
  CGContextFillEllipseInRect(context, pinCircleRect);
  
  CGContextRestoreGState(context);
}

@end



static const CGFloat kPLTPinLabelHeight = 20.0;
static const CGRect kPLTPinLabelDefaultFrame = {{0.0, 0.0}, {60.0, kPLTPinLabelHeight}};

@interface PLTPinView ()

@property (nonatomic, nonnull, strong) UILabel *pinValueLabel;
@property (nonatomic, nonnull, strong) PLTPin *pin;

@end

@implementation PLTPinView

@synthesize dataSource;
@synthesize pinColor = _pinColor;
@synthesize pinValueLabel = _pinValueLabel;
@synthesize pin = _pin;

- (nonnull instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    _pinColor = [UIColor blueColor];
    
    _pinValueLabel = [[UILabel alloc] initWithFrame:kPLTPinLabelDefaultFrame];
    _pinValueLabel.backgroundColor = _pinColor;
    _pinValueLabel.textColor = [UIColor whiteColor];
    _pinValueLabel.textAlignment = NSTextAlignmentCenter;
    _pinValueLabel.layer.masksToBounds = YES;
    _pinValueLabel.layer.cornerRadius = 10.0;
    
    _pin = [[PLTPin alloc] initWithFrame:CGRectMake(0.0, kPLTPinLabelHeight,
                                                    kPLTPinCircleRadius*2, frame.size.height - kPLTPinLabelHeight/2)];
    _pin.color = _pinColor;
  }
  return self;
}

- (void)setPinColor:(UIColor *)pinColor {
  _pinColor = pinColor;
  self.pinValueLabel.backgroundColor = _pinColor;
  self.pin.color = _pinColor;
}

- (void)calculateFrameWithTouchLocation:(CGPoint)touchLocation
                                  forView:(UIView *)view
                   significantPintIndex:(NSUInteger)pointIndex{
  // TODO: Переделать весь этот метод
  CGFloat xNewStartPoint = 0.0;
  CGRect currentFrame = view.frame;
  CGFloat currentFrameWidth = currentFrame.size.width;
  CGFloat currentFrameHeight = currentFrame.size.height;
  CGFloat yStartPoint = CGRectGetMinY(currentFrame);
  
  if (touchLocation.x >= (CGRectGetMinX(self.frame) + currentFrameWidth/2 + kPLTXOffset) &&
      touchLocation.x <= (CGRectGetMaxX(self.frame) - currentFrameWidth/2 - kPLTXOffset)) {
    CGPoint tmpPoint = [self.dataSource pointForIndex:pointIndex];
    CGFloat xTouchPoint = tmpPoint.x;
    // TODO: Здесь тоже неудачное решение
    if ([view isMemberOfClass: [PLTPin class]]) {
      ((PLTPin *)view).yPinPointCoordinate = [self.dataSource pointForIndex:pointIndex].y;
      [view setNeedsDisplay];
      xNewStartPoint = xTouchPoint - currentFrameWidth/2;
    }
    if ([view isMemberOfClass:[UILabel class]]) {
      if (pointIndex == 0) {
        xNewStartPoint = CGRectGetMinX(self.frame);
      }
      else if (pointIndex == [self.dataSource pointsCount] - 1) {
        xNewStartPoint = CGRectGetMaxX(self.frame) - currentFrameWidth;
      }
      else {
          xNewStartPoint = xTouchPoint - currentFrameWidth/2;
      }
    }
    
  }
  else if (touchLocation.x < (CGRectGetMinX(self.frame) + currentFrameWidth/2 + kPLTXOffset)) {
    // HACK: Разобраться почему добавка kPLTPinWidth сдвигает линию в 0 и максимум (вроде бы не должно)
    xNewStartPoint = CGRectGetMinX(self.frame) - kPLTPinWidth;
  }
  else {
    xNewStartPoint = CGRectGetMaxX(self.frame) - currentFrameWidth + kPLTPinWidth;
  }
  
  view.frame = CGRectMake(xNewStartPoint, yStartPoint, currentFrameWidth, currentFrameHeight);
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  UITouch *touch = [[touches allObjects] objectAtIndex:0];
  CGPoint touchLocation = [touch locationInView:self];
  NSUInteger significantPointIndex = [self.dataSource closingSignicantPointIndexForPoint:touchLocation];
  // TODO: Проверка возвращаемого значения
  self.pinValueLabel.text = [[self.dataSource valueForIndex:significantPointIndex] stringValue];
  [self calculateFrameWithTouchLocation:touchLocation
                                forView:self.pin
                   significantPintIndex:significantPointIndex];
  [self calculateFrameWithTouchLocation:touchLocation
                                forView:self.pinValueLabel
                   significantPintIndex:significantPointIndex];
  [self addSubview:self.pinValueLabel];
  [self addSubview:self.pin];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  UITouch *touch = [[touches allObjects] objectAtIndex:0];
  CGPoint touchLocation = [touch locationInView:self];
  NSUInteger significantPointIndex = [self.dataSource closingSignicantPointIndexForPoint:touchLocation];
  // TODO: Проверка возвращаемого значения
  self.pinValueLabel.text = [[self.dataSource valueForIndex:significantPointIndex] stringValue];
  [self calculateFrameWithTouchLocation:touchLocation
                                forView:self.pin
                   significantPintIndex:significantPointIndex];
  [self calculateFrameWithTouchLocation:touchLocation
                                forView:self.pinValueLabel
                   significantPintIndex:significantPointIndex];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  [self.pinValueLabel removeFromSuperview];
  [self.pin removeFromSuperview];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  [self.pinValueLabel removeFromSuperview];
  [self.pin removeFromSuperview];
}

#pragma clang diagnostic pop

@end
