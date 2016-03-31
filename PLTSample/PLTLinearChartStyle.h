//
//  PLTLinearChartStyle.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 06.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;
@import UIKit;

typedef NS_ENUM(NSUInteger, PLTLinearChartAnimation) {
  PLTLinearChartAnimationNone,
  PLTLinearChartAnimationAxisX,
  PLTLinearChartAnimationAxisY,
  PLTLinearChartAnimationAxisXY
};

typedef NS_ENUM(NSUInteger, PLTLinearChartInterpolation) {
  PLTLinearChartInterpolationLinear,
  PLTLinearChartInterpolationCube,
  PLTLinearChartInterpolationSpline
};

@interface PLTLinearChartStyle : NSObject

@property(nonatomic) BOOL hasFilling;
@property(nonatomic) BOOL hasMarkers;
@property(nonatomic) PLTLinearChartAnimation animation;
@property(nonatomic) PLTLinearChartInterpolation interpolationStrategy;
@property(nonatomic, strong, nonnull) UIColor *chartLineColor;

- (nonnull instancetype)init NS_UNAVAILABLE;

+ (nonnull instancetype)blank;
+ (nonnull instancetype)defaultStyle;

@end
