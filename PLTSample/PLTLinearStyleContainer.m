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
#import "PLTColorScheme.h"
#import "PLTLinearConfig.h"
#import "UIColor+PresetColors.h"

@interface PLTLinearStyleContainer ()

@property(nonatomic, strong, nonnull) PLTGridStyle *gridStyle;
@property(nonatomic, strong, nonnull) PLTAxisXStyle *axisXStyle;
@property(nonatomic, strong, nonnull) PLTAxisYStyle *axisYStyle;
@property(nonatomic, copy, nonnull) NSDictionary<NSString *,PLTLinearChartStyle *> *chartStyles;
@property(nonatomic, strong, nonnull) PLTLinearChartStyle *chartStyle;
@property(nonatomic, strong, nonnull) PLTAreaStyle *areaStyle;
@property(nonatomic, strong, nonnull) NSArray<UIColor *> *colorContainer;

@end


@implementation PLTLinearStyleContainer

@synthesize gridStyle = _gridStyle;
@synthesize axisXStyle = _axisXStyle;
@synthesize axisYStyle = _axisYStyle;
@synthesize chartStyles = _chartStyles;
@synthesize chartStyle = _chartStyle;
@synthesize areaStyle = _areaStyle;
@synthesize colorContainer = _colorContainer;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                           andConfig:(nonnull PLTLinearConfig *)config {
  self = [super init];
  if (self) {
    _gridStyle = [self greedStyleWithColorScheme:colorScheme andConfig:config];
    _areaStyle = [self areaStyleWithColorScheme:colorScheme];
    _chartStyle = [self chartStyleWithColorScheme:colorScheme andConfig:config];
    _chartStyles = @{
                      @"default":[self chartStyleWithColorScheme:colorScheme andConfig:config]
                        };
    _axisXStyle = [self axisXStyleWithColorScheme:colorScheme andConfig:config];
    _axisYStyle = [self axisYStyleWithColorScheme:colorScheme andConfig:config];
    
    _colorContainer = [UIColor plt_presetColors];
  }
  return self;
}

#pragma mark - Initialization helpers

- (nonnull PLTGridStyle *)greedStyleWithColorScheme:(nonnull PLTColorScheme *)colorSheme
                                        andConfig:(nonnull PLTLinearConfig *)config {
  PLTGridStyle *style = [PLTGridStyle blank];
  //  Color scheme
  style.horizontalLineColor = colorSheme.gridHorizontalLineColor;
  style.verticalLineColor = colorSheme.gridVerticalLineColor;
  style.backgroundColor = colorSheme.gridBackgroundColor;
  //  Config
  style.horizontalGridlineEnable = config.horizontalGridlineEnable;
  style.verticalGridlineEnable = config.verticalGridlineEnable;
  style.lineStyle = config.gridLineStyle;
  style.lineWeight = config.gridLineWeight;
  return style;
}

- (nonnull PLTAreaStyle *)areaStyleWithColorScheme:(nonnull PLTColorScheme *)colorScheme{
  PLTAreaStyle *style = [PLTAreaStyle blank];
  style.areaColor = colorScheme.areaColor;
  return style;
}

- (nonnull PLTAxisXStyle *)axisXStyleWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                 andConfig:(nonnull PLTLinearConfig *) config{
  PLTAxisXStyle *style = [PLTAxisXStyle blank];
  //  Color scheme
  style.axisColor = colorScheme.axisXColor;
  style.labelFontColor = colorScheme.axisXLabelFontColor;
  //  Config
  style.hidden = config.xHidden;
  style.hasArrow = config.xHasArrow;
  style.hasName = config.xHasName;
  style.hasMarks = config.xHasMarks;
  style.isAutoformat = config.xIsAutoformat;
  style.marksType = config.xMarksType;
  style.axisLineWeight = config.xAxisLineWeight;
  style.hasLabels = config.xHasLabels;
  style.labelPosition = config.xLabelPosition;
  return style;
}

