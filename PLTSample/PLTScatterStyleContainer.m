//
//  PLTScatterStyleContainer.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 14.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTScatterStyleContainer.h"
#import "PLTStyleContainer+Protected.h"
#import "PLTScatterChartStyle.h"
#import "PLTColorScheme.h"
#import "UIColor+PresetColors.h"

@interface PLTScatterStyleContainer ()

@property(nonatomic, copy, nonnull) NSDictionary<NSString *,PLTScatterChartStyle *> *chartStyles;
@property(nonatomic, strong, nonnull) PLTScatterChartStyle *chartStyle;
@property(nonatomic, strong, nonnull) NSArray<UIColor *> *colorContainer;

@end


@implementation PLTScatterStyleContainer

@synthesize chartStyles = _chartStyles;
@synthesize chartStyle = _chartStyle;
@synthesize colorContainer = _colorContainer;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                           andConfig:(nonnull PLTScatterConfig *)config {
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

- (nonnull PLTScatterChartStyle *)chartStyleWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                                 andConfig:(nonnull PLTScatterConfig *) config{
  PLTScatterChartStyle *style = [PLTScatterChartStyle blank];
  //  Color scheme
  style.chartColor = colorScheme.chartColor;
  //  Config
  style.markerType = config.chartMarkerType;
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

- (void)injectChartStyle:(nonnull PLTScatterChartStyle *)chartStyle forSeries:(nonnull NSString *)seriesName {
  NSMutableDictionary *newChartStyles = [self.chartStyles mutableCopy];
  [newChartStyles setObject:chartStyle forKey:seriesName];
  self.chartStyles = newChartStyles;
}

#pragma mark - PLTLinearStyleContainer

static NSString *const kPLTChartDefaultName = @"default";

- (nonnull PLTScatterChartStyle *)chartStyleForSeries:(nullable NSString *)seriesName {
  if (seriesName == nil) seriesName = kPLTChartDefaultName;
  PLTScatterChartStyle *chartStyle = self.chartStyles[(NSString *_Nonnull)seriesName];
  if (chartStyle) {
    return chartStyle;
  }
  else {
    chartStyle = [PLTScatterChartStyle blank];
    // Always in this branch self.chartStyles.count>1 (cause has default style)
    chartStyle.chartColor = self.colorContainer[(self.chartStyles.count-1) % self.colorContainer.count];
    [self injectChartStyle:chartStyle forSeries:(NSString *_Nonnull)seriesName];
    return chartStyle;
  }
}

@end
