//
//  PLTTriangleMarker.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 18.06.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTTriangleMarker.h"

@implementation PLTTriangleMarker

- (UIImage *)createImage {
  CGSize markerSize = CGSizeMake( 2*self.size, 2*self.size);
  
  UIGraphicsBeginImageContext(markerSize);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextSetFillColorWithColor(context, [self.color CGColor]);
  
  CGRect markerRect = CGRectMake(0.0, 0.0, 2*self.size, 2*self.size);
  
  CGContextBeginPath(context);
  
  CGContextMoveToPoint(context, CGRectGetMinX(markerRect), CGRectGetMaxY(markerRect));
  CGContextAddLineToPoint(context, CGRectGetMidX(markerRect), CGRectGetMinY(markerRect));
  CGContextAddLineToPoint(context, CGRectGetMaxX(markerRect), CGRectGetMaxY(markerRect));
  
  CGContextClosePath(context);
  CGContextFillPath(context);
  
  UIImage *markerImage = UIGraphicsGetImageFromCurrentImageContext();
  CGContextRestoreGState(context);
  UIGraphicsEndImageContext();
  
  return markerImage;
}

@end
