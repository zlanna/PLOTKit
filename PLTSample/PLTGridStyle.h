//
//  PLTGridStyle.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 03.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;
@import UIKit;

typedef NS_ENUM(NSUInteger, PLTLineStyle) {
  PLTLineStyleDot,
  PLTLineStyleSolid,
  PLTLineStyleDash,
  PLTLineStyleNone
};

typedef NS_ENUM(NSUInteger, PLTGridLabelVerticalPosition) {
  PLTGridLabelVerticalPositionNone,
  PLTGridLabelVerticalPositionTop,
  PLTGridLabelVerticalPositionBottom
};

typedef NS_ENUM(NSUInteger, PLTGridLabelHorizontalPosition) {
  PLTGridLabelHorizontalPositionNone,
  PLTGridLabelHorizontalPositionLeft,
  PLTGridLabelHorizontalPositionRight
};

NSString *_Nonnull pltStringFromLineStyle(PLTLineStyle style);
NSString *_Nonnull pltStringFromGridLabelsVerticalPosition(PLTGridLabelVerticalPosition position);
NSString *_Nonnull pltStringFromGridLabelsHorizontalPosition(PLTGridLabelHorizontalPosition position);

@interface PLTGridStyle : NSObject

@property(nonatomic) BOOL horizontalGridlineEnable;
@property(nonatomic, strong, nullable) UIColor *horizontalLineColor;

@property(nonatomic) BOOL verticalGridlineEnable;
@property(nonatomic, strong, nullable) UIColor *verticalLineColor;

@property(nonatomic, strong, nonnull) UIColor *backgroundColor;

@property(nonatomic) BOOL hasLabels;
@property(nonatomic) PLTGridLabelHorizontalPosition horizontalLabelPosition;
@property(nonatomic) PLTGridLabelVerticalPosition verticalLabelPosition;
@property(nonatomic, strong, nonnull) UIColor *labelFontColor;

@property(nonatomic) PLTLineStyle lineStyle;
@property(nonatomic) CGFloat lineWeight;

- (null_unspecified instancetype)init NS_UNAVAILABLE;

+ (nonnull instancetype)blank;
+ (nonnull instancetype)defaultStyle;

@end
