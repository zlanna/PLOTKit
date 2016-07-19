//
//  PLTBarChartView+Protected.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 17.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTBarChartView.h"

typedef __kindof NSArray<NSValue *> ChartPoints;
typedef NSDictionary<NSString *,NSArray<NSNumber *> *> ChartData;

@interface PLTBarChartView (Protected)

@property(nonatomic, strong, nonnull) PLTBarChartStyle *style;
@property(nonatomic, strong, nullable) ChartPoints *chartPoints;
@property(nonatomic, strong, nullable) ChartData *chartData;
@property(nonatomic) CGFloat yZeroLevel;
@property(nonatomic, readwrite) CGFloat constriction;

@end
