//
//  PLTLinearStyleContainer.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 22.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLinearStyleContainer.h"
#import "PLTStyleContainer+Protected.h"
#import "PLTLinearChartStyle.h"
#import "PLTColorScheme.h"
#import "UIColor+PresetColors.h"

@interface PLTLinearStyleContainer ()

@property(nonatomic, copy, nonnull) NSDictionary<NSString *,PLTLinearChartStyle *> *chartStyles;
@property(nonatomic, strong, nonnull) PLTLinearChartStyle *chartStyle;
@property(nonatomic, strong, nonnull) NSArray<UIColor *> *colorContainer;

@end


@implementation PLTLinearStyleContainer

@synthesize chartStyles = _chartStyles;
@synthesize chartStyle = _chartStyle;
@synthesize colorContainer = _colorContainer;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                           andConfig:(nonnull PLTLinearConfig *)config {
  self = [super initWithColorScheme:colorScheme andConfig:config];
  if (self) {
    _chartStyle = [self chartStyleWithColorScheme:colorScheme andConfig:config];
    _chartStyles = @{
                      @"default":[self chartStyleWithColorScheme:colorScheme andConfig:config]
                        };
    _colorContainer = [UIColor plt_presetColors];
  }
  return self;
}

#pragma mark - Initialization helpers

- (nonnull PLTLinearChartStyle *)chartStyleWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                        andConfig:(nonnull PLTLinearConfig *) config{
  PLTLinearChartStyle *style = [PLTLinearChartStyle blank];
  //  Color scheme
  style.chartColor = colorScheme.chartColor;
  //  Config
  style.hasMarkers = config.chartHasMarkers;
  style.hasFilling = config.chartHasFilling;
  style.markerType = config.chartMarkerType;
  style.markerSize = config.chartMarkerSize;
  return style;
}

#pragma mark - Decription

- (NSString *)description {
  return [NSString stringWithFormat:@"@<%@: %p \n Super %@ \n\
          Chart style = %@ \n>",
          self.class,
          (void *)self,
          [super description],
          self.chartStyle
          ];
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
    chartStyle.chartColor = self.colorContainer[(self.chartStyles.count-1) % self.colorContainer.count];
    chartStyle.hasFilling = self.chartStyles[kPLTChartDefaultName].hasFilling;
    chartStyle.hasMarkers = self.chartStyles[kPLTChartDefaultName].hasMarkers;
    chartStyle.markerSize = self.chartStyles[kPLTChartDefaultName].markerSize;
    [self injectChartStyle:chartStyle forSeries:(NSString *_Nonnull)seriesName];
    return chartStyle;
  }
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

@end
