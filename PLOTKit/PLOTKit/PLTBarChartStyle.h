//
//  PLTBarChartStyle.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 25.06.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;

@interface PLTBarChartStyle : NSObject

@property(nonatomic, strong, nonnull) UIColor *chartColor;

- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)blank;

@end
