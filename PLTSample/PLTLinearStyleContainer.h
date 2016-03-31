//
//  PLTLinearStyle.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 22.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@class PLTGridStyle;
@class PLTAxisStyle;
@class PLTLinearChartStyle;
@class PLTAreaStyle;

@interface PLTLinearStyleContainer : NSObject

@property(nonatomic, strong, nonnull) PLTGridStyle *gridStyle;
@property(nonatomic, strong, nonnull) PLTAxisStyle *axisXStyle;
@property(nonatomic, strong, nonnull) PLTAxisStyle *axisYStyle;
@property(nonatomic, strong, nonnull) PLTLinearChartStyle *chartStyle;
@property(nonatomic, strong, nonnull) PLTAreaStyle *areaStyle;

- (null_unspecified instancetype)init NS_UNAVAILABLE;

+ (nonnull instancetype)blank;
+ (nonnull instancetype)defaultStyle;
+ (nonnull instancetype)math;
+ (nonnull instancetype)cobalt;

@end
