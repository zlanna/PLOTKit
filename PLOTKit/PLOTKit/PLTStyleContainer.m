//
//  PLTStyleContainer.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 22.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTStyleContainer.h"
#import "PLTGridStyle.h"
#import "PLTAxisStyle.h"
#import "PLTLinearChartStyle.h"
#import "PLTAreaStyle.h"
#import "PLTColorScheme.h"
#import "PLTLinearConfig.h"
#import "PLTLegendStyle.h"

@interface PLTStyleContainer ()

@property(nonatomic, strong, nonnull) PLTGridStyle *gridStyle;
@property(nonatomic, strong, nonnull) PLTAxisXStyle *axisXStyle;
@property(nonatomic, strong, nonnull) PLTAxisYStyle *axisYStyle;
@property(nonatomic, strong, nonnull) PLTAreaStyle *areaStyle;
@property(nonatomic, strong, nonnull) PLTLegendStyle *legendStyle;

@end


@implementation PLTStyleContainer

@synthesize gridStyle = _gridStyle;
@synthesize axisXStyle = _axisXStyle;
@synthesize axisYStyle = _axisYStyle;
@synthesize areaStyle = _areaStyle;
@synthesize legendStyle = _legendStyle;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                           andConfig:(nonnull PLTBaseConfig *)config {
  self = [super init];
  if (self) {
    _gridStyle = [self greedStyleWithColorScheme:colorScheme andConfig:config];
    _areaStyle = [self areaStyleWithColorScheme:colorScheme andConfig:config];
    _axisXStyle = [self axisXStyleWithColorScheme:colorScheme andConfig:config];
    _axisYStyle = [self axisYStyleWithColorScheme:colorScheme andConfig:config];
    _legendStyle = [self legendWithColorScheme:colorScheme andConfig:config];
  }
  return self;
}

#pragma mark - Initialization helpers

- (nonnull PLTGridStyle *)greedStyleWithColorScheme:(nonnull PLTColorScheme *)colorSheme
                                          andConfig:(nonnull PLTBaseConfig *)config {
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

- (nonnull PLTAreaStyle *)areaStyleWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                          andConfig:(nonnull PLTBaseConfig *) config {
  PLTAreaStyle *style = [PLTAreaStyle blank];
  //  Color scheme
  style.areaColor = colorScheme.areaColor;
  style.chartNameFontColor = colorScheme.chartNameFontColor;
  // Config
  style.chartNameFont = config.chartNameFont;
  return style;
}

- (nonnull PLTAxisXStyle *)axisXStyleWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                           andConfig:(nonnull PLTBaseConfig *) config {
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
  style.axisNameLabelFont = config.xNameLabelFont;
  style.axisLabelsFont = config.xLabelsFont;
  return style;
}

- (nonnull PLTAxisYStyle *)axisYStyleWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                           andConfig:(nonnull PLTBaseConfig *) config {
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
  style.axisNameLabelFont = config.yNameLabelFont;
  style.axisLabelsFont = config.yLabelsFont;
  return style;
}

- (nonnull PLTLegendStyle *)legendWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                           andConfig:(nonnull PLTBaseConfig *) config {
  PLTLegendStyle *style = [PLTLegendStyle blank];
  // Color scheme
  style.labelColorForNormalState = colorScheme.legendLabelColorForNormalState;
  style.labelColorForHighlightedState = colorScheme.legendLabelColorForHighlightedState;
  style.labelColorForSelectedState = colorScheme.legendLabelColorForSelectedState;
  
  style.titleColorForNormalState = colorScheme.legendTitleColorForNormalState;
  style.titleColorForHighlightedState = colorScheme.legendTitleColorForHighlightedState;
  style.titleColorForSelectedState = colorScheme.legendTitleColorForSelectedState;
  // Config
  style.legendFont = config.legendFont;
  return style;
}

#pragma mark - Decription

- (NSString *)description {
  return [NSString stringWithFormat:@"@<%@: %p \n Area style = %@ \n\
          Grid style = %@ \n\
          Axis x style = %@ \n\
          Axis y style = %@ \n\
          Legend style = %@ >",
          self.class,
          (void *)self,
          self.areaStyle,
          self.gridStyle,
          self.axisXStyle,
          self.axisYStyle,
          self.legendStyle
          ];
}

@end
