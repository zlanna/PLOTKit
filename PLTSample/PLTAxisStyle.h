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

NSString *_Nonnull pltStringFromAxisMarkType(PLTMarksType markType);

@interface PLTAxisStyle : NSObject

@property(nonatomic) BOOL hidden;
@property(nonatomic) BOOL hasArrow;
@property(nonatomic) BOOL hasName;
@property(nonatomic) BOOL hasMarks;
@property(nonatomic) BOOL isAutoformat;
@property(nonatomic) BOOL isStickToZero;
@property(nonatomic) PLTMarksType marksType;
@property(nonatomic, strong, nonnull) UIColor *axisColor;
@property(nonatomic) CGFloat axisLineWeight;
@property(nonatomic, strong, nonnull) UIColor *labelFontColor;
@property(nonatomic) BOOL hasLabels;

- (nonnull instancetype)init;

@end
