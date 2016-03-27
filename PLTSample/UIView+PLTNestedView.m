//
//  UIView+PLTNestedView.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 03.02.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import "UIView+PLTNestedView.h"

@implementation UIView (PLTNestedView)

+ (CGRect)plt_nestedViewFrame:(CGRect) containerFrame nestedScaled:(float) scale{
  CGFloat scaleFactor = scale;
  
  CGFloat xOriginDelta = containerFrame.size.width*scaleFactor / 2;
  CGFloat yOriginDelta = containerFrame.size.height*scaleFactor /2;
  
  CGPoint newOrigin = CGPointMake(containerFrame.origin.x + xOriginDelta,
                                  containerFrame.origin.y + yOriginDelta);
  
  CGSize newSize = CGSizeMake(containerFrame.size.width * (1.0f - scaleFactor),
                              containerFrame.size.height * (1.0f - scaleFactor));
  
  return CGRectMake(newOrigin.x, newOrigin.y, newSize.width, newSize.height);
}

@end
