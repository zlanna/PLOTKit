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
#import "PLTMarker.h"
#import "PLTPinView.h"

NSString *const kPLTXAxis = @"X";
NSString *const kPLTYAxis = @"Y";

typedef __kindof NSArray<NSValue *> ChartPoints;
typedef NSDictionary<NSString *,NSArray<NSNumber *> *> ChartData;

@interface PLTLinearChartView ()<PLTPinViewDataSource>

@property(nonatomic, strong, nonnull) PLTLinearChartStyle *style;
@property(nonatomic, strong) ChartPoints *chartPoints;
@property(nonatomic, strong, nullable) ChartData *chartData;
@property(nonnull, nonatomic, strong) PLTPinView *pinView;
@property(nonatomic) CGFloat yZeroLevel;
@property(nonatomic) CGFloat chartExpansion;

@end


@implementation PLTLinearChartView

@synthesize seriesName = _seriesName;
@synthesize styleSource;
@synthesize dataSource;
@synthesize chartData;
@synthesize style = _style;
@synthesize chartPoints;
@synthesize yZeroLevel = _yZeroLevel;
@synthesize pinView;
@synthesize isPinAvailable = _isPinAvailable;
@synthesize chartExpansion = _chartExpansion;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    
    _yZeroLevel = 0.0;
    _chartExpansion = 10.0;
    _style = [PLTLinearChartStyle blank];
    _isPinAvailable = YES;
  
  }
  return self;
}

- (null_unspecified instancetype)init {
  return [self initWithFrame:kPLTDefaultFrame];
}

#pragma mark - View lifecycle

- (void)setNeedsDisplay {
  [super setNeedsDisplay];
  PLTLinearChartStyle *newStyle = [[self.styleSource styleContainer] chartStyleForSeries:self.seriesName];
  
  if (newStyle) {
    self.style = newStyle;
  }
  
  if (self.dataSource) {
    self.chartData = [self.dataSource chartDataSetForSeries:self.seriesName];
  }
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
  if (self.chartData) {
    if ([self.chartData[kPLTXAxis] count] > 1) {
      [self drawLine:rect];
      
      if (self.style.hasFilling) {
        [self drawFill:rect];
      }
      
      if (self.style.hasMarkers) {
        [self drawMarkers];
      }
      
      if (self.isPinAvailable) {
        // FIXME: Избавиться от такой дурацкой инициализации фрейма
        CGRect pinViewFrame = CGRectMake(self.bounds.origin.x,
                                         self.bounds.origin.y - 20,
                                         self.bounds.size.width,
                                         self.bounds.size.height + 20);
        self.pinView = [[PLTPinView alloc] initWithFrame: pinViewFrame];
        self.pinView.dataSource = self;
        [self addSubview: self.pinView];
      }
    }
    else {
      [self drawPoint:rect];
    }
  }
}

- (void)drawPoint:(CGRect)rect {
  NSArray<NSNumber *> *yComponents = self.chartData[kPLTYAxis];
  
  NSArray *dataLevels = [self.dataSource yDataSet];
  CGFloat min = [dataLevels[0] plt_CGFloatValue];
  CGFloat max = [dataLevels.lastObject plt_CGFloatValue];
  
  CGFloat leftEdgeX = CGRectGetMinX(rect);
  CGFloat height = CGRectGetHeight(rect);
#if (CGFLOAT_IS_DOUBLE == 1)
  CGFloat deltaY = (heigh - 2*self.chartExpansion) / (max + fabs(min));
#else
  CGFloat deltaY = (height - 2*self.chartExpansion) / (max + fabsf(min));
#endif
  CGPoint point = CGPointMake(leftEdgeX + self.chartExpansion,
                              height - (([yComponents[0] plt_CGFloatValue] - min)*deltaY + self.chartExpansion));
  self.chartPoints = [NSMutableArray<NSValue *> arrayWithObject:[NSValue valueWithCGPoint:point]];
  [self drawMarkers];
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
    // TODO: Add code for nonlinear interpolation
    CGContextAddLineToPoint(context, nextPoint.x, nextPoint.y);
  }
  
  CGContextStrokePath(context);
  CGContextRestoreGState(context);
}

