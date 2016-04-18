//
//  PLTLinearChart.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 06.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLinearChartView.h"
#import "PLTLinearChartStyle.h"

static NSString *const kXAxis = @"X";
static NSString *const kYAxis = @"Y";

typedef __kindof NSArray<NSValue *> ChartPoints;

@interface PLTLinearChartView ()

@property(nonatomic, strong, nonnull) PLTLinearChartStyle *style;
@property(nonatomic, strong) ChartPoints *chartPoints;

@end


@implementation PLTLinearChartView

@synthesize styleSource;
@synthesize chartData = _chartData;
@synthesize style = _style;
@synthesize chartPoints;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    
    _style = [PLTLinearChartStyle blank];
    _chartData = @{
                    kXAxis:@[@0,@10,@20,@30,@40,@50,@60,@70,@80,@90,@100],
                    kYAxis:@[@0,@3,@5,@5,@2,@2,@2,@3,@3,@3,@1]
                   };
  }
  return self;
}

- (null_unspecified instancetype)init {
  return [self initWithFrame:kPLTDefaultFrame];
}

#pragma mark - View lifecycle

- (void)setNeedsDisplay{
  [super setNeedsDisplay];
  PLTLinearChartStyle *newStyle = [[self.styleSource styleContainer] chartStyle];
  if (newStyle) {
    self.style = newStyle;
  }
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
  if (self.chartData != nil) {
    
    [self drawLine:rect];
    
    if (self.style.hasFilling) {
      [self drawFill:rect];
    }
    
    if (self.style.hasMarkers) {
      [self drawMarkers];
    }
  }
}

- (void)drawLine:(CGRect)rect {
  self.chartPoints = [self prepareChartPoints:rect];
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  CGContextSetStrokeColorWithColor(context, [self.style.chartLineColor CGColor]);
  CGContextSetLineWidth(context, 2.0);
  
  CGPoint currentPoint = [self.chartPoints[0] CGPointValue];
  CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);
  
  for (NSValue *pointContainer in self.chartPoints) {
    CGPoint nextPoint = [pointContainer CGPointValue];
    //TODO: Тут можно вставить код для интерполяции
    //CGContextAddQuadCurveToPoint(context, 0.0, 0.0, nextPoint.x, nextPoint.y);
    CGContextAddLineToPoint(context, nextPoint.x, nextPoint.y);
  }
  
  CGContextStrokePath(context);
  CGContextRestoreGState(context);
}

- (ChartPoints *)prepareChartPoints:(CGRect)rect {
  NSArray<NSNumber *> *xComponents = self.chartData[kXAxis];
  NSArray<NSNumber *> *yComponents = self.chartData[kYAxis];
  
  //TODO: Вот где-то здесь прячется автоформатирование
  NSUInteger gridCountY = 10;
  NSUInteger gridCountX = 10;
  
  CGFloat width = CGRectGetWidth(rect);
  CGFloat height = CGRectGetHeight(rect);
  
  CGFloat deltaX = (width - 2*kPLTXOffset) / gridCountX;
  CGFloat deltaY = (height - 2*kPLTYOffset) / gridCountY;
  
  CGFloat axisXstartPoint = ([xComponents[0] plt_CGFloatValue] / gridCountX)*deltaX;
  
  ChartPoints *points = [NSMutableArray<NSValue *> arrayWithCapacity:xComponents.count];
  
  if (xComponents.count == yComponents.count) {
    for (NSUInteger i=0; i < xComponents.count; ++i) {
      [points addObject:
       [NSValue valueWithCGPoint:
        CGPointMake(axisXstartPoint + i*deltaX + kPLTXOffset,
          height - ([yComponents[i] plt_CGFloatValue]*deltaY + kPLTYOffset))]];
    }
  }
  else {
    //TODO: Добавить выброс исключения
    /*
    @throw [NSException exceptionWithName:
     */
  }
  return points;
}

- (void)drawFill:(CGRect)rect {
  CGColorRef startColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.5] CGColor];
  CGColorRef endColor = [[self.style.chartLineColor colorWithAlphaComponent:0.5] CGColor];
  
  const CGFloat *startColorComponents = CGColorGetComponents(startColor);
  const CGFloat *endColorComponents = CGColorGetComponents(endColor);
  
  CGFloat colors[] = {
    startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3],
    endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]
  };
  
  CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
  CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
  CGColorSpaceRelease(baseSpace), baseSpace = NULL;
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextBeginPath(context);
  
  CGFloat height = CGRectGetHeight(rect);
  CGFloat leftEdgeY = CGRectGetMinY(rect);
  
  CGContextMoveToPoint(context, [self.chartPoints[0] CGPointValue].x, leftEdgeY + height - kPLTYOffset);
  
  for (NSValue *pointContainer in self.chartPoints) {
    CGPoint currentPoint = [pointContainer CGPointValue];
    CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
  }
  
  CGContextAddLineToPoint(context, [self.chartPoints.lastObject CGPointValue].x, leftEdgeY + height - kPLTYOffset);
  CGContextClosePath(context);
  
  CGContextClip(context);
  
  CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
  CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
  
  CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
  CGGradientRelease(gradient), gradient = NULL;
  
  CGContextRestoreGState(context);
}

- (void)drawMarkers {
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSaveGState(context);
  CGContextSetFillColorWithColor(context, [self.style.chartLineColor CGColor]);

  
  CGFloat markerRadius = 4.0;
  
  for (NSUInteger i = 1; i < self.chartPoints.count; ++i) {

    CGPoint currentPoint = [self.chartPoints[i] CGPointValue];
    CGRect markerRect = CGRectMake(currentPoint.x - markerRadius,
                                   currentPoint.y - markerRadius,
                                   2*markerRadius,
                                   2*markerRadius);
    
    CGContextAddEllipseInRect(context, markerRect);
    CGContextFillPath(context);

  }
  
  CGContextRestoreGState(context);
}


#pragma mark - Interaction

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"
#pragma clang diagnostic ignored "-Wunused-variable"

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
  NSSet *allTouches = [event allTouches];
  UITouch *touch = allTouches.allObjects[0];
  CGPoint touchLocation = [touch locationInView:self];

#ifdef DEBUG
  NSLog(@"touchesBegan");
  NSLog(@"Количество контактов: %lu", (unsigned long)allTouches.count);
  NSLog(@"Количество касаний: %lu", (unsigned long)touch.tapCount);
  NSLog(@"x=%f y=%f", (double)touchLocation.x, (double)touchLocation.y);
  NSLog(@"%@", touch.view);
#endif
}

#pragma clang diagnostic push
 
@end
