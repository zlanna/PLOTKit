//
//  PLTChartData.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 20.04.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;

// TODO: Разобраться, что делать с этим объявлением (пока оставлю так)
typedef NSDictionary<NSString *,NSArray<NSNumber *> *> ChartData;

@interface PLTChartData : NSObject

- (void)addPointWithXValue:(nonnull id<PLTStringValue>)xValue andYValue:(nonnull NSNumber *)yValue;

- (nullable ChartData *)internalData;
- (NSUInteger)count;

@end
