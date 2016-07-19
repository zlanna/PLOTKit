//
//  PLTGridStyle.h
//  PLOTKit
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

NSString *_Nonnull pltStringFromLineStyle(PLTLineStyle style);

@interface PLTGridStyle : NSObject

@property(nonatomic) BOOL horizontalGridlineEnable;
@property(nonatomic, strong, nullable) UIColor *horizontalLineColor;

@property(nonatomic) BOOL verticalGridlineEnable;
@property(nonatomic, strong, nullable) UIColor *verticalLineColor;

@property(nonatomic, strong, nonnull) UIColor *backgroundColor;

@property(nonatomic) PLTLineStyle lineStyle;
@property(nonatomic) CGFloat lineWeight;

- (null_unspecified instancetype)init NS_UNAVAILABLE;

+ (nonnull instancetype)blank;

@end
