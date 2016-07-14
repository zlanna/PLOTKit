//
//  PLTStyleContainer.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 22.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;

@class PLTColorScheme;
@class PLTBaseConfig;

@interface PLTStyleContainer : NSObject

- (null_unspecified instancetype)init NS_UNAVAILABLE;
- (null_unspecified instancetype)initWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                           andConfig:(nonnull __kindof PLTBaseConfig *)config NS_DESIGNATED_INITIALIZER;

+ (nonnull instancetype)blank;
+ (nonnull instancetype)math;
+ (nonnull instancetype)cobaltStocks;
+ (nonnull instancetype)blackAndGray;

@end
