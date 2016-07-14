//
//  PLTScatterChartStyle.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 13.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//
#import "PLTLinearBasicChartStyle.h"
#import "PLTMarker.h"

@interface PLTScatterChartStyle : PLTLinearBasicChartStyle

@property(nonatomic, strong, nonnull) UIColor *chartColor;
@property(nonatomic) PLTMarkerType markerType;

- (nonnull instancetype)init NS_UNAVAILABLE;

+ (nonnull instancetype)blank;

@end
