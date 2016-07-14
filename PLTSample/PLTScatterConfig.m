//
//  PLTScatterConfig.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 14.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTScatterConfig.h"

@implementation PLTScatterConfig
//  Chart config
@synthesize chartMarkerType = _chartMarkerType;

#pragma mark - Initialization

- (null_unspecified instancetype)init {
  self = [super init];
  if (self) {
    _chartMarkerType = PLTMarkerCircle;
  }
  return self;
}

#pragma mark - Configurations

+ (nonnull instancetype)blank {
  PLTScatterConfig *config = [super new];
  return config;
}

+ (nonnull instancetype)math {
  PLTScatterConfig *config = [super math];
  config.chartMarkerType = PLTMarkerSquare;
  return config;
}

+ (nonnull instancetype)stocks {
  PLTScatterConfig *config = [super stocks];
  config.chartMarkerType = PLTMarkerSquare;
  return config;
}

+ (nonnull instancetype)blackAndGray{
  PLTScatterConfig *config = [super blackAndGray];
  config.chartMarkerType = PLTMarkerCircle;
  return config;
}

@end
