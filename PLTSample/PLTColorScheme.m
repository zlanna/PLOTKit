//
//  PLTColorSheme.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 27.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTColorScheme.h"

#define RGBCOLOR(x,y,z) \
    [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]

@implementation PLTColorScheme
//  Grid color scheme
@synthesize gridVerticalLineColor = _gridVerticalLineColor;
@synthesize gridHorizontalLineColor = _gridHorizontalLineColor;
@synthesize gridBackgroundColor = _gridBackgroundColor;
//  Chart color scheme
@synthesize chartLineColor = _chartLineColor;
//  Area color scheme
@synthesize areaColor = _areaColor;
//  Axis X color scheme
@synthesize axisXColor = _axisXColor;
@synthesize axisXLabelFontColor = _axisXLabelFontColor;
//  Axis Y color scheme
@synthesize axisYColor = _axisYColor;
@synthesize axisYLabelFontColor = _axisYLabelFontColor;

#pragma mark - Initialization

- (instancetype)init {
  self = [super init];
  if (self) {
    _gridHorizontalLineColor = [UIColor blackColor];
    _gridVerticalLineColor = [_gridHorizontalLineColor copy];
    _gridBackgroundColor = [UIColor whiteColor];
    
    _chartLineColor = [UIColor blueColor];
    
    _areaColor = [_gridBackgroundColor copy];
    
    _axisXColor = [_gridHorizontalLineColor copy];
    _axisXLabelFontColor = [UIColor blackColor];
    
    _axisYColor = [_axisXColor copy];
    _axisYLabelFontColor = [UIColor blackColor];
  }
  return self;
}

#pragma mark - Schemes

+ (nonnull instancetype)blank {
  PLTColorScheme *colorScheme = [PLTColorScheme new];
  return colorScheme;
}

+ (nonnull instancetype)math {
  PLTColorScheme *colorScheme = [PLTColorScheme new];
  colorScheme.gridHorizontalLineColor = [UIColor lightGrayColor];
  colorScheme.gridVerticalLineColor = [colorScheme.gridHorizontalLineColor copy];
  colorScheme.gridBackgroundColor = [UIColor whiteColor];
  colorScheme.chartLineColor = [UIColor blueColor];
  colorScheme.areaColor = [colorScheme.gridBackgroundColor copy];
  colorScheme.axisXColor = [UIColor blackColor];
  colorScheme.axisXLabelFontColor = [UIColor blackColor];
  colorScheme.axisYColor = [colorScheme.axisXColor copy];
  colorScheme.axisYLabelFontColor = [UIColor blackColor];
  return colorScheme;
}

+ (nonnull instancetype)cobalt {
  PLTColorScheme *colorScheme = [PLTColorScheme new];
  colorScheme.gridHorizontalLineColor = RGBCOLOR(255.0, 191.0, 54.0);
  colorScheme.gridVerticalLineColor = [colorScheme.gridHorizontalLineColor copy];
  colorScheme.gridBackgroundColor = RGBCOLOR(0.0, 34.0, 64.0);
  colorScheme.chartLineColor = RGBCOLOR(58.0, 217.0, 0.0);
  colorScheme.areaColor = [colorScheme.gridBackgroundColor copy];
  colorScheme.axisXColor = RGBCOLOR(246.0, 170.0, 17.0);
  colorScheme.axisXLabelFontColor = RGBCOLOR(256.0, 170.0, 28.0);
  colorScheme.axisYColor = [colorScheme.axisXColor copy];
  colorScheme.axisYLabelFontColor = [colorScheme.axisXLabelFontColor copy];
  return colorScheme;
}

+ (nonnull instancetype)blackAndGray {
  PLTColorScheme *colorScheme = [PLTColorScheme new];
  colorScheme.gridHorizontalLineColor = [UIColor lightGrayColor];
  colorScheme.gridVerticalLineColor = [UIColor lightGrayColor];
  colorScheme.gridBackgroundColor = RGBCOLOR(27.0, 27.0, 28.0);
  colorScheme.chartLineColor = [UIColor blueColor];
  colorScheme.areaColor = [colorScheme.gridBackgroundColor copy];
  colorScheme.axisXColor = [UIColor lightGrayColor];
  colorScheme.axisXLabelFontColor = [UIColor lightGrayColor];
  colorScheme.axisYColor = [colorScheme.axisXColor copy];
  colorScheme.axisYLabelFontColor = [colorScheme.axisXLabelFontColor copy];
  return colorScheme;
}

@end
