//
//  UIColor+PresetColors.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 04.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "UIColor+PresetColors.h"

@implementation UIColor (PresetColors)

+ (nonnull NSArray<UIColor *> *)presetColors{
  return @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor cyanColor],
           [UIColor yellowColor], [UIColor magentaColor], [UIColor orangeColor], [UIColor purpleColor],
           [UIColor brownColor]];
}

@end