- (ChartPoints *)prepareChartPoints:(CGRect)rect {
  NSArray<NSNumber *> *xComponents = self.chartData[kPLTXAxis];
  NSArray<NSNumber *> *yComponents = self.chartData[kPLTYAxis];
  
  NSUInteger xIntervalCount = [self.chartData[kPLTXAxis] count] - 1;
  
  NSArray *dataLevels = [self.dataSource yDataSet];
  CGFloat min = [dataLevels[0] plt_CGFloatValue];
  CGFloat max = [dataLevels.lastObject plt_CGFloatValue];
  
  CGFloat leftEdgeX = CGRectGetMinX(rect);
  CGFloat width = CGRectGetWidth(rect);
  CGFloat height = CGRectGetHeight(rect);
  
  CGFloat deltaX = (width - 2*self.chartExpansion) / xIntervalCount;
#if (CGFLOAT_IS_DOUBLE == 1)
  CGFloat deltaY = (heigh - 2*self.chartExpansion) / (max + fabs(min));
#else
  CGFloat deltaY = (height - 2*self.chartExpansion) / (max + fabsf(min));
#endif
  self.yZeroLevel = height - ((- min)*deltaY + self.chartExpansion);// 0(value) -> y(zero level)

  ChartPoints *points = [NSMutableArray<NSValue *> arrayWithCapacity:xComponents.count];

  if (xComponents.count == yComponents.count) {
    for (NSUInteger i=0; i < xComponents.count; ++i) {
      [points addObject:
       [NSValue valueWithCGPoint:
        CGPointMake(leftEdgeX + i*deltaX + self.chartExpansion,
                    height - (([yComponents[i] plt_CGFloatValue] - min)*deltaY + self.chartExpansion))]];
    }
  }
  else {
    // TODO: Добавить выброс исключения
    /*
    @throw [NSException exceptionWithName:
     */
  }
  return [points copy];
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
  
  CGPoint gradientStartPoint;
  CGPoint gradientEndPoint;
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextBeginPath(context);
   
  ChartPoints *newPoints = [self prepareChartPartsForFilling];

  CGContextMoveToPoint(context, [newPoints[0] CGPointValue].x, self.yZeroLevel);
  
  // TODO: Тут явно могут быть проблемы с одним либо двумя значениями
  for (NSUInteger i=0; i<[newPoints count]; ++i) {
    CGPoint currentPoint = [newPoints[i] CGPointValue];
    if (([[NSNumber numberWithFloat:currentPoint.y] isEqualToNumber:[NSNumber numberWithFloat:self.yZeroLevel]]) ||
       (i == [newPoints count]-1)) {
      // FIXME: Это временное решение для проверки концепции
      if ([newPoints[i-1] CGPointValue].y > self.yZeroLevel) {
        gradientStartPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
        gradientEndPoint = CGPointMake(CGRectGetMidX(rect), self.yZeroLevel);
      }
      else {
        gradientStartPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
        gradientEndPoint = CGPointMake(CGRectGetMidX(rect), self.yZeroLevel);
      }
      
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
  [resultArray addObject:[NSValue valueWithCGPoint:initialPoint]];
  
  BOOL largerThanZero = (initialPoint.y>self.yZeroLevel);

  for (NSUInteger i=1; i<[self.chartPoints count]; ++i) {
    CGPoint currentPoint = [self.chartPoints[i] CGPointValue];
    CGPoint previousPoint = [self.chartPoints[i-1] CGPointValue];
    if ((currentPoint.y<self.yZeroLevel && largerThanZero) ||
        (currentPoint.y>self.yZeroLevel && !largerThanZero)) {
      CGFloat xForZeroLevel = [self calcXForZeroLevelWith:previousPoint and:currentPoint];
      CGPoint zeroPoint = CGPointMake(xForZeroLevel, self.yZeroLevel);
      [resultArray addObject:[NSValue valueWithCGPoint:zeroPoint]];
      [resultArray addObject:[NSValue valueWithCGPoint:currentPoint]];
      largerThanZero = (currentPoint.y>self.yZeroLevel)?YES:NO;
    }
    else {
      [resultArray addObject:[NSValue valueWithCGPoint:currentPoint]];
    }
  }
  //Closing figure, add last zero point
  [resultArray addObject:[NSValue valueWithCGPoint:
                          CGPointMake([self.chartPoints.lastObject CGPointValue].x, self.yZeroLevel)]];
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
  return (secondLinePoint.x*(self.yZeroLevel - firstLinePoint.y) -
            firstLinePoint.x*(self.yZeroLevel - secondLinePoint.y)) / (secondLinePoint.y - firstLinePoint.y);
}

- (void)drawMarkers {
  PLTMarker *marker = [PLTMarker markerWithType:PLTMarkerSquare];
  marker.color = self.style.chartLineColor;
  marker.size = 4.0;
  
  CGImageRef cgMarkerImage = marker.markerImage.CGImage;
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  for (NSUInteger i = 0; i < self.chartPoints.count; ++i){
    CGPoint currentPoint = [self.chartPoints[i] CGPointValue];
    CGRect markerRect = CGRectMake(currentPoint.x - marker.size,
                                   currentPoint.y - marker.size,
                                   2*marker.size,
                                   2*marker.size);
    CGContextDrawImage(context, markerRect, cgMarkerImage);
  }
}

#pragma mark - PLTPinViewDataSource

- (NSUInteger)closingSignicantPointIndexForPoint:(CGPoint)currentPoint {
  NSUInteger xIntervalCount = [self.chartData[kPLTXAxis] count] - 1;
  CGFloat deltaX = CGRectGetWidth(self.frame) / xIntervalCount;
  NSUInteger pointIndex;
  // TODO: Проверки массива на пустоту, нужно тесты написать, посмотреть вообще граничные условия
  if (currentPoint.x < [self.chartPoints[0] CGPointValue].x) {
    pointIndex = 0;
  }
  else if (currentPoint.x > [self.chartPoints.lastObject CGPointValue].x) {
    pointIndex = self.chartPoints.count - 1;
  }
  else {
    pointIndex = [self.chartPoints indexOfObject:[NSValue valueWithCGPoint:currentPoint]
                                   inSortedRange: NSMakeRange(0, [self.chartPoints count])
                                         options: NSBinarySearchingFirstEqual
                                 usingComparator:^(NSValue *pointContainer1, NSValue *pointContainer2){
                                   if ((pointContainer2.CGPointValue.x >= (pointContainer1.CGPointValue.x - deltaX/2)) &&
                                       (pointContainer2.CGPointValue.x < (pointContainer1.CGPointValue.x + deltaX/2))) {
                                     return NSOrderedSame;
                                   }
                                   else if (pointContainer2.CGPointValue.x < (pointContainer1.CGPointValue.x - deltaX/2)) {
                                     return NSOrderedDescending;
                                   }
                                   else {
                                     return NSOrderedAscending;
                                   }
                                 }];
  }
  return pointIndex;
}

- (NSUInteger)pointsCount{
  return [self.chartPoints count];
}

- (CGPoint)pointForIndex:(NSUInteger)pointIndex {
  return [self.chartPoints[pointIndex] CGPointValue];
}

- (nullable NSNumber *)valueForIndex:(NSUInteger)valueIndex {
  return self.chartData[kPLTYAxis][valueIndex];
}

@end
