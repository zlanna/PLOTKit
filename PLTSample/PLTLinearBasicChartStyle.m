//
//  PLTLinearBasicChartStyle.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 13.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLinearBasicChartStyle.h"
#import "PLTMarker.h"

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

@interface PLTLinearBasicChartStyle ()

@property(nonatomic) BOOL hasFilling;
@property(nonatomic) BOOL hasMarkers;
@property(nonatomic) PLTLinearChartAnimation animation;
@property(nonatomic) PLTLinearChartInterpolation interpolationStrategy;
@property(nonatomic, strong, nonnull) UIColor *chartColor;
@property(nonatomic) PLTMarkerType markerType;
@property(nonatomic) CGFloat lineWeight;

@end


@implementation PLTLinearBasicChartStyle

@synthesize hasFilling = _hasFilling;
@synthesize hasMarkers = _hasMarkers;
@synthesize animation = _animation;
@synthesize interpolationStrategy = _interpolationStrategy;
@synthesize chartColor = _chartColor;
@synthesize markerType = _markerType;
@synthesize lineWeight = _lineWeight;

#pragma mark - Initialization

- (nonnull instancetype)init {
  self = [super init];
  if (self) {
    _lineWeight = 0.0;
    _hasFilling = NO;
    _hasMarkers = NO;
    _animation = PLTLinearChartAnimationNone;
    _interpolationStrategy = PLTLinearChartInterpolationLinear;
    _chartColor = [UIColor blueColor];
    _markerType = PLTMarkerCircle;
  }
  
  return self;
}

@end
