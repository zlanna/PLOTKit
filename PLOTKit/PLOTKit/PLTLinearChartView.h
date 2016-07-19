//
//  PLTLinearChart.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 06.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//
#import "PLTBaseLinearChartView.h"

@interface PLTLinearChartView : PLTBaseLinearChartView
@property(nonatomic, weak, nullable) id<PLTLinearStyleSource> styleSource;
@end
