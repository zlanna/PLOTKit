//
//  PLTAxis.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 04.02.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import "PLTAxis.h"
#import "PLTAxisStyle.h"
#import "PLTGridView.h"

@interface PLTAxis ()

@property(nonatomic, strong) PLTAxisStyle *style;

@end


@implementation PLTAxis

@synthesize style;

# pragma mark - Initialization

//TODO: Override basic class designed itializers

- (nonnull instancetype)initWithAxisStyle:(nonnull PLTAxisStyle *)axisStyle {
  
  if (self = [super initWithFrame:CGRectZero]) {
    self.style = axisStyle;
    self.backgroundColor = [UIColor clearColor];
  }
  
  return self;
}

# pragma mark - View lifecicle

- (void)willMoveToSuperview:(UIView *)newSuperview {
  
  [super willMoveToSuperview:newSuperview];

  self.frame = [self.delegate axisFrame];
  
}

# pragma mark - Hit testing

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
  return NO;
}

@end
