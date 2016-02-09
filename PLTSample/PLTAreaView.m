//
//  PLTArea.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import "PLTAreaView.h"
#import "UIView+PLTNestedView.h"

@implementation PLTAreaView


#pragma mark - Initialization

//TODO: Перегрузить остальные инициализаторы

- (nonnull instancetype)initWithFrame:(CGRect)frame{
  return [super initWithFrame: [UIView plt_nestedViewFrame:frame nestedScaled:0.15f]];
}

#pragma mark - Private

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
  CGContextFillRect(context, rect);
}

@end
