//
//  PLTBarChartView.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;
#import "PLTBaseLinearChartView.h"

@class PLTLinearChartStyle;

@protocol PLTInternalLinearChartDataSource;

@interface PLTBarChartView : PLTBaseLinearChartView

@property(nonatomic, weak, nullable) id<PLTBarStyleSource> styleSource;
@property(nonatomic, weak, nullable) id<PLTInternalBarChartDataSource> dataSource;
@property(nonatomic, copy, nonnull) NSString *seriesName;
@property(nonatomic, readonly) CGFloat chartExpansion;
@property(nonatomic, readonly) CGFloat constriction;

- (null_unspecified instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(null_unspecified NSCoder *)aDecoder NS_UNAVAILABLE;
 
@end
