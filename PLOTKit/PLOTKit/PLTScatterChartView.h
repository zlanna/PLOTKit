//
//  PLTScatterChartView.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 13.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTBaseLinearChartView.h"

@interface PLTScatterChartView : PLTBaseLinearChartView
@property(nonatomic, weak, nullable) id<PLTScatterStyleSource> styleSource;
@end
