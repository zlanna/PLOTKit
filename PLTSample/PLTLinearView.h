
//
//  PLTLinearView.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

@class PLTLinearStyleContainer;
@class PLTChartData;

@protocol PLTLinearChartDataSource <NSObject>

- (nonnull PLTChartData *)dataForLinearChart;

@end


@interface PLTLinearView : UIView

@property (nonatomic, weak, nullable) id<PLTLinearChartDataSource> dataSource;
@property (nonatomic, strong, nullable) id<PLTLinearStyleContainer> styleContainer;

@property (nonatomic, copy, nullable) NSString *chartName;
@property (nonatomic, copy, nullable) NSString *axisXName;
@property (nonatomic, copy, nullable) NSString *axisYName;

- (null_unspecified instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(null_unspecified NSCoder *)aDecoder NS_UNAVAILABLE;

@end
