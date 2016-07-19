//
//  PLTAxisView+Protected.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 19.07.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import "PLTAxisView.h"

@interface PLTAxisView (Protected)

@property(nonatomic) NSUInteger marksCount;
@property(nonatomic, strong, nullable) UILabel *axisNameLabel;
@property(nonatomic, strong, nonnull) LabelsCollection *labels;
@property(nonatomic, strong, nonnull) MarkerPoints *markerPoints;

@end
