//
//  PLTBarConfig.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 15.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTBarConfig.h"

@implementation PLTBarConfig

// FIXME: Change design. [PLTBarConfig new] is temporary stub.
+ (nonnull instancetype)blank {
  PLTBarConfig *config = [PLTBarConfig new];
  config.verticalGridlineEnable = NO;
  return config;
}

+ (nonnull instancetype)math {
  PLTBarConfig *config = [PLTBarConfig new];
  config.verticalGridlineEnable = NO;
  return config;
}

+ (nonnull instancetype)stocks {
  PLTBarConfig *config = [PLTBarConfig new];
  config.verticalGridlineEnable = NO;
  return config;
}

+ (nonnull instancetype)blackAndGray {
  PLTBarConfig *config = [PLTBarConfig new];
  config.verticalGridlineEnable = NO;
  return config;
}

@end
