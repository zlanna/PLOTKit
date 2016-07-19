//
//  PLTLinearConfig.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 27.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;

#import "PLTBaseConfig.h"
#import "PLTLinearChartStyle.h"

@interface PLTLinearConfig : PLTBaseConfig
//  Chart config
@property(nonatomic) BOOL chartHasFilling;
@property(nonatomic) BOOL chartHasMarkers;
@property(nonatomic) PLTMarkerType chartMarkerType;
@property(nonatomic) CGFloat chartLineWeight;
@property(nonatomic) PLTLinearChartInterpolation chartInterpolation;
@property(nonatomic) CGFloat chartMarkerSize;

- (null_unspecified instancetype)init NS_UNAVAILABLE;

+ (nonnull instancetype)blank;
+ (nonnull instancetype)math;
+ (nonnull instancetype)stocks;
+ (nonnull instancetype)blackAndGray;

@end
