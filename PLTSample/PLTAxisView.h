//
//  PLTAxis.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 04.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;
#import "PLTAxisStyle.h"

typedef NSMutableArray<UILabel *> LabelsCollection;
typedef __kindof NSArray<NSValue *> MarkerPoints;

static CGFloat const kPLTLabelToAxisOffset = 20.0;
static CGFloat const kPLTMaxAxisLabelWidth = 100;

@protocol PLTInternalLinearChartDataSource;

typedef NS_ENUM(NSUInteger, PLTAxisType){
  PLTAxisTypeX,
  PLTAxisTypeY
};

@interface PLTAxisView : UIView

@property(nonatomic, weak, nullable) id<PLTStyleSource> styleSource;
@property(nonatomic, weak, nullable) id<PLTInternalLinearChartDataSource> dataSource;
@property(nonatomic, strong, nonnull) PLTAxisStyle *style;
@property(nonatomic, copy, nullable) NSString *axisName;
@property(nonatomic) CGFloat constriction;
// FIXME: Мне вот это совсем не нравится. Тут не должно быть ничего доступного снаружи
@property(nonatomic) NSUInteger marksCount;
@property(nonatomic, strong, nullable) UILabel *axisNameLabel;
@property(nonatomic, strong, nonnull) LabelsCollection *labels;
@property(nonatomic, strong, nonnull) MarkerPoints *markerPoints;
@property(nonatomic, strong, nonnull) UIFont *axisNameLabelFont;
@property(nonatomic, strong, nonnull) UIFont *axisLabelsFont;

- (null_unspecified instancetype)init NS_UNAVAILABLE;
- (null_unspecified instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(null_unspecified NSCoder *)aDecoder NS_UNAVAILABLE;

+ (nonnull instancetype)axisWithType:(PLTAxisType)type andFrame:(CGRect)frame;

@end

