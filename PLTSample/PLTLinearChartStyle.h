//
//  PLTLinearChartStyle.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 06.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//
#import "PLTLinearBasicChartStyle.h"
#import "PLTMarker.h"

@interface PLTLinearChartStyle : PLTLinearBasicChartStyle

@property(nonatomic) BOOL hasFilling;
@property(nonatomic) BOOL hasMarkers;
@property(nonatomic) PLTLinearChartAnimation animation;
@property(nonatomic) PLTLinearChartInterpolation interpolationStrategy;
@property(nonatomic, strong, nonnull) UIColor *chartColor;
@property(nonatomic) PLTMarkerType markerType;
@property(nonatomic) CGFloat lineWeight;

- (nonnull instancetype)init NS_UNAVAILABLE;

+ (nonnull instancetype)blank;

@end
