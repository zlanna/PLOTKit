//
//  PLTColorSheme.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 27.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTColorSheme.h"

#define RGBCOLOR(x,y,z) \
    [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]

@implementation PLTColorSheme
//  Grid color scheme
@synthesize gridVerticalLineColor = _gridVerticalLineColor;
@synthesize gridHorizontalLineColor = _gridHorizontalLineColor;
@synthesize gridBackgroundColor = _gridBackgroundColor;
@synthesize gridLabelFontColor = _gridLabelFontColor;
//  Chart color scheme
@synthesize chartLineColor = _chartLineColor;
//  Area color scheme
@synthesize areaColor = _areaColor;
//  Axis color scheme
@synthesize axisXColor = _axisXColor;
@synthesize axisYColor = _axisYColor;

#pragma mark - Initialization

- (instancetype)init {
  self = [super init];
  if (self) {
    _gridHorizontalLineColor = [UIColor blackColor];
    _gridVerticalLineColor = [_gridHorizontalLineColor copy];
    _gridBackgroundColor = [UIColor whiteColor];
    _gridLabelFontColor = [UIColor blackColor];
    _chartLineColor = [UIColor blueColor];
    _areaColor = [_gridBackgroundColor copy];
    _axisXColor = [_gridHorizontalLineColor copy];
    _axisYColor = [_axisXColor copy];
  }
  return self;
}

#pragma mark - Schemes

+ (nonnull instancetype)blank {
  PLTColorSheme *colorSheme = [PLTColorSheme new];
  return colorSheme;
}

+ (nonnull instancetype)math {
  PLTColorSheme *colorSheme = [PLTColorSheme new];
  colorSheme.gridHorizontalLineColor = [UIColor lightGrayColor];
  colorSheme.gridVerticalLineColor = [colorSheme.gridHorizontalLineColor copy];
  colorSheme.gridBackgroundColor = [UIColor whiteColor];
  colorSheme.gridLabelFontColor = [UIColor blackColor];
  colorSheme.chartLineColor = [UIColor blueColor];
  colorSheme.areaColor = [colorSheme.gridBackgroundColor copy];
  colorSheme.axisXColor = [UIColor blackColor];
  colorSheme.axisYColor = [colorSheme.axisXColor copy];
  return colorSheme;
}

+ (nonnull instancetype)cobalt {
  PLTColorSheme *colorSheme = [PLTColorSheme new];
  colorSheme.gridHorizontalLineColor = RGBCOLOR(255.0, 191.0, 54.0);
  colorSheme.gridVerticalLineColor = [colorSheme.gridHorizontalLineColor copy];
  colorSheme.gridBackgroundColor = RGBCOLOR(0.0, 34.0, 64.0);
  colorSheme.gridLabelFontColor = RGBCOLOR(256.0, 170.0, 28.0);
  colorSheme.chartLineColor = RGBCOLOR(58.0, 217.0, 0.0);
  colorSheme.areaColor = [colorSheme.gridBackgroundColor copy];
  colorSheme.axisXColor = RGBCOLOR(246.0, 170.0, 17.0);
  colorSheme.axisYColor = [colorSheme.axisXColor copy];
  return colorSheme;
}

@end
