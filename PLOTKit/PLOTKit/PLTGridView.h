//
//  PLTGrid.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

@class PLTGridStyle;

@protocol PLTInternalLinearChartDataSource;

@interface PLTGridView : UIView

@property(nonatomic, weak, nullable) id<PLTStyleSource> styleSource;
@property(nonatomic, weak, nullable) id<PLTInternalLinearChartDataSource> dataSource;
@property(nonatomic) CGFloat xConstriction;
@property(nonatomic) CGFloat yConstriction;

- (null_unspecified instancetype)init NS_DESIGNATED_INITIALIZER;
- (null_unspecified instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(null_unspecified NSCoder *)aDecoder NS_UNAVAILABLE;

@end
