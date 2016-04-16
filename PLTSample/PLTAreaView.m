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

@interface PLTAreaView ()

//FIX: Had to make style as nullable
@property(nonatomic, strong, nullable) PLTAreaStyle *style;

@end

@implementation PLTAreaView

@synthesize delegate;
@synthesize style = _style;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame: frame];
  if (self) {
    _style = [PLTAreaStyle blank];
  }
  return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  self.style = [self.delegate areaStyle];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
  NSLog(@"Draw areaView!");
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [self.style.areaColor CGColor]);
  CGContextFillRect(context, rect);
}

@end
