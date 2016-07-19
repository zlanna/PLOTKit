//
//  PLTChartData.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 20.04.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;

// TODO: Need rules for aliases naming
typedef NSDictionary<NSString *,NSArray<NSNumber *> *> ChartData;

@interface PLTChartData : NSObject

- (void)addPointWithArgument:(nonnull id<PLTStringValue>)argument
                    andValue:(nonnull NSNumber *)value
                    forSeries:(nonnull NSString *)seriesName;

- (nullable ChartData *)internalData;// FIXME: Change method's semantics
- (nullable ChartData *)dataForSeriesWithName:(nullable NSString *)seriesName;
- (nullable NSArray<NSString *> *)seriesNames;
- (NSUInteger)seriesIndex:(nonnull NSString*)seriesName;
- (NSUInteger)count;

@end
