//
//  PLTLinearStyleContainer.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 22.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//
#import "PLTStyleContainer.h"
#import "PLTLinearConfig.h"

@class PLTColorScheme;

@interface PLTLinearStyleContainer : PLTStyleContainer <PLTLinearStyleContainer>

- (null_unspecified instancetype)init NS_UNAVAILABLE;
- (null_unspecified instancetype)initWithColorScheme:(nonnull PLTColorScheme *)colorScheme
                                           andConfig:(nonnull PLTLinearConfig *)config NS_DESIGNATED_INITIALIZER;

@end
