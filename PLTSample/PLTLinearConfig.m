//
//  PLTLinearConfig.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 27.03.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import "PLTLinearConfig.h"

@implementation PLTLinearConfig

+ (PLTLinearConfig *)math {
  PLTLinearConfig *config = [PLTLinearConfig new];
  return config;
}

+ (PLTLinearConfig *)stocks {
  PLTLinearConfig *stocks = [PLTLinearConfig new];
  return stocks;
}

@end
