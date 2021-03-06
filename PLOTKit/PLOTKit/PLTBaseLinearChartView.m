//
//  PLTBaseLinearChartView.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 14.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//
#import "PLTBaseLinearChartView.h"
#import "PLTLinearChartStyle.h"
#import "NSArray+SortAndRemove.h"
#import "PLTMarker.h"
#import "PLTPinView.h"
#import "PLTSpline.h"

NSString *const kPLTXAxis = @"X";
NSString *const kPLTYAxis = @"Y";

const CGFloat kPLTChartExpansion = 10;

typedef __kindof NSArray<NSValue *> ChartPoints;
typedef NSDictionary<NSString *,NSArray<NSNumber *> *> ChartData;

@interface PLTBaseLinearChartView ()<PLTPinViewDataSource>

@property(nonatomic, weak, nullable) id<PLTLinearStyleSource> styleSource;

@property(nonatomic, strong, nonnull) PLTLinearChartStyle *style;
@property(nonatomic, strong) ChartPoints *chartPoints;
@property(nonatomic, strong) ChartPoints *intercalaryChartPoints;
@property(nonatomic, strong, nullable) ChartData *chartData;
@property(nonnull, nonatomic, strong) PLTPinView *pinView;
@property(nonatomic) CGFloat yZeroLevel;

@end


@implementation PLTBaseLinearChartView

@synthesize style = _style;
@synthesize yZeroLevel = _yZeroLevel;
@synthesize isPinAvailable = _isPinAvailable;
@synthesize chartExpansion = _chartExpansion;

@synthesize styleSource;
@synthesize dataSource;

@synthesize seriesName;
@synthesize chartData;
@synthesize chartPoints;
@synthesize pinView;
@synthesize intercalaryChartPoints;

#pragma mark - Initialization

- (null_unspecified instancetype)init {
  self = [super initWithFrame:CGRectZero];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    
    _chartExpansion = kPLTChartExpansion;
    _yZeroLevel = 0.0;
    _style = [PLTLinearChartStyle blank];
    _isPinAvailable = YES;
    
  }
  return self;
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
    self.chartPoints = [self prepareChartPoints:rect];
    if ([self.chartData[kPLTXAxis] count] > 1) {
      switch(self.style.interpolationStrategy) {
        case PLTLinearChartInterpolationLinear: {
          self.intercalaryChartPoints = self.chartPoints;
          break;
        }
        case PLTLinearChartInterpolationSpline: {
          PLTSpline *spline = [[PLTSpline alloc] init];
          self.intercalaryChartPoints = [spline interpolatedChartPoints:self.chartPoints];
          break;
        }
      }
      [self drawLine];
      
      if (self.style.hasFilling) {
        [self drawFill:rect];
      }
      
      if (self.style.hasMarkers) {
        [self drawMarkers];
      }
      
      if (self.isPinAvailable) {
        [self drawPin];
      }
    }
    else {
      [self drawPoint:rect];
    }
  }
}

- (void)drawPin {
  // FIXME: Fix pinView and pin's frame initialization
  CGRect pinViewFrame = CGRectMake(self.bounds.origin.x,
                                   self.bounds.origin.y - 20,
                                   self.bounds.size.width,
                                   self.bounds.size.height + 20);
  self.pinView = [[PLTPinView alloc] initWithFrame: pinViewFrame];
  self.pinView.dataSource = self;
  self.pinView.pinColor = self.style.chartColor;
  [self addSubview: self.pinView];
}

- (void)drawPoint:(CGRect)rect {
  NSArray<NSNumber *> *yComponents = self.chartData[kPLTYAxis];
  
  NSArray *dataLevels = [self.dataSource yDataSet];
  CGFloat min = [dataLevels[0] plt_CGFloatValue];
  CGFloat max = [dataLevels.lastObject plt_CGFloatValue];
  
  CGFloat leftEdgeX = CGRectGetMinX(rect);
  CGFloat height = CGRectGetHeight(rect);
#if (CGFLOAT_IS_DOUBLE == 1)
  CGFloat deltaY = (height - 2*self.chartExpansion) / (max + fabs(min));
#else
  CGFloat deltaY = (height - 2*self.chartExpansion) / (max + fabsf(min));
#endif
  CGPoint point = CGPointMake(leftEdgeX + self.chartExpansion,
                              height - (([yComponents[0] plt_CGFloatValue] - min)*deltaY + self.chartExpansion));
  self.chartPoints = [NSMutableArray<NSValue *> arrayWithObject:[NSValue valueWithCGPoint:point]];
  self.intercalaryChartPoints = self.chartPoints;
  [self drawMarkers];
}

- (void)drawLine {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  CGContextSetStrokeColorWithColor(context, [self.style.chartColor CGColor]);
  CGContextSetLineWidth(context, self.style.lineWeight);
  
  CGPoint currentPoint = [self.intercalaryChartPoints[0] CGPointValue];
  CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);
  for (NSValue *pointContainer in self.intercalaryChartPoints) {
    CGPoint nextPoint = [pointContainer CGPointValue];
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
        CGPointMake(leftEdgeX + i*deltaX + self.chartExpansion,
                    height - (([yComponents[i] plt_CGFloatValue] - min)*deltaY + self.chartExpansion))]];
    }
  }
  return [points copy];
}

- (void)drawFill:(CGRect)rect {
  CGColorRef startColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.5] CGColor];
  CGColorRef endColor = [[self.style.chartColor colorWithAlphaComponent:0.5] CGColor];
  
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
  
  // TODO: Probably has problems with 1 or 2 values
  for (NSUInteger i=0; i<[newPoints count]; ++i) {
    CGPoint currentPoint = [newPoints[i] CGPointValue];
    if (([[NSNumber numberWithFloat:currentPoint.y] isEqualToNumber:[NSNumber numberWithFloat:self.yZeroLevel]]) ||
        (i == [newPoints count]-1)) {
      // FIXME: Temporary solution
      if (i!=0) {
        if ([newPoints[i-1] CGPointValue].y > self.yZeroLevel) {
          gradientStartPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
          gradientEndPoint = CGPointMake(CGRectGetMidX(rect), self.yZeroLevel);
        }
        else {
          gradientStartPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
          gradientEndPoint = CGPointMake(CGRectGetMidX(rect), self.yZeroLevel);
        }
      }
      else {
        if (currentPoint.x > self.yZeroLevel) {
          gradientStartPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
          gradientEndPoint = CGPointMake(CGRectGetMidX(rect), self.yZeroLevel);
        }
        else {
          gradientStartPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
          gradientEndPoint = CGPointMake(CGRectGetMidX(rect), self.yZeroLevel);
        }
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
  
  CGPoint initialPoint = [self.intercalaryChartPoints[0] CGPointValue];
  [resultArray addObject:[NSValue valueWithCGPoint:initialPoint]];
  
  BOOL largerThanZero = (initialPoint.y>self.yZeroLevel);
  
  for (NSUInteger i=1; i<[self.intercalaryChartPoints count]; ++i) {
    CGPoint currentPoint = [self.intercalaryChartPoints[i] CGPointValue];
    CGPoint previousPoint = [self.intercalaryChartPoints[i-1] CGPointValue];
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
                          CGPointMake([self.intercalaryChartPoints.lastObject CGPointValue].x, self.yZeroLevel)]];
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
  PLTMarker *marker = [PLTMarker markerWithType:self.style.markerType];
  marker.color = self.style.chartColor;
  marker.size = self.style.markerSize;
  
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
  // TODO: Add tests for empty array and boundary conditions
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
