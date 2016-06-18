//
//  NSArray+SortAndRemove.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 21.04.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;

@interface NSArray (SortAndRemove)

+ (NSArray *)plt_sortAndRemoveDublicatesNumbers:(NSArray<NSNumber *> *)array;
+ (NSArray *)plt_negativeNumbersArray:(NSArray<NSNumber *> *)array;
+ (NSArray *)plt_positiveNumbersArray:(NSArray<NSNumber *> *)array;

@end
