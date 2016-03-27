//
//  PLTLinearChartStyle.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 06.02.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import "PLTLinearChartStyle.h"

@implementation PLTLinearChartStyle

@synthesize hasFilling = _hasFilling;
@synthesize hasMarkers = _hasMarkers;
@synthesize animation = _animation;
@synthesize interpolationStrategy = _interpolationStrategy;
@synthesize chartLineColor = _chartLineColor;

#pragma mark - Initialization

- (nonnull instancetype)init {

  if (self = [super init]) {
    _hasFilling = YES;
    _hasMarkers = YES;
    _animation = PLTLinearChartAnimationNone;
    _interpolationStrategy = PLTLinearChartInterpolationLinear;
    _chartLineColor = [UIColor greenColor];
  }
  
  return self;
}

#pragma mark - Static

+ (nonnull PLTLinearChartStyle *)blank {
  return [PLTLinearChartStyle new];
}

+ (nonnull PLTLinearChartStyle *)defaultStyle {
  return [PLTLinearChartStyle new];
}

@end
