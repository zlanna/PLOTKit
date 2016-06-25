//
//  PLTBarChart.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

@class PLTLinearChartStyle;

@protocol PLTInternalLinearChartDataSource;

@interface PLTBarChartView : UIView

@property(nonatomic, weak, nullable) id<PLTStyleSource> styleSource;
@property(nonatomic, weak, nullable) id<PLTInternalLinearChartDataSource> dataSource;
@property(nonatomic) BOOL isPinAvailable;

- (null_unspecified instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(null_unspecified NSCoder *)aDecoder NS_UNAVAILABLE;

@end
