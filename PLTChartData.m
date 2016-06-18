//
//  PLTChartData.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 20.04.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTChartData.h"

typedef NSArray<NSArray<NSNumber *>*> PLTDataContainer;

@interface PLTChartData ()

@property (nonatomic, strong, nullable) PLTDataContainer *data;

@end


@implementation PLTChartData

@synthesize data;

- (void)addPointWithXValue:(nonnull NSNumber *)xValue andYValue:(nonnull NSNumber *)yValue {
  if (self.data) {
    self.data = [self.data arrayByAddingObjectsFromArray:@[@[xValue, yValue]]];
  }
  else {
    self.data = @[@[xValue, yValue]];
  }
}

- (nullable ChartData *)internalData {
  if (self.data) {
    NSMutableArray *xDataSet = [NSMutableArray new];
    NSMutableArray *yDataSet = [NSMutableArray new];
    for (NSArray *container in self.data) {
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
  if (self.data) {
    return self.data.count;
  }
  else {
    return 0;
  }
}

@end
