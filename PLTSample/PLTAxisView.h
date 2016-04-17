//
//  PLTAxis.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 04.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

@protocol PLTAxisDelegate <NSObject>

@optional
- (NSUInteger)axisXMarksCount;
- (NSUInteger)axisYMarksCount;

@end

typedef NS_ENUM(NSUInteger, PLTAxisType){
  PLTAxisTypeX,
  PLTAxisTypeY
};

@interface PLTAxisView : UIView

@property(nonatomic, weak, nullable) id<PLTAxisDelegate, PLTStyleSource> delegate;

- (null_unspecified instancetype)init NS_UNAVAILABLE;
- (null_unspecified instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(null_unspecified NSCoder *)aDecoder NS_UNAVAILABLE;

+ (nonnull instancetype)axisWithType:(PLTAxisType)type andFrame:(CGRect)frame;

@end

