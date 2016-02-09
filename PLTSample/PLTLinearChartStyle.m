//
//  PLTLinearChartStyle.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 06.02.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import "PLTLinearChartStyle.h"

@implementation PLTLinearChartStyle

@synthesize hasFilling;
@synthesize hasMarkers;
@synthesize animation;
@synthesize interpolationStrategy;
@synthesize chartLineColor;

#pragma mark - Initialization

- (nonnull instancetype)init {

  if (self = [super init]) {
    self.hasFilling = YES;
    self.hasMarkers = YES;
    self.animation = PLTLinearChartAnimationNone;
    self.interpolationStrategy = PLTLinearChartInterpolationLinear;
    self.chartLineColor = [UIColor greenColor];
  }
  
  return self;
}

+ (nonnull PLTLinearChartStyle *)defaultStyle{
  return [PLTLinearChartStyle new];
}

@end
