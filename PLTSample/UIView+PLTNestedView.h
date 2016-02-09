//
//  UIView+PLTNestedView.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 03.02.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (PLTNestedView)

+ (CGRect)plt_nestedViewFrame:(CGRect) containerFrame nestedScaled:(float) scale;

@end
