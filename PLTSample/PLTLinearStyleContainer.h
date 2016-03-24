//
//  PLTLinearStyle.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 22.03.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import "PLTStyleContainer.h"

@class PLTGridStyle;
@class PLTAxisStyle;
@class PLTLinearChartStyle;
@class PLTAreaStyle;

@interface PLTLinearStyleContainer : PLTStyleContainer

@property(nonatomic, strong, nonnull) PLTGridStyle *gridStyle;
@property(nonatomic, strong, nonnull) PLTAxisStyle *axisXStyle;
@property(nonatomic, strong, nonnull) PLTAxisStyle *axisYStyle;
@property(nonatomic, strong, nonnull) PLTLinearChartStyle *chartStyle;
@property(nonatomic, strong, nonnull) PLTAreaStyle *areaStyle;

+ (nonnull PLTLinearStyleContainer *)blank;
+ (nonnull PLTLinearStyleContainer *)defaultStyle;
+ (nonnull PLTLinearStyleContainer *)math;
+ (nonnull PLTLinearStyleContainer*)cobalt;

@end
