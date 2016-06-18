//
//  PLTLinearChart.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 06.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLinearChartView.h"
#import "PLTLinearChartStyle.h"
#import "NSArray+SortAndRemove.h"

NSString *const kPLTXAxis = @"X";
NSString *const kPLTYAxis = @"Y";

typedef __kindof NSArray<NSValue *> ChartPoints;
typedef NSDictionary<NSString *,NSArray<NSNumber *> *> ChartData;

@interface PLTLinearChartView ()

@property(nonatomic, strong, nonnull) PLTLinearChartStyle *style;
@property(nonatomic, strong) ChartPoints *chartPoints;
@property(nonatomic, strong, nullable) ChartData *chartData;
@property(nonatomic) CGFloat yZeroLevel;

@end


@implementation PLTLinearChartView

@synthesize styleSource;
@synthesize dataSource;
@synthesize chartData;
@synthesize style = _style;
@synthesize chartPoints;
@synthesize yZeroLevel = _yZeroLevel;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    
    _yZeroLevel = 0.0;
    _style = [PLTLinearChartStyle blank];
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
  
  if (self.dataSource) {
    self.chartData = [self.dataSource chartDataSet];
  }
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
  if (self.chartData) {
    
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
    //TODO: Add code for nonlinear interpolation
    CGContextAddLineToPoint(context, nextPoint.x, nextPoint.y);
  }
  
  CGContextStrokePath(context);
  CGContextRestoreGState(context);
}

- (ChartPoints *)prepareChartPoints:(CGRect)rect {
  NSArray<NSNumber *> *xComponents = self.chartData[kPLTXAxis];
  NSArray<NSNumber *> *yComponents = self.chartData[kPLTYAxis];
  
  NSUInteger gridCountX = [self.chartData[kPLTXAxis] count] /*HACK:*/ - 1;
  
  //TODO: Переделать весь этот участок кода. Нужно вынести все эти обсчеты поведения на правильный уровень абстракции
  //TODO: Исправить конвертацию _Nullable в _Nonnull
  NSArray *nonnullArray = self.chartData[kPLTYAxis];
  NSArray *uniqueOrderedDataLevels = [NSArray plt_sortAndRemoveDublicatesNumbers:nonnullArray];
  CGFloat min = [uniqueOrderedDataLevels[0] plt_CGFloatValue];
  CGFloat max = [[uniqueOrderedDataLevels lastObject] plt_CGFloatValue];
  
  CGFloat leftEdgeX = CGRectGetMinX(rect);
  CGFloat width = CGRectGetWidth(rect);
  CGFloat height = CGRectGetHeight(rect);
  
  CGFloat deltaX = (width - 2*kPLTXOffset) / gridCountX;
  CGFloat deltaY = (height - 2*kPLTYOffset) / (max + fabs(min));
  
  ChartPoints *points = [NSMutableArray<NSValue *> arrayWithCapacity:xComponents.count];
  
  //TODO: Эта часть скорее всего тоже не нужна
  if (xComponents.count == yComponents.count) {
    for (NSUInteger i=0; i < xComponents.count; ++i) {
      [points addObject:
       [NSValue valueWithCGPoint:
        CGPointMake(leftEdgeX + i*deltaX + kPLTXOffset,
                    height - (([yComponents[i] plt_CGFloatValue] - min)*deltaY + kPLTYOffset))]];
    }
    //HACK:
    self.yZeroLevel = height - ((- min)*deltaY + kPLTYOffset);
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
  
  //TODO: Направление градиента можно сделать разным в зависимости от положения над осью y
  CGPoint gradientStartPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
  CGPoint gradientEndPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextBeginPath(context);
   
  ChartPoints *newPoints = [self prepareChartPartsForFilling];

  CGContextMoveToPoint(context, [newPoints[0] CGPointValue].x, self.yZeroLevel);
  
  for (NSUInteger i=0; i<[newPoints count]; ++i) {
    CGPoint currentPoint = [newPoints[i] CGPointValue];
    if (([[NSNumber numberWithFloat:currentPoint.y] isEqualToNumber:[NSNumber numberWithFloat:self.yZeroLevel]]) ||
       (i == [newPoints count]-1)) {
      CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
      CGContextClosePath(context);
      CGContextClip(context);
      
      CGContextDrawLinearGradient(context, gradient, gradientStartPoint, gradientEndPoint, kCGGradientDrawsBeforeStartLocation);
      CGContextRestoreGState(context);
      
      CGContextSaveGState(context);
      CGContextBeginPath(context);
      CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);
    }
    else {
      CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
    }
  }
  CGGradientRelease(gradient), gradient = NULL;
  CGContextRestoreGState(context);
}

- (ChartPoints *)prepareChartPartsForFilling {
  ChartPoints *resultArray = [NSMutableArray<NSValue *> new];
 
  CGPoint initialPoint = [self.chartPoints[0] CGPointValue];
  BOOL largerThanZero = (initialPoint.y>self.yZeroLevel)?YES:NO;
  [resultArray addObject:[NSValue valueWithCGPoint:initialPoint]];
  
  for (NSUInteger i=1; i<[self.chartPoints count]; ++i) {
    CGPoint currentPoint = [self.chartPoints[i] CGPointValue];
    CGPoint previousPoint = [self.chartPoints[i-1] CGPointValue];
    if ((currentPoint.y<self.yZeroLevel && largerThanZero) ||
        (currentPoint.y>self.yZeroLevel && !largerThanZero)) {
      CGFloat xForZeroLevel = [self calcXForZeroLevelWith:previousPoint and:currentPoint];
      CGPoint zeroPoint = CGPointMake( xForZeroLevel, self.yZeroLevel);
      [resultArray addObject:[NSValue valueWithCGPoint:zeroPoint]];
      [resultArray addObject:[NSValue valueWithCGPoint:currentPoint]];
      largerThanZero = (currentPoint.y>self.yZeroLevel)?YES:NO;
    }
    else {
      [resultArray addObject:[NSValue valueWithCGPoint:currentPoint]];
    }
  }
  return [resultArray copy];
}


- (CGFloat)calcXForZeroLevelWith:(CGPoint)firstLinePoint and:(CGPoint)secondLinePoint {
  /*
   Need to calculate x coordinate for line passing through two points (x1,y1) and (x2, y2):
   system of two line equations:
   y=y_z (y_z -> y_zero_level, x_z -> x_zero_level)
   y=kx + b
   Using (x1,y1) and (x2, y2) we can calculate k and b and solve system.
   x_z = (x2*(y_z - y1) - x1*(yz - y2)) / (y2 - y1)
   */
  return (secondLinePoint.x*(self.yZeroLevel - firstLinePoint.y) - firstLinePoint.x*(self.yZeroLevel - secondLinePoint.y)) /
                (secondLinePoint.y - firstLinePoint.y);
}

- (void)drawMarkers {
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSaveGState(context);
  CGContextSetFillColorWithColor(context, [self.style.chartLineColor CGColor]);

  
  CGFloat markerRadius = 4.0;
  
  for (NSUInteger i = 0; i < self.chartPoints.count; ++i) {

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
