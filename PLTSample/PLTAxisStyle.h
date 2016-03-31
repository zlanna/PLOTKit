//
//  PLTAxisStyle.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 04.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;
@import UIKit;


typedef NS_ENUM(NSUInteger, PLTMarksType) {
  PLTMarksTypeCenter,
  PLTMarksTypeInside,
  PLTMarksTypeOutside
};


@interface PLTAxisStyle : NSObject

@property(nonatomic) BOOL hidden;
@property(nonatomic) BOOL hasArrow;
@property(nonatomic) BOOL hasName;
@property(nonatomic) BOOL hasMarks;
@property(nonatomic) BOOL isAutoformat;
@property(nonatomic) PLTMarksType marksType;
@property(nonatomic, strong, nonnull) UIColor *axisColor;
@property(nonatomic) CGFloat axisLineWeight;

- (null_unspecified instancetype)init NS_UNAVAILABLE;

+ (nonnull instancetype)blank;
+ (nonnull instancetype)defaultStyle;

@end
