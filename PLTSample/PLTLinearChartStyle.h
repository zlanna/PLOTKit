//
//  PLTLinearChartStyle.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 06.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;
@import UIKit;

#import "PLTMarker.h"

typedef NS_ENUM(NSUInteger, PLTLinearChartAnimation) {
  PLTLinearChartAnimationNone,
  PLTLinearChartAnimationAxisX,
  PLTLinearChartAnimationAxisY,
  PLTLinearChartAnimationAxisXY
};

typedef NS_ENUM(NSUInteger, PLTLinearChartInterpolation) {
  PLTLinearChartInterpolationLinear,
  PLTLinearChartInterpolationSpline
};

NSString *_Nonnull pltStringFromLineatChartAnimation(PLTLinearChartAnimation animation);
NSString *_Nonnull pltStringFromLinearChartInterpolation(PLTLinearChartInterpolation interpolation);

@interface PLTLinearChartStyle : NSObject

@property(nonatomic) BOOL hasFilling;
@property(nonatomic) BOOL hasMarkers;
@property(nonatomic) PLTLinearChartAnimation animation;
@property(nonatomic) PLTLinearChartInterpolation interpolationStrategy;
@property(nonatomic, strong, nonnull) UIColor *chartLineColor;
@property(nonatomic) PLTMarkerType markerType;
@property(nonatomic) CGFloat lineWeight;

- (nonnull instancetype)init NS_UNAVAILABLE;

+ (nonnull instancetype)blank;

@end
