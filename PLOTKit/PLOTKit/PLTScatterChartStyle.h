//
//  PLTScatterChartStyle.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 13.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//
#import "PLTBaseLinearChartStyle.h"
#import "PLTMarker.h"

@interface PLTScatterChartStyle : PLTBaseLinearChartStyle

@property(nonatomic, strong, nonnull) UIColor *chartColor;
@property(nonatomic) PLTMarkerType markerType;
@property(nonatomic) CGFloat markerSize;

- (nonnull instancetype)init NS_UNAVAILABLE;

+ (nonnull instancetype)blank;

@end
