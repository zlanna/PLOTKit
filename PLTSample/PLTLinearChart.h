//
//  PLTLinearChart.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 06.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

typedef NSDictionary<NSString *,NSArray<NSNumber *> *> ChartData;

@protocol PLTLinearChartDelegate <NSObject>

- (CGRect)chartFrame;

@end

@class PLTLinearChartStyle;


@interface PLTLinearChart : UIView

@property(nonatomic, weak, nullable) id<PLTLinearChartDelegate> delegate;
@property(nonatomic, strong, nullable) ChartData *chartData;

- (null_unspecified instancetype)initWithStyle:(nonnull PLTLinearChartStyle *)style NS_DESIGNATED_INITIALIZER;
- (null_unspecified instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(null_unspecified NSCoder *)aDecoder NS_UNAVAILABLE;

@end
