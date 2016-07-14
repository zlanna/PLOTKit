//
//  PLTLinearConfig.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 27.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLinearConfig.h"

@implementation PLTLinearConfig
//  Chart config
@synthesize chartHasFilling = _chartHasFilling;
@synthesize chartHasMarkers = _chartHasMarkers;
@synthesize chartMarkerType = _chartMarkerType;
@synthesize chartLineWeight = _chartLineWeight;
@synthesize chartInterpolation = _chartInterpolation;

#pragma mark - Initialization

- (null_unspecified instancetype)init {
  self = [super init];
  if (self) {
    _chartHasMarkers = YES;
    _chartHasFilling = YES;
    _chartMarkerType = PLTMarkerCircle;
    _chartLineWeight = 2.0;
    _chartInterpolation = PLTLinearChartInterpolationSpline;
  }
  return self;
}

#pragma mark - Configurations

+ (nonnull instancetype)blank {
  PLTLinearConfig *config = [super new];
  return config;
}

+ (nonnull instancetype)math {
  PLTLinearConfig *config = [super math];
  config.chartHasMarkers = NO;
  config.chartHasFilling = NO;
  return config;
}

+ (nonnull instancetype)stocks {
  PLTLinearConfig *config = [super stocks];
  config.chartHasMarkers = YES;
  config.chartHasFilling = YES;
  config.chartMarkerType = PLTMarkerSquare;
  return config;
}

+ (nonnull instancetype)blackAndGray{
  PLTLinearConfig *config = [super blackAndGray];
  config.chartHasMarkers = NO;
  config.chartHasFilling = YES;
  config.chartMarkerType = PLTMarkerCircle;
  return config;
}

@end
