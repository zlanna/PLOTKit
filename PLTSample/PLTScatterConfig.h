//
//  PLTScatterConfig.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 14.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTBaseConfig.h"
#import "PLTLinearChartStyle.h"

@interface PLTScatterConfig : PLTBaseConfig
//  Chart config
@property(nonatomic) PLTMarkerType chartMarkerType;
@property(nonatomic) CGFloat chartMarkerSize;

- (null_unspecified instancetype)init NS_UNAVAILABLE;

+ (nonnull instancetype)blank;
+ (nonnull instancetype)math;
+ (nonnull instancetype)stocks;
+ (nonnull instancetype)blackAndGray;

@end
