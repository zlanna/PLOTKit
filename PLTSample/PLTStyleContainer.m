//
//  PLTStyleContainer.m
//  PLTSample
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

@interface PLTStyleContainer ()

@property(nonatomic, strong, nonnull) PLTGridStyle *gridStyle;
@property(nonatomic, strong, nonnull) PLTAxisXStyle *axisXStyle;
@property(nonatomic, strong, nonnull) PLTAxisYStyle *axisYStyle;
@property(nonatomic, strong, nonnull) PLTAreaStyle *areaStyle;

@end


@implementation PLTStyleContainer

@synthesize gridStyle = _gridStyle;
@synthesize axisXStyle = _axisXStyle;
@synthesize axisYStyle = _axisYStyle;
@synthesize areaStyle = _areaStyle;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                           andConfig:(nonnull PLTBaseConfig *)config {
  self = [super init];
  if (self) {
    _gridStyle = [self greedStyleWithColorScheme:colorScheme andConfig:config];
    _areaStyle = [self areaStyleWithColorScheme:colorScheme];
    _axisXStyle = [self axisXStyleWithColorScheme:colorScheme andConfig:config];
    _axisYStyle = [self axisYStyleWithColorScheme:colorScheme andConfig:config];
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

- (nonnull PLTAreaStyle *)areaStyleWithColorScheme:(nonnull PLTColorScheme *)colorScheme{
  PLTAreaStyle *style = [PLTAreaStyle blank];
  style.areaColor = colorScheme.areaColor;
  return style;
}

- (nonnull PLTAxisXStyle *)axisXStyleWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                           andConfig:(nonnull PLTBaseConfig *) config{
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
                                           andConfig:(nonnull PLTBaseConfig *) config{
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

#pragma mark - Styles

+ (nonnull instancetype)blank {
  return [[[self class] alloc] initWithColorScheme:[PLTColorScheme blank]
                                         andConfig:[PLTLinearConfig blank]];
}

+ (nonnull instancetype)math {
  return [[[self class] alloc] initWithColorScheme:[PLTColorScheme math]
                                         andConfig:[PLTLinearConfig math]];
}

+ (nonnull instancetype)cobaltStocks {
  return [[[self class] alloc] initWithColorScheme:[PLTColorScheme cobalt]
                                         andConfig:[PLTLinearConfig stocks]];
}

+ (nonnull instancetype)blackAndGray{
  return [[[self class] alloc] initWithColorScheme:[PLTColorScheme blackAndGray]
                                         andConfig:[PLTLinearConfig blackAndGray]];
  
}

#pragma mark - Decription

- (NSString *)description {
  return [NSString stringWithFormat:@"@<%@: %p \n Area style = %@ \n\
          Grid style = %@ \n\
          Axis x style = %@ \n\
          Axis y style = %@>",
          self.class,
          (void *)self,
          self.areaStyle,
          self.gridStyle,
          self.axisXStyle,
          self.axisYStyle
          ];
}

@end
