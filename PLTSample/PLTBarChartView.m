//
//  PLTBarChart.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTBarChartView.h"
#import "PLTBarChartStyle.h"
#import "NSArray+SortAndRemove.h"
#import "PLTMarker.h"
#import "PLTPinView.h"

typedef __kindof NSArray<NSValue *> ChartPoints;
typedef NSDictionary<NSString *,NSArray<NSNumber *> *> ChartData;

@interface PLTBarChartView ()

@property(nonatomic, strong, nonnull) PLTBarChartStyle *style;
@property(nonatomic, strong) ChartPoints *chartPoints;
@property(nonatomic, strong, nullable) ChartData *chartData;
@property(nonatomic) CGFloat yZeroLevel;

@end


@implementation PLTBarChartView

@synthesize styleSource;
@synthesize dataSource;
@synthesize chartData;
@synthesize style = _style;
@synthesize chartPoints;
@synthesize yZeroLevel = _yZeroLevel;
@synthesize isPinAvailable = _isPinAvailable;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    
    _yZeroLevel = 0.0;
    _style = [PLTBarChartStyle blank];
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
  PLTBarChartStyle *newStyle = (PLTBarChartStyle *)[[self.styleSource styleContainer] chartStyle];
  
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
    [self drawBars:rect];
  }
}

- (void)drawBars:(CGRect)rect {
  self.chartPoints = [self prepareChartPoints:rect];
  
  CGFloat barWidth = (CGRectGetWidth(self.frame) - 2*kPLTYOffset)/(2*self.chartPoints.count);
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  CGContextSetFillColorWithColor(context, [[self.style chartLineColor] CGColor]);
  
  for (NSValue *pointContainer in self.chartPoints) {
    CGPoint currentPoint = [pointContainer CGPointValue];
    CGFloat yBarOrigin;
    CGFloat barHeight;
    if (currentPoint.y > self.yZeroLevel) {
      yBarOrigin = self.yZeroLevel;
      barHeight = yBarOrigin - self.yZeroLevel;
      
    }
    else {
      yBarOrigin = currentPoint.y;
      barHeight = self.yZeroLevel - currentPoint.y;
    }
    CGRect currentBar = CGRectMake( currentPoint.x, yBarOrigin, barWidth, barHeight);
    CGContextFillRect(context, currentBar);
  }
  
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
  
  CGFloat deltaX = (width - 2*kPLTXOffset) / xIntervalCount;
#if (CGFLOAT_IS_DOUBLE == 1)
  CGFloat deltaY = (height - 2*kPLTYOffset) / (max + fabs(min));
#else
  CGFloat deltaY = (height - 2*kPLTYOffset) / (max + fabsf(min));
#endif
  self.yZeroLevel = height - ((- min)*deltaY + kPLTYOffset);// 0(value) -> y(zero level)
  
  ChartPoints *points = [NSMutableArray<NSValue *> arrayWithCapacity:xComponents.count];
  
  if (xComponents.count == yComponents.count) {
    for (NSUInteger i=0; i < xComponents.count; ++i) {
      [points addObject:
       [NSValue valueWithCGPoint:
        CGPointMake(leftEdgeX + i*deltaX + kPLTXOffset,
                    height - (([yComponents[i] plt_CGFloatValue] - min)*deltaY + kPLTYOffset))]];
    }
  }
  return [points copy];
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

@end
