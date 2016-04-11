//
//  PLTArea.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAreaView.h"
#import "UIView+PLTNestedView.h"
#import "PLTAreaStyle.h"

static const CGFloat areaViewScale = 0.15;

@implementation PLTAreaView

@synthesize style = _style;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame: [UIView plt_nestedViewFrame:frame nestedScaled:areaViewScale]];
  if (self) {
    _style = [PLTAreaStyle blank];
  }
  return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [self.style.areaColor CGColor]);
  CGContextFillRect(context, rect);
}

@end
