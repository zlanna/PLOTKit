//
//  PLTLinearConfig.m
//  PLOTKit
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
@synthesize chartMarkerSize = _chartMarkerSize;

#pragma mark - Initialization

- (null_unspecified instancetype)init {
  self = [super init];
  if (self) {
    _chartHasMarkers = YES;
    _chartHasFilling = YES;
    _chartMarkerType = PLTMarkerCircle;
    _chartLineWeight = 2.0;
    _chartInterpolation = PLTLinearChartInterpolationSpline;
    _chartMarkerSize = _chartLineWeight*(CGFloat)2.5;
  }
  return self;
}

#pragma mark - Configurations

+ (nonnull instancetype)blank {
  PLTLinearConfig *config = [PLTLinearConfig new];
  return config;
}

+ (nonnull instancetype)math {
  PLTLinearConfig *config = [PLTLinearConfig new];
  config.chartHasMarkers = NO;
  config.chartHasFilling = NO;
  return config;
}

+ (nonnull instancetype)stocks {
  PLTLinearConfig *config = [PLTLinearConfig new];
  config.chartHasMarkers = YES;
  config.chartHasFilling = YES;
  config.chartMarkerType = PLTMarkerSquare;
  return config;
}

+ (nonnull instancetype)blackAndGray{
  PLTLinearConfig *config = [PLTLinearConfig new];
  config.chartHasMarkers = NO;
  config.chartHasFilling = YES;
  config.chartMarkerType = PLTMarkerCircle;
  return config;
}

@end
