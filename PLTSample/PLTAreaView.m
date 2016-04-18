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
@property(nonatomic, strong, nonnull) PLTAreaStyle *style;

@end

@implementation PLTAreaView

@synthesize styleSource;
@synthesize style = _style;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame: frame];
  if (self) {
    _style = [PLTAreaStyle blank];
  }
  return self;
}

#pragma mark - View lifecycle

- (void)setNeedsDisplay {
  [super setNeedsDisplay];
  PLTAreaStyle *newStyle = [[self.styleSource styleContainer] areaStyle];
  if (newStyle) {
    self.style = newStyle;
  }
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [self.style.areaColor CGColor]);
  CGContextFillRect(context, rect);
}

@end
