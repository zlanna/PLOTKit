//
//  PLTScatterStyleContainer.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 14.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTStyleContainer.h"
#import "PLTScatterConfig.h"

@class PLTColorScheme;

@interface PLTScatterStyleContainer : PLTStyleContainer <PLTScatterStyleContainer>

- (null_unspecified instancetype)init NS_UNAVAILABLE;
- (null_unspecified instancetype)initWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                           andConfig:(nonnull PLTScatterConfig *)config NS_DESIGNATED_INITIALIZER;
+ (nonnull instancetype)blank;
+ (nonnull instancetype)math;
+ (nonnull instancetype)cobaltStocks;
+ (nonnull instancetype)blackAndGray;

@end
