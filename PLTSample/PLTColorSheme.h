//
//  PLTColorSheme.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 27.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface PLTColorSheme : NSObject

//  Grid color scheme
@property(nonatomic, strong, nonnull) UIColor *gridVerticalLineColor;
@property(nonatomic, strong, nonnull) UIColor *gridHorizontalLineColor;
@property(nonatomic, strong, nonnull) UIColor *gridBackgroundColor;
@property(nonatomic, strong, nonnull) UIColor *gridLabelFontColor;
//  Chart color scheme
@property(nonatomic, strong, nonnull) UIColor *chartLineColor;
//  Area color scheme
@property(nonatomic, strong, nonnull) UIColor *areaColor;
//  Axis color scheme
@property(nonatomic, strong, nonnull) UIColor *axisXColor;
@property(nonatomic, strong, nonnull) UIColor *axisYColor;

- (null_unspecified instancetype)init NS_UNAVAILABLE;

+ (nonnull instancetype)blank;
+ (nonnull instancetype)math;
+ (nonnull instancetype)cobalt;

@end
