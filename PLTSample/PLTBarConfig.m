//
//  PLTBarConfig.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 15.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTBarConfig.h"

@implementation PLTBarConfig

// TODO: Изменить дизайн, чтоб обойтись без вот такого
+ (nonnull instancetype)blank {
  PLTBarConfig *config = [super blank];
  config.verticalGridlineEnable = NO;
  return config;
}

+ (nonnull instancetype)math {
  PLTBarConfig *config = [super blank];
  config.verticalGridlineEnable = NO;
  return config;
}

+ (nonnull instancetype)stocks {
  PLTBarConfig *config = [super blank];
  config.verticalGridlineEnable = NO;
  return config;
}

+ (nonnull instancetype)blackAndGray {
  PLTBarConfig *config = [super blank];
  config.verticalGridlineEnable = NO;
  return config;
}

@end
