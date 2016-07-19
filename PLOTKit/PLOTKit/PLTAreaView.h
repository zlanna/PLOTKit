//
//  PLTArea.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

@class PLTAreaStyle;

@interface PLTAreaView : UIView

@property(nonatomic, weak, nullable) id<PLTStyleSource> styleSource;

- (null_unspecified instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(null_unspecified NSCoder *)aDecoder NS_UNAVAILABLE;
- (null_unspecified instancetype)init NS_UNAVAILABLE;

@end
