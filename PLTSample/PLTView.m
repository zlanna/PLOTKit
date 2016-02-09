//
//  PLTView.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import "PLTView.h"
#import "PLTAreaView.h"

@interface PLTView ()

@property(nonatomic, strong) PLTAreaView *plotArea;

@end


@implementation PLTView

@synthesize plotArea = _plotArea;

//TODO: Сделать правильные инициализаторы
- (nonnull instancetype)initWithPlotType:(PLTType) plotType {
  if(self = [super init]) {
    CGRect defaultFrame = CGRectMake(20.0f, 20.0f, 200.0f, 200.0f);
    self.frame = defaultFrame;
    _plotType = plotType;
    _plotArea = [[PLTAreaView alloc] initWithFrame:defaultFrame];
  }
  return self;
}

- (nonnull instancetype)initWithFrame:(CGRect)frame {
  if(self = [super initWithFrame:frame]) {
    self.frame = frame;
    _plotType = PLTTypeLinear;
    _plotArea = [[PLTAreaView alloc] initWithFrame:frame];
  }
  return self;
}

- (void)drawRect:(CGRect)rect{
  [self addSubview:self.plotArea];
}

@end
