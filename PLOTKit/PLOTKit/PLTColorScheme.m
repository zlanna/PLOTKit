//
//  PLTColorSheme.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 27.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTColorScheme.h"

#define RGBCOLOR(x,y,z) \
    [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]

@implementation PLTColorScheme
//  Area
@synthesize chartNameFontColor = _chartNameFontColor;
//  Grid color scheme
@synthesize gridVerticalLineColor = _gridVerticalLineColor;
@synthesize gridHorizontalLineColor = _gridHorizontalLineColor;
@synthesize gridBackgroundColor = _gridBackgroundColor;
//  Chart color scheme
@synthesize chartColor = _chartColor;
//  Area color scheme
@synthesize areaColor = _areaColor;
//  Axis X color scheme
@synthesize axisXColor = _axisXColor;
@synthesize axisXLabelFontColor = _axisXLabelFontColor;
//  Axis Y color scheme
@synthesize axisYColor = _axisYColor;
@synthesize axisYLabelFontColor = _axisYLabelFontColor;
//  Legend color scheme
@synthesize legendLabelColorForNormalState = _legendLabelColorForNormalState;
@synthesize legendLabelColorForSelectedState = _legendLabelColorForSelectedState;
@synthesize legendLabelColorForHighlightedState = _legendLabelColorForHighlightedState;
@synthesize legendTitleColorForNormalState = _legendTitleColorForNormalState;
@synthesize legendTitleColorForSelectedState = _legendTitleColorForSelectedState;
@synthesize legendTitleColorForHighlightedState = _legendTitleColorForHighlightedState;


#pragma mark - Initialization

- (null_unspecified instancetype)init {
  self = [super init];
  if (self) {
    _gridHorizontalLineColor = [UIColor blackColor];
    _gridVerticalLineColor = [_gridHorizontalLineColor copy];
    _gridBackgroundColor = [UIColor whiteColor];
    
    _chartColor = [UIColor blueColor];
    
    _areaColor = [_gridBackgroundColor copy];
    _chartNameFontColor = [_gridHorizontalLineColor copy];
    
    _axisXColor = [_gridHorizontalLineColor copy];
    _axisXLabelFontColor = [UIColor blackColor];
    
    _axisYColor = [_axisXColor copy];
    _axisYLabelFontColor = [UIColor blackColor];
    
    _legendLabelColorForNormalState = [UIColor whiteColor];
    _legendLabelColorForHighlightedState = [UIColor blueColor];
    _legendLabelColorForSelectedState = [UIColor blueColor];
    
    _legendTitleColorForNormalState = [UIColor blackColor];
    _legendTitleColorForHighlightedState = [UIColor whiteColor];
    _legendTitleColorForSelectedState = [UIColor whiteColor];
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
  colorScheme.chartColor = [UIColor blueColor];
  colorScheme.areaColor = [colorScheme.gridBackgroundColor copy];
  colorScheme.chartNameFontColor = [UIColor blackColor];
  colorScheme.axisXColor = [UIColor blackColor];
  colorScheme.axisXLabelFontColor = [UIColor blackColor];
  colorScheme.axisYColor = [colorScheme.axisXColor copy];
  colorScheme.axisYLabelFontColor = [UIColor blackColor];
  colorScheme.legendLabelColorForNormalState = [UIColor whiteColor];
  colorScheme.legendLabelColorForHighlightedState = RGBCOLOR(31, 136, 254);
  colorScheme.legendLabelColorForSelectedState = RGBCOLOR(31, 136, 254);
  colorScheme.legendTitleColorForNormalState = RGBCOLOR(31, 136, 254);
  colorScheme.legendTitleColorForHighlightedState = [UIColor whiteColor];
  colorScheme.legendTitleColorForSelectedState = [UIColor whiteColor];
  return colorScheme;
}

+ (nonnull instancetype)cobalt {
  PLTColorScheme *colorScheme = [PLTColorScheme new];
  colorScheme.gridHorizontalLineColor = RGBCOLOR(255.0, 191.0, 54.0);
  colorScheme.gridVerticalLineColor = [colorScheme.gridHorizontalLineColor copy];
  colorScheme.gridBackgroundColor = RGBCOLOR(0.0, 34.0, 64.0);
  colorScheme.chartColor = RGBCOLOR(58.0, 217.0, 0.0);
  colorScheme.areaColor = [colorScheme.gridBackgroundColor copy];
  colorScheme.chartNameFontColor = RGBCOLOR(255.0, 191.0, 54.0);
  colorScheme.axisXColor = RGBCOLOR(246.0, 170.0, 17.0);
  colorScheme.axisXLabelFontColor = RGBCOLOR(256.0, 170.0, 28.0);
  colorScheme.axisYColor = [colorScheme.axisXColor copy];
  colorScheme.axisYLabelFontColor = [colorScheme.axisXLabelFontColor copy];
  colorScheme.legendLabelColorForNormalState = RGBCOLOR(0.0, 34.0, 64.0);
  colorScheme.legendLabelColorForHighlightedState = [colorScheme.gridHorizontalLineColor copy];
  colorScheme.legendLabelColorForSelectedState = [colorScheme.gridHorizontalLineColor copy];
  colorScheme.legendTitleColorForNormalState = [colorScheme.gridHorizontalLineColor copy];
  colorScheme.legendTitleColorForHighlightedState = RGBCOLOR(0.0, 34.0, 64.0);
  colorScheme.legendTitleColorForSelectedState = RGBCOLOR(0.0, 34.0, 64.0);
  return colorScheme;
}

+ (nonnull instancetype)blackAndGray {
  PLTColorScheme *colorScheme = [PLTColorScheme new];
  colorScheme.gridHorizontalLineColor = [UIColor lightGrayColor];
  colorScheme.gridVerticalLineColor = [UIColor lightGrayColor];
  colorScheme.gridBackgroundColor = RGBCOLOR(27.0, 27.0, 28.0);
  colorScheme.chartColor = [UIColor blueColor];
  colorScheme.areaColor = [colorScheme.gridBackgroundColor copy];
  colorScheme.chartNameFontColor = [UIColor lightGrayColor];
  colorScheme.axisXColor = [UIColor lightGrayColor];
  colorScheme.axisXLabelFontColor = [UIColor lightGrayColor];
  colorScheme.axisYColor = [colorScheme.axisXColor copy];
  colorScheme.axisYLabelFontColor = [colorScheme.axisXLabelFontColor copy];
  colorScheme.legendLabelColorForNormalState = [colorScheme.gridBackgroundColor copy];
  colorScheme.legendLabelColorForHighlightedState = [UIColor lightGrayColor];
  colorScheme.legendLabelColorForSelectedState = [UIColor lightGrayColor];
  colorScheme.legendTitleColorForNormalState = [colorScheme.gridHorizontalLineColor copy];
  colorScheme.legendTitleColorForHighlightedState = [colorScheme.gridBackgroundColor copy];
  colorScheme.legendTitleColorForSelectedState = [colorScheme.gridBackgroundColor copy];
  return colorScheme;
}

@end
