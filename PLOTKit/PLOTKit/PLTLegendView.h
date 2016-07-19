//
//  PLTLegendView.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

@protocol PLTLegendViewDataSource <NSObject>

- (nullable NSDictionary<NSString *, PLTLinearChartStyle *> *)chartViewsLegend;
- (void)selectChart:(nullable NSString *)chartName;

@end


@interface PLTLegendView : UIView<PLTAutolayoutHeight>

@property(nonatomic, weak, nullable) id<PLTLegendViewDataSource> dataSource;

- (null_unspecified instancetype)init NS_DESIGNATED_INITIALIZER;

- (null_unspecified instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;

@end
