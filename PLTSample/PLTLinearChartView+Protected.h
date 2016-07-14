//
//  PLTLinearChartView+Protected.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 13.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLinearChartView.h"

typedef NSDictionary<NSString *,NSArray<NSNumber *> *> ChartData;
typedef __kindof NSArray<NSValue *> ChartPoints;

@interface PLTLinearChartView (Protected)

@property(nonatomic, strong, nullable) ChartData *chartData;
@property(nonatomic, strong, nullable) ChartPoints *chartPoints;

- (void)drawMarkers;
- (void)drawPin;
- (nonnull ChartPoints *)prepareChartPoints:(CGRect)rect;

@end
