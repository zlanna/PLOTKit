//
//  PLTScatterView.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 13.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTCartesianView.h"

@interface PLTScatterView : PLTCartesianView

@property (nonatomic, weak, nullable) id<PLTScatterChartDataSource> dataSource;
@property (nonatomic, strong, nullable) id<PLTScatterStyleContainer> styleContainer;

@end
