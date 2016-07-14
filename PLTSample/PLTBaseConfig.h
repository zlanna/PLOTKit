//
//  PLTBaseConfig.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 14.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;
#import "PLTBaseConfig.h"
#import "PLTGridStyle.h"
#import "PLTAxisStyle.h"
#import "PLTMarker.h"
#import "PLTAxisXStyle.h"
#import "PLTAxisYStyle.h"

@interface PLTBaseConfig : NSObject
//  Grid config
@property(nonatomic) BOOL horizontalGridlineEnable;
@property(nonatomic) BOOL verticalGridlineEnable;
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
@property(nonatomic) PLTAxisXLabelPosition xLabelPosition;
@property(nonatomic) BOOL xHasLabels;
//  Axis Y config
@property(nonatomic) BOOL yHidden;
@property(nonatomic) BOOL yHasArrow;
@property(nonatomic) BOOL yHasName;
@property(nonatomic) BOOL yHasMarks;
@property(nonatomic) BOOL yIsAutoformat;
@property(nonatomic) BOOL yIsStickToZero;
@property(nonatomic) PLTMarksType yMarksType;
@property(nonatomic) CGFloat yAxisLineWeight;
@property(nonatomic) PLTAxisYLabelPosition yLabelPosition;
@property(nonatomic) BOOL yHasLabels;

- (null_unspecified instancetype)init NS_UNAVAILABLE;

+ (nonnull instancetype)math;
+ (nonnull instancetype)stocks;
+ (nonnull instancetype)blackAndGray;

@end
