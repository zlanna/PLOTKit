//
//  PLTLinearConfig.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 27.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;
#import "PLTGridStyle.h"
#import "PLTAxisStyle.h"

@interface PLTLinearConfig : NSObject

//  Grid config
@property(nonatomic) BOOL horizontalGridlineEnable;
@property(nonatomic) BOOL verticalGridlineEnable;
@property(nonatomic) BOOL gridHasLabels;
@property(nonatomic) PLTGridLabelHorizontalPosition horizontalGridLabelPosition;
@property(nonatomic) PLTGridLabelVerticalPosition verticalGridLabelPosition;
@property(nonatomic) PLTLineStyle gridLineStyle;
@property(nonatomic) CGFloat gridLineWeight;
//  Axis X config
@property(nonatomic) BOOL xHidden;
@property(nonatomic) BOOL xHasArrow;
@property(nonatomic) BOOL xHasName;
@property(nonatomic) BOOL xHasMarks;
@property(nonatomic) BOOL xIsAutoformat;
@property(nonatomic) BOOL xIsStickToZero;
@property(nonatomic) PLTMarksType xMarksType;
@property(nonatomic) CGFloat xAxisLineWeight;
//  Axis Y config
@property(nonatomic) BOOL yHidden;
@property(nonatomic) BOOL yHasArrow;
@property(nonatomic) BOOL yHasName;
@property(nonatomic) BOOL yHasMarks;
@property(nonatomic) BOOL yIsAutoformat;
@property(nonatomic) BOOL yIsStickToZero;
@property(nonatomic) PLTMarksType yMarksType;
@property(nonatomic) CGFloat yAxisLineWeight;
//  Chart config
@property(nonatomic) BOOL chartHasFilling;
@property(nonatomic) BOOL chartHasMarkers;

- (null_unspecified instancetype)init NS_UNAVAILABLE;

+ (nonnull instancetype)blank;
+ (nonnull instancetype)math;
+ (nonnull instancetype)stocks;

@end
