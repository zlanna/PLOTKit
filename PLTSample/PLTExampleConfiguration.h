//
//  PLTExampleConfiguration.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 17.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;

extern NSString *_Nonnull const kPLTDescription;
// Plots
extern NSString *_Nonnull const kPLTLinearPlotName;
extern NSString *_Nonnull const kPLTScatterPlotName;
extern NSString *_Nonnull const kPLTBarPlotName;
// Preset design patterns
extern NSString *_Nonnull const kPLTDesignPatternBlank;
extern NSString *_Nonnull const kPLTDesignPatternMath;
extern NSString *_Nonnull const kPLTDesignPatternCobalt;
extern NSString *_Nonnull const kPLTDesignPatternGray;

@interface PLTExampleConfiguration : NSObject

+ (nonnull NSArray<NSString *> *)designPresetNames;
+ (nonnull NSDictionary<NSString *,NSDictionary<NSString*, NSString *> *> *)chartsConfig;

@end
