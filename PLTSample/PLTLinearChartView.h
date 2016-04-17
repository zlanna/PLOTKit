//
//  PLTLinearChart.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 06.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

typedef NSDictionary<NSString *,NSArray<NSNumber *> *> ChartData;

@class PLTLinearChartStyle;

@interface PLTLinearChartView : UIView

@property(nonatomic, weak, nullable) id<PLTStyleSource> styleSource;
@property(nonatomic, strong, nullable) ChartData *chartData;

- (null_unspecified instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(null_unspecified NSCoder *)aDecoder NS_UNAVAILABLE;

@end
