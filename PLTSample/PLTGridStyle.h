//
//  PLTGridStyle.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 03.02.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum PLTLineStyle {
  PLTLineStyleDot,
  PLTLineStyleSolid,
  PLTLineStyleDash,
  PLTLineStyleNone
} PLTLineStyle;

typedef enum PLTGridLabelVerticalPosition {
  PLTGridLabelVerticalPositionNone,
  PLTGridLabelVerticalPositionTop,
  PLTGridLabelVerticalPositionBottom
} PLTGridLabelVerticalPosition;

typedef enum PLTGridLabelHorizontalPosition {
  PLTGridLabelHorizontalPositionNone,
  PLTGridLabelHorizontalPositionLeft,
  PLTGridLabelHorizontalPositionRight
} PLTGridLabelHorizontalPosition;


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
@property(nonatomic) float lineWeight;

+ (nonnull PLTGridStyle *)blank;
+ (nonnull PLTGridStyle *)defaultStyle;

@end
