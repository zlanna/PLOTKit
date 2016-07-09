//
//  PLTLinearStyle.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 22.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@class PLTColorScheme;
@class PLTLinearConfig;
@class PLTLinearChartStyle;

@interface PLTLinearStyleContainer : NSObject<PLTLinearStyleContainer>

- (null_unspecified instancetype)init NS_UNAVAILABLE;
- (null_unspecified instancetype)initWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                           andConfig:(nonnull PLTLinearConfig *)config NS_DESIGNATED_INITIALIZER;

+ (nonnull instancetype)blank;
+ (nonnull instancetype)math;
+ (nonnull instancetype)cobaltStocks;
+ (nonnull instancetype)blackAndGray;

@end
