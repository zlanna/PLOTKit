//
//  PLTSpline.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 11.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//
// Based on https://gist.github.com/anonymous/06f4104d93f6cef6f341
// and this article https://habrahabr.ru/post/264191/

#import "PLTSpline.h"

#define EPSILON 1.0e-5
#define RESOLUTION 32

typedef NSMutableArray<NSValue *> Points;

CGPoint pltCGPointAddCGPoint(CGPoint p1, CGPoint p2) {
  return CGPointMake(p1.x + p2.x, p1.y + p2.y);
}

CGPoint pltCGPointSubstractCGPoint(CGPoint p1, CGPoint p2) {
  return CGPointMake(p1.x - p2.x, p1.y - p2.y);
}

CGPoint pltCGPointMutliplyConst(CGPoint p1, double c) {
#if (CGFLOAT_IS_DOUBLE == 1)
  return CGPointMake(c*p1.x, c*p1.y);
#else
  return CGPointMake((float)c*p1.x, (float)c*p1.y);
#endif
}

@interface PLTSegment : NSObject
@property(nonatomic, copy, nonnull) Points *points;

- (CGPoint)calcSegment:(double)t;

@end

@implementation PLTSegment
@synthesize points = _points;

- (instancetype)init{
  self = [super init];
  if (self) {
    _points = [[Points alloc] initWithCapacity:4];
  }
  return self;
}

- (CGPoint)calcSegment:(double)t {
  double x, y;
  double t2 = t * t;
  double t3 = t2 * t;
  double nt = 1.0 - t;
  double nt2 = nt * nt;
  double nt3 = nt2 * nt;
  x = nt3 * (double)self.points[0].CGPointValue.x + 3.0 * t * nt2 * (double)self.points[1].CGPointValue.x + 3.0 * t2 * nt * (double)self.points[2].CGPointValue.x + t3 * (double)self.points[3].CGPointValue.x;
  y = nt3 * (double)self.points[0].CGPointValue.y + 3.0 * t * nt2 * (double)self.points[1].CGPointValue.y + 3.0 * t2 * nt * (double)self.points[2].CGPointValue.y + t3 * (double)self.points[3].CGPointValue.y;
  return CGPointMake(x, y);
}

@end

@interface PLTSpline ()
@property(nonatomic, strong, nonnull) NSMutableArray<PLTSegment *> *bezier;
@end


@implementation PLTSpline

@synthesize bezier = _bezier;

- (instancetype)init {
  self = [super init];
  if (self) {
    _bezier = [[NSMutableArray alloc] init];
  }
  return self;
}

- (nonnull NSArray<NSValue *> *)interpolatedChartPoints:(nonnull NSArray<NSValue *> *)chartPoints {
  BOOL isSplineBuilded = [self calculateSpline:[chartPoints mutableCopy]];
  if (isSplineBuilded){
    NSMutableArray<NSValue *> *newChartPoints = [[NSMutableArray alloc] init];
    for (PLTSegment *segment in self.bezier)
    {
      for (int i = 0; i < RESOLUTION; ++i)
      {
        CGPoint point = [segment calcSegment:(double)i / (double)RESOLUTION];
        [newChartPoints addObject:[NSValue valueWithCGPoint:point]];
      }
    }
    
    return [newChartPoints copy];
  }
  else {
    return chartPoints;
  }
}

- (BOOL)calculateSpline:(Points *)points {
  NSUInteger n = points.count - 1;
  if (n < 2) {
    NSLog(@"Couldn't build spline. Not enought points.");
    return NO;
  }
  CGPoint tgL = CGPointMake(0, 0);
  CGPoint tgR = CGPointMake(0, 0);
  CGPoint cur = CGPointMake(0, 0);
  CGPoint next = pltCGPointSubstractCGPoint(points[1].CGPointValue, points[0].CGPointValue);
  next = [self normalize:next];
  
  double l1, l2, tmp, x;
  
  --n;
  
  for (NSUInteger i = 0; i < n; ++i)
  {
    PLTSegment *segment = [[PLTSegment alloc] init];
    segment.points[0] = points[i];
    segment.points[1] = points[i];
    segment.points[2] = points[i+1];
    segment.points[3] = points[i+1];
    
    cur = next;
    next = pltCGPointSubstractCGPoint(points[i + 2].CGPointValue, points[i + 1].CGPointValue);
    next = [self normalize: next];
    
    tgR = pltCGPointAddCGPoint(cur, next);
    tgR = [self normalize:tgR];
    tgL = tgR;
    
    if (fabs((double)(points[i + 1].CGPointValue.y - points[i].CGPointValue.y)) < EPSILON)
    {
      l1 = l2 = 0.0;
    }
    else
    {
      tmp = (double)(points[i + 1].CGPointValue.x - points[i].CGPointValue.x);
      l1 = fabs((double)tgL.x) > EPSILON ? tmp / (2.0 * (double)tgL.x) : 1.0;
      l2 = fabs((double)tgR.x) > EPSILON ? tmp / (2.0 * (double)tgR.x) : 1.0;
    }
    
    if (fabs((double)tgL.x) > EPSILON && fabs((double)tgR.x) > EPSILON)
    {
      tmp = (double)(tgL.y / tgL.x - tgR.y / tgR.x);
      if (fabs(tmp) > EPSILON)
      {
        x = (double)(points[i + 1].CGPointValue.y - tgR.y / tgR.x * points[i + 1].CGPointValue.x - points[i].CGPointValue.y + tgL.y / tgL.x * points[i].CGPointValue.x) / tmp;
        if (x > (double)points[i].CGPointValue.x && x < (double)points[i + 1].CGPointValue.x)
        {
          if ((double)tgL.y > 0.0)
          {
            if (l1 > l2)
              l1 = 0.0;
            else
              l2 = 0.0;
          }
          else
          {
            if (l1 < l2)
              l1 = 0.0;
            else
              l2 = 0.0;
          }
        }
      }
    }
    segment.points[1] = [NSValue valueWithCGPoint:pltCGPointAddCGPoint(segment.points[1].CGPointValue,
                                                                       pltCGPointMutliplyConst(tgL, l1))];
    segment.points[2] = [NSValue valueWithCGPoint:pltCGPointSubstractCGPoint(segment.points[2].CGPointValue,
                                                                      pltCGPointMutliplyConst(tgR, l2))];
    [self.bezier addObject:segment];
  }
  
  l1 = fabs((double)tgL.x) > EPSILON ? ((double)points[n + 1].CGPointValue.x - (double)points[n].CGPointValue.x) / (2.0 * (double)tgL.x) : 1.0;
  PLTSegment *segment = [[PLTSegment alloc] init];
  segment.points[0] = points[n];
  segment.points[1] = points[n];
  segment.points[2] = points[n+1];
  segment.points[3] = points[n+1];
  segment.points[1] = [NSValue valueWithCGPoint:pltCGPointAddCGPoint(segment.points[1].CGPointValue,
                                                                     pltCGPointMutliplyConst(tgR, l1))];
  
  [self.bezier addObject:segment];
  
  return YES;
}

- (CGPoint)normalize:(CGPoint)point {
  double x = (double)point.x;
  double y = (double)point.y;
  double l = sqrt(x * x + y * y);
  x /= l;
  y /= l;
  return CGPointMake(x, y);
}

@end

