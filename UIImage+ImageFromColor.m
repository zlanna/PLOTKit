//
//  UIImage+ImageFromColor.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 05.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "UIImage+ImageFromColor.h"

@implementation UIImage (ImageFromColor)

+ (UIImage *) plt_imageFromColor:(UIColor *)color {
  CGRect rect = CGRectMake(0, 0, 1, 1);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [color CGColor]);
  //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
  CGContextFillRect(context, rect);
  UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return img;
}

@end
