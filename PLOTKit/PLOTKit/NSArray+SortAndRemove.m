//
//  NSArray+SortAndRemove.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 21.04.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "NSArray+SortAndRemove.h"

@implementation NSArray (SortAndRemove)

+ (NSArray *)plt_sortAndRemoveDublicatesNumbers:(NSArray<NSNumber *> *)array {
  return [[NSOrderedSet orderedSetWithArray:array]
          sortedArrayUsingComparator:^NSComparisonResult(NSNumber *number1, NSNumber *number2) {
    if ([number1 doubleValue] > [number2 doubleValue]) {
      return NSOrderedDescending;
    }
    else {
      return NSOrderedAscending;
    }
  }];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"

+ (NSArray *)plt_negativeNumbersArray:(NSArray<NSNumber *> *)array{
  NSMutableArray *resultArray = [[NSMutableArray alloc] init];
  [array enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL * _Nonnull stop) {
    if([number doubleValue] < 0.0){
      [resultArray addObject:number];
    }
  }];
  return [resultArray copy];
}

+ (NSArray *)plt_positiveNumbersArray:(NSArray<NSNumber *> *)array{
  NSMutableArray *resultArray = [[NSMutableArray alloc] init];
  [array enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL * _Nonnull stop) {
    if([number doubleValue] >= 0.0){
      [resultArray addObject:number];
    }
  }];
  return [resultArray copy];
}

#pragma clang diagnostic pop

@end
