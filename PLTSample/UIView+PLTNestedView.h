//
//  UIView+PLTNestedView.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 03.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

@interface UIView (PLTNestedView)

+ (CGRect)plt_nestedViewFrame:(CGRect) containerFrame nestedScaled:(CGFloat) scale;

@end
