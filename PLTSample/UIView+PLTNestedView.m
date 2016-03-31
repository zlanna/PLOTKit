//
//  UIView+PLTNestedView.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 03.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "UIView+PLTNestedView.h"

@implementation UIView (PLTNestedView)

+ (CGRect)plt_nestedViewFrame:(CGRect) containerFrame nestedScaled:(CGFloat)scale {
  CGFloat scaleFactor = scale;
  CGFloat leftEgdeX = CGRectGetMinX(containerFrame);
  CGFloat leftEdgeY = CGRectGetMinY(containerFrame);
  CGFloat width = CGRectGetWidth(containerFrame);
  CGFloat height = CGRectGetHeight(containerFrame);
  
  CGFloat xOriginDelta = width*scaleFactor / 2;
  CGFloat yOriginDelta = height*scaleFactor /2;
  
  CGPoint newOrigin = CGPointMake(leftEgdeX + xOriginDelta, leftEdgeY + yOriginDelta);
  CGSize newSize = CGSizeMake(width * (1.0 - scaleFactor), height * (1.0 - scaleFactor));
  
  return CGRectMake(newOrigin.x, newOrigin.y, newSize.width, newSize.height);
}

@end
