//
//  PLTBaseLinearChartView+Protected.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 14.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTBaseLinearChartView.h"

typedef NSDictionary<NSString *,NSArray<NSNumber *> *> ChartData;
typedef __kindof NSArray<NSValue *> ChartPoints;

@interface PLTBaseLinearChartView (Protected)

@property(nonatomic, strong, nullable) ChartData *chartData;
@property(nonatomic, strong, nullable) ChartPoints *chartPoints;

- (void)drawMarkers;
- (void)drawPin;
- (nonnull ChartPoints *)prepareChartPoints:(CGRect)rect;

@end
