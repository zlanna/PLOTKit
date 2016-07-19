//
//  PLTCrossMarker.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 18.06.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTCrossMarker.h"

@implementation PLTCrossMarker

- (UIImage *)createImage {
  CGSize markerSize = CGSizeMake( 2*self.size, 2*self.size);
  
  UIGraphicsBeginImageContext(markerSize);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextSetStrokeColorWithColor(context, [self.color CGColor]);
  CGContextSetLineWidth(context, 2.0);
  
  CGRect markerRect = CGRectMake(0.0, 0.0, 2*self.size, 2*self.size);
  
  CGContextBeginPath(context);
  
  CGContextMoveToPoint(context, CGRectGetMinX(markerRect), CGRectGetMinY(markerRect));
  CGContextAddLineToPoint(context, CGRectGetMaxX(markerRect), CGRectGetMaxY(markerRect));
  
  CGContextMoveToPoint(context, CGRectGetMinX(markerRect), CGRectGetMaxY(markerRect));
  CGContextAddLineToPoint(context, CGRectGetMaxX(markerRect), CGRectGetMinY(markerRect));
  
  CGContextClosePath(context);
  CGContextStrokePath(context);
  
  UIImage *markerImage = UIGraphicsGetImageFromCurrentImageContext();
  CGContextRestoreGState(context);
  UIGraphicsEndImageContext();
  
  return markerImage;
}

@end
