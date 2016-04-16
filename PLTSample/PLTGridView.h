//
//  PLTGrid.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

@class PLTGridStyle;

@protocol PLTGridViewDelegate <NSObject>

- (nonnull PLTGridStyle *)gridStyle;

@end

@interface PLTGridView : UIView

@property(nonatomic, weak, nullable) id<PLTGridViewDelegate> delegate;

- (null_unspecified instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(null_unspecified NSCoder *)aDecoder NS_UNAVAILABLE;

@end
