//
//  PLTStyleContainer+Protected.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 14.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTStyleContainer.h"

@interface PLTStyleContainer (Protected)

@property(nonatomic, strong, nonnull) PLTGridStyle *gridStyle;
@property(nonatomic, strong, nonnull) PLTAxisXStyle *axisXStyle;
@property(nonatomic, strong, nonnull) PLTAxisYStyle *axisYStyle;
@property(nonatomic, strong, nonnull) PLTAreaStyle *areaStyle;
@property(nonatomic, strong, nonnull) PLTLegendStyle *legendStyle;

@end
