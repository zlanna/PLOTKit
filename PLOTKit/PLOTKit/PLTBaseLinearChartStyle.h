//
//  PLTBaseLinearChartStyle.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 13.07.16.
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
  PLTLinearChartInterpolationSpline
};

NSString *_Nonnull pltStringFromLineatChartAnimation(PLTLinearChartAnimation animation);
NSString *_Nonnull pltStringFromLinearChartInterpolation(PLTLinearChartInterpolation interpolation);

@interface PLTBaseLinearChartStyle : NSObject

- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;

@end
