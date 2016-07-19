//
//  PLTBarChartView.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//
#import "PLTBarChartView.h"
#import "PLTBarChartStyle.h"
#import "PLTPinView.h"

typedef __kindof NSArray<NSValue *> ChartPoints;
typedef NSDictionary<NSString *,NSArray<NSNumber *> *> ChartData;

@interface PLTBarChartView ()

@property(nonatomic, strong, nonnull) PLTBarChartStyle *style;
@property(nonatomic, strong) ChartPoints *chartPoints;
@property(nonatomic, strong, nullable) ChartData *chartData;
@property(nonatomic) CGFloat yZeroLevel;
@property(nonatomic, readwrite) CGFloat constriction;

@end


@implementation PLTBarChartView

@synthesize style = _style;
@synthesize yZeroLevel = _yZeroLevel;
@synthesize chartExpansion = _chartExpansion;
@synthesize constriction = _constriction;

@synthesize styleSource;
@synthesize dataSource;
@synthesize delegate;

@synthesize chartData;
@synthesize chartPoints;
@synthesize seriesName;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    
    _chartExpansion = 10;
    _yZeroLevel = 0;
    _constriction = 0;
    _style = [PLTBarChartStyle blank];
  }
  return self;
}

- (null_unspecified instancetype)init {
  return [self initWithFrame:kPLTDefaultFrame];
}

#pragma mark - View lifecycle

- (void)setNeedsDisplay {
  [super setNeedsDisplay];
  PLTBarChartStyle *newStyle = [[self.styleSource styleContainer] chartStyleForSeries:self.seriesName];
  
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
    [self drawBars:rect];
  }
}

- (void)drawBars:(CGRect)rect {
  self.chartPoints = [self prepareChartPoints:rect];
  
  if (self.chartPoints.count == 1) {
    CGPoint singlePoint = [self.chartPoints[0] CGPointValue];
    singlePoint = CGPointMake(CGRectGetMinX(self.frame), singlePoint.y);
    self.chartPoints = [ChartPoints arrayWithObject:[NSValue valueWithCGPoint:singlePoint]];
  }
  
  NSUInteger barIndex = [self.dataSource seriesIndex:self.seriesName];
  NSUInteger barCount = [self.dataSource seriesCount];
  
  CGFloat barWidth = (CGRectGetWidth(self.frame))/((barCount+1)*self.chartPoints.count);
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  CGContextSetFillColorWithColor(context, [[self.style chartColor] CGColor]);
  
  for (NSValue *pointContainer in self.chartPoints) {
    CGPoint currentPoint = [pointContainer CGPointValue];
    CGFloat xBarOrigin = currentPoint.x - barWidth*(barCount - barIndex) + barWidth*barCount/2;
    CGFloat yBarOrigin;
    CGFloat barHeight;
    if (currentPoint.y > self.yZeroLevel) {
      yBarOrigin = self.yZeroLevel;
      barHeight = currentPoint.y - yBarOrigin;
    }
    else {
      yBarOrigin = currentPoint.y;
      barHeight = self.yZeroLevel - currentPoint.y;
    }
    CGRect currentBar = CGRectMake( xBarOrigin, yBarOrigin, barWidth, barHeight);
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
  
  NSUInteger barCount = [self.dataSource seriesCount];
  CGFloat barWidth = (CGRectGetWidth(self.frame))/((barCount+1)*xComponents.count);
  self.constriction = barWidth*barCount;
  [self.delegate addConstriction:self.constriction];

  CGFloat deltaX = (width - 2*self.chartExpansion - self.constriction) / xIntervalCount;
#if (CGFLOAT_IS_DOUBLE == 1)
  CGFloat deltaY = (height - 2*self.chartExpansion) / (max + fabs(min));
#else
  CGFloat deltaY = (height - 2*self.chartExpansion) / (max + fabsf(min));
#endif
  self.yZeroLevel = height - ((- min)*deltaY + self.chartExpansion);// 0(value) -> y(zero level)
  
  ChartPoints *points = [NSMutableArray<NSValue *> arrayWithCapacity:xComponents.count];
  
  if (xComponents.count == yComponents.count) {
    for (NSUInteger i=0; i < xComponents.count; ++i) {
      [points addObject:
       [NSValue valueWithCGPoint:
        CGPointMake(leftEdgeX + i*deltaX + self.chartExpansion + self.constriction/2,
                    height - (([yComponents[i] plt_CGFloatValue] - min)*deltaY + self.chartExpansion))]];
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
