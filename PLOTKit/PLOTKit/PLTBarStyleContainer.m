//
//  PLTBarStyleContainer.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 15.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTBarStyleContainer.h"
#import "PLTStyleContainer+Protected.h"
#import "PLTBarChartStyle.h"
#import "PLTColorScheme.h"
#import "UIColor+PresetColors.h"

@interface PLTBarStyleContainer ()

@property(nonatomic, copy, nonnull) NSDictionary<NSString *,PLTBarChartStyle *> *chartStyles;
@property(nonatomic, strong, nonnull) PLTBarChartStyle *chartStyle;
@property(nonatomic, strong, nonnull) NSArray<UIColor *> *colorContainer;

@end


@implementation PLTBarStyleContainer

@synthesize chartStyles = _chartStyles;
@synthesize chartStyle = _chartStyle;
@synthesize colorContainer = _colorContainer;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                           andConfig:(nonnull PLTBarConfig *)config {
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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"
- (nonnull PLTBarChartStyle *)chartStyleWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                                  andConfig:(nonnull PLTBarConfig *) config{
  PLTBarChartStyle *style = [PLTBarChartStyle blank];
  //  Color scheme
  style.chartColor = colorScheme.chartColor;
  return style;
}
#pragma clang diagnostic pop

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

- (void)injectChartStyle:(nonnull PLTBarChartStyle *)chartStyle forSeries:(nonnull NSString *)seriesName {
  NSMutableDictionary *newChartStyles = [self.chartStyles mutableCopy];
  [newChartStyles setObject:chartStyle forKey:seriesName];
  self.chartStyles = newChartStyles;
}

#pragma mark - PLTBarStyleContainer

static NSString *const kPLTChartDefaultName = @"default";

- (nonnull PLTBarChartStyle *)chartStyleForSeries:(nullable NSString *)seriesName {
  if (seriesName == nil) seriesName = kPLTChartDefaultName;
  PLTBarChartStyle *chartStyle = self.chartStyles[(NSString *_Nonnull)seriesName];
  if (chartStyle) {
    return chartStyle;
  }
  else {
    chartStyle = [PLTBarChartStyle blank];
    // Always in this branch self.chartStyles.count>1 (cause has default style)
    chartStyle.chartColor = self.colorContainer[(self.chartStyles.count-1) % self.colorContainer.count];
    [self injectChartStyle:chartStyle forSeries:(NSString *_Nonnull)seriesName];
    return chartStyle;
  }
}

#pragma mark - Styles

+ (nonnull instancetype)blank {
  return [[PLTBarStyleContainer alloc] initWithColorScheme:[PLTColorScheme blank]
                                                     andConfig:[PLTBarConfig blank]];
}

+ (nonnull instancetype)math {
  return [[PLTBarStyleContainer alloc] initWithColorScheme:[PLTColorScheme math]
                                                     andConfig:[PLTBarConfig math]];
}

+ (nonnull instancetype)cobaltStocks {
  return [[PLTBarStyleContainer alloc] initWithColorScheme:[PLTColorScheme cobalt]
                                                     andConfig:[PLTBarConfig stocks]];
}

+ (nonnull instancetype)blackAndGray{
  return [[PLTBarStyleContainer alloc] initWithColorScheme:[PLTColorScheme blackAndGray]
                                                     andConfig:[PLTBarConfig blackAndGray]];
}

@end
