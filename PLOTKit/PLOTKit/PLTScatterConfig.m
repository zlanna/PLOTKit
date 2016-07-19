//
//  PLTScatterConfig.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 14.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTScatterConfig.h"

@implementation PLTScatterConfig
//  Chart config
@synthesize chartMarkerType = _chartMarkerType;
@synthesize chartMarkerSize = _chartMarkerSize;

#pragma mark - Initialization

- (null_unspecified instancetype)init {
  self = [super init];
  if (self) {
    _chartMarkerType = PLTMarkerCircle;
    _chartMarkerSize = 6.0;
  }
  return self;
}

#pragma mark - Configurations

+ (nonnull instancetype)blank {
  PLTScatterConfig *config = [PLTScatterConfig new];
  return config;
}

+ (nonnull instancetype)math {
  PLTScatterConfig *config = [PLTScatterConfig new];
  config.chartMarkerType = PLTMarkerSquare;
  return config;
}

+ (nonnull instancetype)stocks {
  PLTScatterConfig *config = [PLTScatterConfig new];
  config.chartMarkerType = PLTMarkerSquare;
  return config;
}

+ (nonnull instancetype)blackAndGray{
  PLTScatterConfig *config = [PLTScatterConfig new];
  config.chartMarkerType = PLTMarkerCircle;
  return config;
}

@end
