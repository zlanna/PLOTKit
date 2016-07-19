//
//  PLTCartesianView.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 13.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

@class PLTLinearStyleContainer;
@class PLTChartData;
@class PLTLinearChartView;
@class PLTGridView;

@interface PLTCartesianView : UIView

@property (nonatomic, copy, nullable) NSString *chartName;
@property (nonatomic, copy, nullable) NSString *axisXName;
@property (nonatomic, copy, nullable) NSString *axisYName;

- (null_unspecified instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(null_unspecified NSCoder *)aDecoder NS_UNAVAILABLE;
// FIXME: Temporary solution
- (void)setupSubviews;

@end
