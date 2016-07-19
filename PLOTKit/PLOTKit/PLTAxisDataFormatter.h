//
//  PLTFormatter.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;

@interface PLTAxisDataFormatter : NSObject

+ (nullable NSArray<NSNumber *> *)axisDataSetFromChartValues:(nullable NSArray<NSNumber *> *)chartValuesData
                               withGridLinesCount:(NSUInteger)gridLinesCount;

@end
