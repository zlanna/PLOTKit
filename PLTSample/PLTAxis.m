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

@implementation PLTAxis

@synthesize delegate;
@synthesize style = _style;

# pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
  }
  
  return self;
}

//???: Можно ли дать гарантию на nonnull исходя из цепочки инициализаторов.
// Опыт говорит, что nil тут никогда не будет, но цепочка выше имеет null_unspecified. Сейчас оставлю так.
+ (nonnull instancetype)axisWithType:(PLTAxisType)type andFrame:(CGRect)frame {
  switch (type) {
    case PLTAxisTypeX:
      return [[PLTAxisX alloc] initWithFrame:frame];
    
    case PLTAxisTypeY:
      return [[PLTAxisY alloc] initWithFrame:frame];
  }
}

# pragma mark - Hit testing

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
  return NO;
}

#pragma clang diagnostic pop

@end
