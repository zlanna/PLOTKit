//
//  PLTAxis.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 04.02.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PLTAxisDelegate <NSObject>

- (CGRect)axisFrame;

@optional
- (NSUInteger)axisXMarksCount;
- (NSUInteger)axisYMarksCount;

@end


@class PLTAxisStyle;

@interface PLTAxis : UIView

@property(nonatomic, weak, nullable) id<PLTAxisDelegate> delegate;
@property(nonatomic, strong, readonly, nonnull) PLTAxisStyle *style;

- (nonnull instancetype)initWithStyle:(nonnull PLTAxisStyle *)style;

@end
