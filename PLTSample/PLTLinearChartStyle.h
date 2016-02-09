//
//  PLTLinearChartStyle.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 06.02.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum PLTLinearChartAnimation{
  PLTLinearChartAnimationNone,
  PLTLinearChartAnimationAxisX,
  PLTLinearChartAnimationAxisY,
  PLTLinearChartAnimationAxisXY
}PLTLinearChartAnimation;

typedef enum PLTLinearChartInterpolation{
  PLTLinearChartInterpolationLinear,
  PLTLinearChartInterpolationCube,
  PLTLinearChartInterpolationSpline
}PLTLinearChartInterpolation;

@interface PLTLinearChartStyle : NSObject

@property(nonatomic) BOOL hasFilling;
@property(nonatomic) BOOL hasMarkers;
@property(nonatomic) PLTLinearChartAnimation animation;
@property(nonatomic) PLTLinearChartInterpolation interpolationStrategy;
@property(nonatomic, strong, nonnull) UIColor *chartLineColor;

+ (nonnull PLTLinearChartStyle *)defaultStyle;

@end
