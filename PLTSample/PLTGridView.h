//
//  PLTGrid.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;


@protocol PLTGridViewDelegate <NSObject>

- (CGRect) gridViewFrame;

@end


@class PLTGridStyle;

@interface PLTGridView : UIView

@property(nonatomic, weak, nullable) id<PLTGridViewDelegate> delegate;

- (null_unspecified instancetype)initWithStyle:(nonnull PLTGridStyle *) gridStyle NS_DESIGNATED_INITIALIZER;
- (null_unspecified instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(null_unspecified NSCoder *)aDecoder NS_UNAVAILABLE;

@end
