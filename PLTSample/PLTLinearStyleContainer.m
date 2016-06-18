//
//  PLTLinearStyle.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 22.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLinearStyleContainer.h"
#import "PLTGridStyle.h"
#import "PLTAxisStyle.h"
#import "PLTLinearChartStyle.h"
#import "PLTAreaStyle.h"
#import "PLTColorSheme.h"
#import "PLTLinearConfig.h"

@interface PLTLinearStyleContainer ()

@property(nonatomic, strong, nonnull) PLTGridStyle *gridStyle;
@property(nonatomic, strong, nonnull) PLTAxisStyle *axisXStyle;
@property(nonatomic, strong, nonnull) PLTAxisStyle *axisYStyle;
@property(nonatomic, strong, nonnull) PLTLinearChartStyle *chartStyle;
@property(nonatomic, strong, nonnull) PLTAreaStyle *areaStyle;

@end


@implementation PLTLinearStyleContainer

@synthesize gridStyle = _gridStyle;
@synthesize axisXStyle = _axisXStyle;
@synthesize axisYStyle = _axisYStyle;
@synthesize chartStyle = _chartStyle;
@synthesize areaStyle = _areaStyle;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithColorScheme:(nonnull PLTColorSheme *)colorScheme
                                           andConfig:(nonnull PLTLinearConfig *)config {
  self = [super init];
  if (self) {
    _gridStyle = [self greedStyleWithColorScheme:colorScheme andConfig:config];
    _areaStyle = [self areaStyleWithColorScheme:colorScheme];
    _chartStyle = [self chartStyleWithColorScheme:colorScheme andConfig:config];
    _axisXStyle = [self axisXStyleWithColorScheme:colorScheme andConfig:config];
    _axisYStyle = [self axisYStyleWithColorScheme:colorScheme andConfig:config];
  }
  return self;
}

#pragma mark - Initialization helpers

- (nonnull PLTGridStyle *)greedStyleWithColorScheme:(nonnull PLTColorSheme *)colorSheme
                                        andConfig:(nonnull PLTLinearConfig *)config {
  PLTGridStyle *style = [PLTGridStyle blank];
  //  Color scheme
  
  
  style.horizontalLineColor = colorSheme.gridHorizontalLineColor;
  style.verticalLineColor = colorSheme.gridVerticalLineColor;
  style.backgroundColor = colorSheme.gridBackgroundColor;
  style.labelFontColor = colorSheme.gridLabelFontColor;
  //  Config
  style.horizontalGridlineEnable = config.horizontalGridlineEnable;
  style.verticalGridlineEnable = config.verticalGridlineEnable;
  style.hasLabels = config.gridHasLabels;
  style.horizontalLabelPosition = config.horizontalGridLabelPosition;
  style.verticalLabelPosition = config.verticalGridLabelPosition;
  style.lineStyle = config.gridLineStyle;
  style.lineWeight = config.gridLineWeight;
  return style;
}

- (nonnull PLTAreaStyle *)areaStyleWithColorScheme:(nonnull PLTColorSheme *)colorScheme{
  PLTAreaStyle *style = [PLTAreaStyle blank];
  style.areaColor = colorScheme.areaColor;
  return style;
}

- (nonnull PLTAxisStyle *)axisXStyleWithColorScheme:(nonnull PLTColorSheme *)colorScheme
                                 andConfig:(nonnull PLTLinearConfig *) config{
  PLTAxisStyle *style = [PLTAxisStyle blank];
  //  Color scheme
  style.axisColor = colorScheme.axisXColor;
  //  Config
  style.hidden = config.xHidden;
  style.hasArrow = config.xHasArrow;
  style.hasName = config.xHasName;
  style.hasMarks = config.xHasMarks;
  style.isAutoformat = config.xIsAutoformat;
  style.marksType = config.xMarksType;
  style.axisLineWeight = config.xAxisLineWeight;
  return style;
}

- (nonnull PLTAxisStyle *)axisYStyleWithColorScheme:(nonnull PLTColorSheme *)colorScheme
                                  andConfig:(nonnull PLTLinearConfig *) config{
  //  Color scheme
  PLTAxisStyle *style = [PLTAxisStyle blank];
  style.axisColor = colorScheme.axisYColor;
  //  Config
  style.hidden = config.yHidden;
  style.hasArrow = config.yHasArrow;
  style.hasName = config.yHasName;
  style.hasMarks = config.yHasMarks;
  style.isAutoformat = config.yIsAutoformat;
  style.marksType = config.yMarksType;
  style.axisLineWeight = config.yAxisLineWeight;
  return style;
}

- (nonnull PLTLinearChartStyle *)chartStyleWithColorScheme:(nonnull PLTColorSheme *)colorScheme
                                        andConfig:(nonnull PLTLinearConfig *) config{
  PLTLinearChartStyle *style = [PLTLinearChartStyle blank];
  //  Color scheme
  style.chartLineColor = colorScheme.chartLineColor;
  //  Config
  style.hasMarkers = config.chartHasMarkers;
  style.hasFilling = config.chartHasFilling;
  return style;
}

#pragma mark - Decription

- (NSString *)description {
  return [NSString stringWithFormat:@"@<%@: %p \n Area style = %@ \n Grid style = %@ \n Chart style = %@ \n Axis x style = %@ \n Axis y style = %@>",
          self.class,
          (void *)self,
          self.areaStyle,
          self.gridStyle,
          self.chartStyle,
          self.axisXStyle,
          self.axisYStyle
          ];
}

#pragma mark - Styles

+ (nonnull instancetype)blank {
  return [[PLTLinearStyleContainer alloc] initWithColorScheme:[PLTColorSheme blank]
                                                    andConfig:[PLTLinearConfig blank]];
}

+ (nonnull instancetype)math {
  return [[PLTLinearStyleContainer alloc] initWithColorScheme:[PLTColorSheme math]
                                                    andConfig:[PLTLinearConfig math]];
}

+ (nonnull instancetype)cobaltStocks {
  return [[PLTLinearStyleContainer alloc] initWithColorScheme:[PLTColorSheme cobalt]
                                                    andConfig:[PLTLinearConfig stocks]];
}

@end
