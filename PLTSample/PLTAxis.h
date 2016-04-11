//
//  PLTAxis.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 04.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;


@protocol PLTAxisDelegate <NSObject>

- (CGRect)axisFrame;

@optional
- (NSUInteger)axisXMarksCount;
- (NSUInteger)axisYMarksCount;

@end

typedef NS_ENUM(NSUInteger, PLTAxisType){
  PLTAxisTypeX,
  PLTAxisTypeY
};


@class PLTAxisStyle;

@interface PLTAxis : UIView

@property(nonatomic, weak, nullable) id<PLTAxisDelegate> delegate;
@property(nonatomic, strong, readonly, nonnull) PLTAxisStyle *style;

- (null_unspecified instancetype)init NS_UNAVAILABLE;
- (null_unspecified instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(null_unspecified NSCoder *)aDecoder NS_UNAVAILABLE;

+ (nonnull instancetype)axisWithType:(PLTAxisType)type andStyle:(nonnull PLTAxisStyle *)style;

@end
