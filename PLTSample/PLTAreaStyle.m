//
//  PLTAreaStyle.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 22.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAreaStyle.h"

@implementation PLTAreaStyle

@synthesize areaColor;

#pragma mark - Static

+ (nonnull instancetype)blank {
  PLTAreaStyle *style = [PLTAreaStyle new];
  style.areaColor = [UIColor whiteColor];
  return style;
}

+ (nonnull instancetype)defaultStyle {
  PLTAreaStyle *style = [PLTAreaStyle new];
  style.areaColor = [UIColor whiteColor];
  return style;
}

@end