- (nonnull PLTAxisYStyle *)axisYStyleWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                  andConfig:(nonnull PLTLinearConfig *) config{
  //  Color scheme
  PLTAxisYStyle *style = [PLTAxisYStyle blank];
  style.axisColor = colorScheme.axisYColor;
  style.labelFontColor = colorScheme.axisYLabelFontColor;
  //  Config
  style.hidden = config.yHidden;
  style.hasArrow = config.yHasArrow;
  style.hasName = config.yHasName;
  style.hasMarks = config.yHasMarks;
  style.isAutoformat = config.yIsAutoformat;
  style.marksType = config.yMarksType;
  style.axisLineWeight = config.yAxisLineWeight;
  style.hasLabels = config.yHasLabels;
  style.labelPosition = config.yLabelPosition;
  return style;
}

- (nonnull PLTLinearChartStyle *)chartStyleWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                        andConfig:(nonnull PLTLinearConfig *) config{
  PLTLinearChartStyle *style = [PLTLinearChartStyle blank];
  //  Color scheme
  style.chartLineColor = colorScheme.chartLineColor;
  //  Config
  style.hasMarkers = config.chartHasMarkers;
  style.hasFilling = config.chartHasFilling;
  style.markerType = config.chartMarkerType;
  return style;
}

#pragma mark - Decription

- (NSString *)description {
  return [NSString stringWithFormat:@"@<%@: %p \n Area style = %@ \n\
          Grid style = %@ \n\
          Chart style = %@ \n\
          Axis x style = %@ \n\
          Axis y style = %@>",
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
  return [[PLTLinearStyleContainer alloc] initWithColorScheme:[PLTColorScheme blank]
                                                    andConfig:[PLTLinearConfig blank]];
}

+ (nonnull instancetype)math {
  return [[PLTLinearStyleContainer alloc] initWithColorScheme:[PLTColorScheme math]
                                                    andConfig:[PLTLinearConfig math]];
}

+ (nonnull instancetype)cobaltStocks {
  return [[PLTLinearStyleContainer alloc] initWithColorScheme:[PLTColorScheme cobalt]
                                                    andConfig:[PLTLinearConfig stocks]];
}

+ (nonnull instancetype)blackAndGray{
  return [[PLTLinearStyleContainer alloc] initWithColorScheme:[PLTColorScheme blackAndGray]
                                                    andConfig:[PLTLinearConfig blackAndGray]];

}

#pragma mark - Chart style injection

- (void)injectChartStyle:(nonnull PLTLinearChartStyle *)chartStyle forSeries:(nonnull NSString *)seriesName {
  NSMutableDictionary *newChartStyles = [self.chartStyles mutableCopy];
  [newChartStyles setObject:chartStyle forKey:seriesName];
  self.chartStyles = newChartStyles;
}

#pragma mark - PLTLinearStyleContainer

static NSString *const kPLTChartDefaultName = @"default";

- (nonnull PLTLinearChartStyle *)chartStyleForSeries:(nullable NSString *)seriesName {
  if (seriesName == nil) seriesName = kPLTChartDefaultName;
  PLTLinearChartStyle *chartStyle = self.chartStyles[(NSString *_Nonnull)seriesName];
  if (chartStyle) {
    return chartStyle;
  }
  else {
    chartStyle = [PLTLinearChartStyle blank];
    // Always in this branch self.chartStyles.count>1 (cause has default style)
    chartStyle.chartLineColor = self.colorContainer[(self.chartStyles.count-1) % self.colorContainer.count];
    chartStyle.hasFilling = self.chartStyles[kPLTChartDefaultName].hasFilling;
    chartStyle.hasMarkers = self.chartStyles[kPLTChartDefaultName].hasMarkers;
    [self injectChartStyle:chartStyle forSeries:(NSString *_Nonnull)seriesName];
    return chartStyle;
  }
}

@end
