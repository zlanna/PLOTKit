//
//  PLTAxis.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 04.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAxis.h"
#import "PLTAxisX.h"
#import "PLTAxisY.h"


@interface PLTAxis ()

@property(nonatomic, strong) PLTAxisStyle *style;

@end


@implementation PLTAxis

@synthesize delegate;
@synthesize style = _style;

# pragma mark - Initialization

- (null_unspecified instancetype)initWithStyle:(nonnull PLTAxisStyle *)style {
  self = [super initWithFrame:CGRectZero];
  if (self) {
    _style = style;
    self.backgroundColor = [UIColor clearColor];
  }
  
  return self;
}

//???: Можно ли дать гарантию на nonnull исходя из цепочки инициализаторов.
// Опыт говорит, что nil тут никогда не будет, но цепочка выше имеет null_unspecified. Сейчас оставлю так.
+ (nonnull instancetype)axisWithType:(PLTAxisType)type andStyle:(PLTAxisStyle *)style {
  switch (type) {
    case PLTAxisTypeX:
      return [[PLTAxisX alloc] initWithStyle:style];
    
    case PLTAxisTypeY:
      return [[PLTAxisY alloc] initWithStyle:style];
  }
}

# pragma mark - View lifecicle

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  self.frame = [self.delegate axisFrame];
}


# pragma mark - Hit testing

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
  return NO;
}

#pragma clang diagnostic pop

@end
