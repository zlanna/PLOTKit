//
//  PLTColorSheme.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 27.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface PLTColorScheme : NSObject

//  Grid color scheme
@property(nonatomic, strong, nonnull) UIColor *gridVerticalLineColor;
@property(nonatomic, strong, nonnull) UIColor *gridHorizontalLineColor;
@property(nonatomic, strong, nonnull) UIColor *gridBackgroundColor;
//  Area color scheme
@property(nonatomic, strong, nonnull) UIColor *areaColor;
@property(nonatomic, strong, nonnull) UIColor *chartNameFontColor;
//  Axis X color scheme
@property(nonatomic, strong, nonnull) UIColor *axisXColor;
@property(nonatomic, strong, nonnull) UIColor *axisXLabelFontColor;
//  Axis Y color scheme
@property(nonatomic, strong, nonnull) UIColor *axisYColor;
@property(nonatomic, strong, nonnull) UIColor *axisYLabelFontColor;
//  Chart color scheme
@property(nonatomic, strong, nonnull) UIColor *chartColor;
//  Legend color scheme
@property(nonatomic, strong, nonnull) UIColor *legendLabelColorForNormalState;
@property(nonatomic, strong, nonnull) UIColor *legendLabelColorForSelectedState;
@property(nonatomic, strong, nonnull) UIColor *legendLabelColorForHighlightedState;
@property(nonatomic, strong, nonnull) UIColor *legendTitleColorForNormalState;
@property(nonatomic, strong, nonnull) UIColor *legendTitleColorForSelectedState;
@property(nonatomic, strong, nonnull) UIColor *legendTitleColorForHighlightedState;

- (null_unspecified instancetype)init NS_UNAVAILABLE;

+ (nonnull instancetype)blank;
+ (nonnull instancetype)math;
+ (nonnull instancetype)cobalt;
+ (nonnull instancetype)blackAndGray;

@end
