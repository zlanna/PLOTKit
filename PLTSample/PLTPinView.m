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
                                    self.yPinPointCoordinate - kPLTPinCircleRadius/2,
                                    kPLTPinCircleRadius, kPLTPinCircleRadius);
  CGContextFillEllipseInRect(context, pinCircleRect);
  
  CGContextRestoreGState(context);
}

@end



static const CGFloat kPLTPinLabelHeight = 20.0;
static const CGRect kPLTPinLabelDefaultFrame = {{0.0, 0.0}, {20.0, kPLTPinLabelHeight}};

@interface PLTPinView ()

@property (nonatomic, nonnull, strong) UILabel *pinValueLabel;
@property (nonatomic, nonnull, strong) PLTPin *pin;

@end

@implementation PLTPinView

@synthesize dataSource;
@synthesize pinColor = _pinColor;
@synthesize pinValueLabel = _pinValueLabel;
@synthesize pin = _pin;

#pragma mark - Initialization

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

#pragma mark - Custom property getter

- (void)setPinColor:(UIColor *)pinColor {
  _pinColor = pinColor;
  self.pinValueLabel.backgroundColor = _pinColor;
  self.pin.color = _pinColor;
}

#pragma mark - Touch events handling

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  UITouch *touch = [[touches allObjects] objectAtIndex:0];
  CGPoint touchLocation = [touch locationInView:self];
  [self redrawSubviewsForTouchLocation:touchLocation];
  [self addSubview:self.pinValueLabel];
  [self addSubview:self.pin];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  UITouch *touch = [[touches allObjects] objectAtIndex:0];
  CGPoint touchLocation = [touch locationInView:self];
  [self redrawSubviewsForTouchLocation:touchLocation];
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

#pragma mark - Handler helpers

- (void)redrawSubviewsForTouchLocation:(CGPoint)touchLocation {
  NSUInteger significantPointIndex = [self.dataSource closingSignicantPointIndexForPoint:touchLocation];
  NSString *newPinLabelText = [[self.dataSource valueForIndex:significantPointIndex] stringValue];
  
  [self addNewTextToPinValueLabel:newPinLabelText];
  
  [self frameForTouchLocation:touchLocation
                      forView:self.pin
           viewSpecifiedCalcs:^CGFloat() {
             CGPoint touchPoint = [self.dataSource pointForIndex:significantPointIndex];
             self.pin.yPinPointCoordinate = touchPoint.y;
             [self.pin setNeedsDisplay];
             return touchPoint.x - CGRectGetWidth(self.pin.frame)/2;
           }];
  
  [self frameForTouchLocation:touchLocation
                      forView:self.pinValueLabel
           viewSpecifiedCalcs:^CGFloat() {
             CGPoint touchPoint = [self.dataSource pointForIndex:significantPointIndex];
             if (significantPointIndex == 0) {
               return CGRectGetMinX(self.frame);
             }
             else if (significantPointIndex == [self.dataSource pointsCount] - 1) {
               return CGRectGetMaxX(self.frame) - CGRectGetWidth(self.pinValueLabel.frame);
             }
             else {
               return touchPoint.x - CGRectGetWidth(self.pinValueLabel.frame)/2;
             }
           }];
}

- (void)frameForTouchLocation:(CGPoint)touchLocation
                      forView:(UIView *)view
                 viewSpecifiedCalcs:(CGFloat (^)())calculationBlock {
  CGFloat xNewStartPoint = 0.0;
  CGRect currentFrame = view.frame;
  CGFloat currentFrameWidth = currentFrame.size.width;
  CGFloat currentFrameHeight = currentFrame.size.height;
  CGFloat yStartPoint = CGRectGetMinY(currentFrame);
  if (touchLocation.x >= (CGRectGetMinX(self.frame) + currentFrameWidth/2) &&
      touchLocation.x <= (CGRectGetMaxX(self.frame) - currentFrameWidth/2)) {
    xNewStartPoint = calculationBlock();
  }
  else if (touchLocation.x < (CGRectGetMinX(self.frame) + currentFrameWidth/2)) {
    xNewStartPoint = CGRectGetMinX(self.frame) - kPLTPinWidth;
  }
  else {
    xNewStartPoint = CGRectGetMaxX(self.frame) - currentFrameWidth + kPLTPinWidth;
  }
  view.frame = CGRectMake(xNewStartPoint, yStartPoint, currentFrameWidth, currentFrameHeight);
}

- (void)addNewTextToPinValueLabel:(nullable NSString *)text {
  CGFloat newWidth;
  if (text == nil){
    text = @"";
    newWidth = kPLTPinLabelDefaultFrame.size.width;
  }
  else {
    newWidth = [text sizeWithAttributes:@{NSFontAttributeName : self.pinValueLabel.font}].width
                                                                      + kPLTPinLabelDefaultFrame.size.width;
  }
  CGPoint center = self.pinValueLabel.center;
  CGRect currentFrame = self.pinValueLabel.frame;
  CGRect newPinValueLabelFrame = CGRectMake(center.x - newWidth/2,CGRectGetMinY(currentFrame),
                                            newWidth, CGRectGetHeight(currentFrame));
  self.pinValueLabel.frame = newPinValueLabelFrame;
  self.pinValueLabel.text = text;
}

@end
