//
//  PLTBarView.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 15.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//
#import "PLTCartesianView.h"

@interface PLTBarView : PLTCartesianView

@property (nonatomic, weak, nullable) id<PLTBarChartDataSource> dataSource;
@property (nonatomic, strong, nullable) id<PLTBarStyleContainer> styleContainer;

@end
