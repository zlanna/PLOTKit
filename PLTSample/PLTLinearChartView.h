//
//  PLTLinearChart.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 06.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

@class PLTLinearChartStyle;

@protocol PLTInternalLinearChartDataSource;

@interface PLTLinearChartView : UIView

@property(nonatomic, weak, nullable) id<PLTStyleSource> styleSource;
@property(nonatomic, weak, nullable) id<PLTInternalLinearChartDataSource> dataSource;
@property(nonatomic) BOOL isPinAvailable;
@property(nonatomic, copy, nullable) NSString *seriesName;
@property(nonatomic, readonly) CGFloat chartExpansion;

- (null_unspecified instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(null_unspecified NSCoder *)aDecoder NS_UNAVAILABLE;

@end
