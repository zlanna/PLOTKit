//
//  PLTPin.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

@protocol PLTPinViewDataSource <NSObject>


@end


@interface PLTPinView : UIView

@property(nonatomic, weak, nullable) id<PLTPinViewDataSource> dataSource;
@property(nonatomic, strong, null_unspecified) UIColor *pinColor;

@end
