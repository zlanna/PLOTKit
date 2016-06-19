//
//  PLTSquareMarker.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 18.06.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTSquareMarker.h"

@implementation PLTSquareMarker

- (UIImage *)createImage {
  CGSize markerSize = CGSizeMake( 2*self.size, 2*self.size);
  UIGraphicsBeginImageContext(markerSize);
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextSetFillColorWithColor(context, [self.color CGColor]);
  
  CGRect markerRect = CGRectMake(0.0, 0.0, 2*self.size, 2*self.size);
  CGContextFillRect(context, markerRect);
  
  UIImage *markerImage = UIGraphicsGetImageFromCurrentImageContext();
  CGContextRestoreGState(context);
  UIGraphicsEndImageContext();
  
  return markerImage;
}

@end
