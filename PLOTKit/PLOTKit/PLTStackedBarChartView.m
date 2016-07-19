//
//  PLTStackedBarChartView.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 17.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTStackedBarChartView.h"
#import "PLTBarChartStyle.h"
#import "PLTBarChartView+Protected.h"

@implementation PLTStackedBarChartView

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

@end
