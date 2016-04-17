//
//  PLTPin.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTPinView.h"

@implementation PLTPinView

@synthesize dataSource;
@synthesize pinColor = _pinColor;

- (nonnull instancetype)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if (self) {
    _pinColor = [UIColor blueColor];
  }
  return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  CGContextRestoreGState(context);
}

#pragma clang diagnostic pop

@end
