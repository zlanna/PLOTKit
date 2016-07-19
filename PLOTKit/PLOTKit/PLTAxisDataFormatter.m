//
//  PLTFormatter.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAxisDataFormatter.h"

@implementation PLTAxisDataFormatter

+ (nullable NSArray<NSNumber *> *)axisDataSetFromChartValues:(nullable NSArray<NSNumber *> *)chartValuesData
                                         withGridLinesCount:(NSUInteger)gridLinesCount {
  if (chartValuesData) {
    __block double max = 0.0;
    __block double min = 0.0;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"
    [chartValuesData enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      double current = [obj doubleValue];
      if(current>max) max=current;
      if(current<min) min=current;
    }];
#pragma clang diagnostic pop
    
    double absMax = (fabs(max) > fabs(min))?fabs(max):fabs(min);
    double additionalMultiplier = 1;
    double y = absMax;
    
    if (y<10) {
      additionalMultiplier = 10;
      y = y*additionalMultiplier;
    }
    y = ceil(y);
    double digitsCount = floor(log10(y) + 1);
    double multiplier = pow(10, digitsCount - 2);
    double mostSignDigits = y/multiplier;
    double gridEdge;
    if (mostSignDigits <= 20) {
      gridEdge = ceil(mostSignDigits/2)*2;
    }
    else {
      gridEdge = ceil(mostSignDigits/10)*10;
    }
    gridEdge = (gridEdge * multiplier) / additionalMultiplier;
    
    double gridYDelta = gridEdge/gridLinesCount;
    NSMutableArray<NSNumber *> *resultArray = [NSMutableArray<NSNumber *> new];
    
    if ( (max>0) && (min<0) ) {
      if (absMax == fabs(max)) {
        // FIXME: min - gridYDelta/2 в этих условиях есть баг см. trello
        for (NSUInteger i = 0; (gridEdge - i*gridYDelta)>= (min - gridYDelta/2); ++i) {
          [resultArray addObject:[NSNumber numberWithDouble:gridEdge - i*gridYDelta]];
        }
        resultArray = [[[resultArray reverseObjectEnumerator] allObjects] mutableCopy];
      }
      else if (absMax == fabs(min)) {
        for (NSUInteger i = 0; (-gridEdge + i*gridYDelta)<= (max + gridYDelta/2); ++i) {
          [resultArray addObject:[NSNumber numberWithDouble:-gridEdge + i*gridYDelta]];
        }
      }
    }
    else if ((max>0) && (min>=0)) {
      for (NSUInteger i = 0; i<=gridLinesCount; ++i) {
        [resultArray addObject:[NSNumber numberWithDouble:i*gridYDelta]];
      }
    }
    else if ((max<=0) && (min<0)) {
      [resultArray addObject:[NSNumber numberWithDouble:0]];
      for (NSUInteger i = 1; i<=gridLinesCount; ++i) {
        [resultArray addObject:[NSNumber numberWithDouble:-(double)i*gridYDelta]];
      }
      resultArray = [[[resultArray reverseObjectEnumerator] allObjects] mutableCopy];
    }
    return [resultArray copy];
  }
  else {
    return nil;
  }
}

@end
