//
//  PLTCartesianView+Protected.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 14.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTCartesianView.h"

@class PLTAxisView;
@class PLTLegendView;

@interface PLTCartesianView (Protected)
@property(nonatomic, strong, nullable) ChartData *chartData;
@property(nonatomic, strong, nonnull) PLTGridView *gridView;
@property(nonatomic, strong, nonnull) PLTAxisView *xAxisView;
@property(nonatomic, strong, nonnull) PLTAxisView *yAxisView;
@property(nonatomic,strong, nonnull) PLTLegendView *legendView;
@property(nonatomic, strong, nonnull) NSMutableDictionary<NSString *,PLTLinearChartView *> *chartViews;
@end
