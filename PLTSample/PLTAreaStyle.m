//
//  PLTAreaStyle.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 22.03.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import "PLTAreaStyle.h"

@implementation PLTAreaStyle

@synthesize areaColor;

#pragma mark - Static

+ (nonnull PLTAreaStyle *)blank {
  PLTAreaStyle *style = [PLTAreaStyle new];
  style.areaColor = [UIColor whiteColor];
  return style;
}

+ (nonnull PLTAreaStyle *)defaultStyle {
  PLTAreaStyle *style = [PLTAreaStyle new];
  style.areaColor = [UIColor whiteColor];
  return style;
}

@end
