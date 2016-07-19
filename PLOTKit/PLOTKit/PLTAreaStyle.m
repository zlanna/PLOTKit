//
//  PLTAreaStyle.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 22.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAreaStyle.h"

@implementation PLTAreaStyle

@synthesize areaColor = _areaColor;
@synthesize chartNameFontColor = _chartNameFontColor;
@synthesize chartNameFont = _chartNameFont;


# pragma mark - Initialization

- (null_unspecified instancetype)init {
  self = [super init];
  if (self) {
    _areaColor = [UIColor whiteColor];
    _chartNameFontColor = [UIColor blackColor];
    _chartNameFont = [UIFont systemFontOfSize:16.0];
  }
  return self;
}

#pragma mark - Decription

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@: %p Area color = %@\n\
          Chart name font color = %@ \n\
          Chart name font = %@>",
          self.class,
          (void *)self,
          self.areaColor,
          self.chartNameFontColor,
          self.chartNameFont
          ];
}

#pragma mark - Styles

+ (nonnull instancetype)blank {
  return [PLTAreaStyle new];
}

@end
