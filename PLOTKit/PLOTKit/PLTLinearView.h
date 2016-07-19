//
//  PLTLinearView.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//
#import "PLTCartesianView.h"

@interface PLTLinearView : PLTCartesianView

@property (nonatomic, weak, nullable) id<PLTLinearChartDataSource> dataSource;
@property (nonatomic, strong, nullable) id<PLTLinearStyleContainer> styleContainer;

@end
