//
//  PLTAreaStyle.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 22.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAreaStyle.h"

@implementation PLTAreaStyle

@synthesize areaColor = _areaColor;

# pragma mark - Initialization

- (nonnull instancetype)init {
  self = [super init];
  if (self) {
    _areaColor = [UIColor whiteColor];
  }
  return self;
}

#pragma mark - Decription

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@: %p Area color = %@>",
          self.class,
          (void *)self,
          self.areaColor
          ];
}

#pragma mark - Styles

+ (nonnull instancetype)blank {
  return [PLTAreaStyle new];
}

@end
