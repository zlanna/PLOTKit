//
//  PLTChartData.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 20.04.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTChartData.h"

typedef NSArray<NSArray<id<PLTStringValue>>*> PLTDataContainer;
typedef NSDictionary<NSString *,PLTDataContainer *> PLTSeriesContainer;

@interface PLTChartData ()

@property (nonatomic, copy, nullable) PLTDataContainer *data;
@property (nonatomic, copy, nullable) PLTSeriesContainer *series;

@end


@implementation PLTChartData

@synthesize data;
@synthesize series;

- (void)addPointWithXValue:(nonnull id<PLTStringValue>)xValue andYValue:(nonnull NSNumber *)yValue {
  if (self.data) {
    self.data = [self.data arrayByAddingObjectsFromArray:@[@[xValue, yValue]]];
  }
  else {
    self.data = @[@[xValue, yValue]];
  }
}

- (void)addPointWithArgument:(nonnull id<PLTStringValue>)argument
                    andValue:(nonnull NSNumber *)value
                    forSeries:(nonnull NSString *)seriesName{
  if (self.series) {
    self.data = self.series[seriesName];
    [self addPointWithXValue:argument andYValue:value];
    NSMutableDictionary *newSeries = [self.series mutableCopy];
    newSeries[seriesName] = self.data;
    self.series = [newSeries copy];
  }
  else {
    self.series = @{
                    seriesName:@[@[argument, value]],
                    };
  }
}

- (nullable ChartData *)internalData {
  if (self.series) {
    NSMutableOrderedSet *xDataSet = [NSMutableOrderedSet new];
    NSMutableSet *yDataSet = [NSMutableSet new];
    for (NSString *key in self.series) {
      for (NSArray *container in self.series[key]) {
        [xDataSet addObject:container[0]];
        [yDataSet addObject:container[1]];
      }
    }
    return @{
             kPLTXAxis:[xDataSet array],
             kPLTYAxis:[yDataSet allObjects]
             };
  }
  else {
    return nil;
  }
}

- (nullable NSArray<NSString *> *)seriesNames {
  if (self.series && self.series.count>0) {
    NSMutableArray<NSString *> *seriesNames = [[NSMutableArray alloc] initWithCapacity:self.series.count];
    for (NSString *seriesName in self.series) {
      [seriesNames addObject:seriesName];
    }
    return [seriesNames copy];
  }
  else {
    return nil;
  }
}

- (NSUInteger)seriesIndex:(nonnull NSString*)seriesName{
  NSUInteger seriesIndex = NSUIntegerMax;
  if (self.series) {
    NSArray *seriesNames = [self.series allKeys];
    seriesIndex = [seriesNames indexOfObject:seriesName];
  }
  return seriesIndex;
}

// FIXME: May be change semantic of xDataSet, yDataSet
- (nullable ChartData *)dataForSeriesWithName:(nullable NSString *)seriesName{
  if (self.series) {
    NSArray *seriesData;
    NSMutableArray *xDataSet = [NSMutableArray new];
    NSMutableArray *yDataSet = [NSMutableArray new];
    if (seriesName) {
      seriesData = self.series[(NSString *_Nonnull)seriesName];
    }
    else {
      // FIXME: Empty array
      seriesData = [self.series allValues][0];
      
    }
    if (seriesData.count == 0) return nil;
    for (NSArray *container in seriesData) {
      [xDataSet addObject:container[0]];
      [yDataSet addObject:container[1]];
    }
    return @{
             kPLTXAxis:[xDataSet copy],
             kPLTYAxis:[yDataSet copy]
             };
  }
  else {
    return nil;
  }
}

- (NSUInteger)count {
  if (self.series) {
    return self.series.count;
  }
  else {
    return 0;
  }
}

- (NSString *)description {
  return [NSString stringWithFormat:@"%@", self.series];
}

@end
