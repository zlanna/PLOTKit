//
//  PLTSpline.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 11.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;

@interface PLTSpline : NSObject

- (nonnull NSArray<NSValue *> *)interpolatedChartPoints:(nonnull NSArray<NSValue *> *)chartPoints;

@end
