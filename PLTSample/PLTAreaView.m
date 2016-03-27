//
//  PLTArea.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import "PLTAreaView.h"
#import "UIView+PLTNestedView.h"
#import "PLTAreaStyle.h"

@implementation PLTAreaView

@synthesize style = _style;

#pragma mark - Initialization

//TODO: Перегрузить остальные инициализаторы

- (nonnull instancetype)initWithFrame:(CGRect)frame{
  if([super initWithFrame: [UIView plt_nestedViewFrame:frame nestedScaled:0.15f]]){
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

#pragma mark - Frame property overriding

/*
- (void)setFrame:(CGRect)frame{
  [super setFrame:[UIView plt_nestedViewFrame:frame nestedScaled:0.15f]];
}
*/
@end
