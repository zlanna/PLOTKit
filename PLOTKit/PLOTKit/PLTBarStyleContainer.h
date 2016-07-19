//
//  PLTBarStyleContainer.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 15.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTStyleContainer.h"
#import "PLTBarConfig.h"

@class PLTColorScheme;

@interface PLTBarStyleContainer : PLTStyleContainer <PLTBarStyleContainer>

- (null_unspecified instancetype)init NS_UNAVAILABLE;
- (null_unspecified instancetype)initWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                           andConfig:(nonnull PLTBarConfig *)config NS_DESIGNATED_INITIALIZER;
+ (nonnull instancetype)blank;
+ (nonnull instancetype)math;
+ (nonnull instancetype)cobaltStocks;
+ (nonnull instancetype)blackAndGray;

@end
