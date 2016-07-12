//
//  PLTLinearChartStyle.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 06.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLinearChartStyle.h"

NSString *_Nonnull pltStringFromLineatChartAnimation(PLTLinearChartAnimation animation){
  switch (animation) {
    case PLTLinearChartAnimationNone: {
      return @"PLTLinearChartAnimationNone";
    }
    case PLTLinearChartAnimationAxisX: {
      return @"PLTLinearChartAnimationAxisX";
    }
    case PLTLinearChartAnimationAxisY: {
      return @"PLTLinearChartAnimationAxisY";
    }
    case PLTLinearChartAnimationAxisXY: {
      return @"PLTLinearChartAnimationAxisXY";
    }
  }
}

NSString *_Nonnull pltStringFromLinearChartInterpolation(PLTLinearChartInterpolation interpolation){
  switch (interpolation) {
    case PLTLinearChartInterpolationLinear: {
      return @"PLTLinearChartInterpolationLinear";
    }
    case PLTLinearChartInterpolationSpline: {
      return @"PLTLinearChartInterpolationSpline";
    }
  }
}

@implementation PLTLinearChartStyle

@synthesize hasFilling = _hasFilling;
@synthesize hasMarkers = _hasMarkers;
@synthesize animation = _animation;
@synthesize interpolationStrategy = _interpolationStrategy;
@synthesize chartLineColor = _chartLineColor;
@synthesize markerType = _markerType;
@synthesize lineWeight = _lineWeight;

#pragma mark - Initialization

- (nonnull instancetype)init {
  self = [super init];
  if (self) {
    _lineWeight = 2.0;
    _hasFilling = NO;
    _hasMarkers = YES;
    _animation = PLTLinearChartAnimationNone;
    _interpolationStrategy = PLTLinearChartInterpolationLinear;
    _chartLineColor = [UIColor blueColor];
    _markerType = PLTMarkerCircle;
  }
  
  return self;
}

#pragma mark - Decription

- (NSString *)description{
  return [NSString stringWithFormat:@"<%@: %p \n\
          Has filling = %@ \n\
          Has markers = %@ \n\
          Marker type = %@ \n\
          Animation = %@ \n\
          Interpolation = %@ \n\
          Chart line color = %@ \n\
          Line weight = %@>",
          self.class,
          (void *)self,
          self.hasFilling?@"YES":@"NO",
          self.hasMarkers?@"YES":@"NO",
          pltStringFromMarkerType(self.markerType),
          pltStringFromLineatChartAnimation(self.animation),
          pltStringFromLinearChartInterpolation(self.interpolationStrategy),
          self.chartLineColor,
          @(self.lineWeight)
          ];
}

#pragma mark - Styles

+ (nonnull instancetype)blank {
  return [PLTLinearChartStyle new];
}

@end
