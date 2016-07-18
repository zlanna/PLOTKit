//
//  PLTExampleConfiguration.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 17.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTExampleConfiguration.h"

NSString *const kPLTDescription = @"Description";
// Plots
NSString *const kPLTLinearPlotName = @"Linear chart";
NSString *const kPLTScatterPlotName = @"Scatter chart";
NSString *const kPLTBarPlotName = @"Bar chart";

// Design patterns
NSString *const kPLTDesignPatternBlank = @"Blank";
NSString *const kPLTDesignPatternMath = @"Math";
NSString *const kPLTDesignPatternCobalt = @"Cobalt";
NSString *const kPLTDesignPatternGray = @"Gray";


@implementation PLTExampleConfiguration

+ (nonnull NSArray<NSString *> *)designPresetNames{
  return @[kPLTDesignPatternBlank, kPLTDesignPatternMath, kPLTDesignPatternCobalt, kPLTDesignPatternGray];
}

+ (nonnull NSDictionary<NSString *,NSDictionary<NSString*, NSString *> *> *)chartsConfig {
  return @{
           kPLTLinearPlotName:@{
               @"Description":@"A simple demonstration of the linear chart."
               },
           kPLTScatterPlotName:@{
               @"Description":@"A simple demonstration of the scatter chart."
               },
           kPLTBarPlotName:@{
               @"Description":@"A simple demonstration of the bar chart."
               }
           };
}

@end
