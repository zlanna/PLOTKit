//
//  PLTBarChartStyle.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 25.06.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTBarChartStyle.h"

@implementation PLTBarChartStyle
@synthesize chartColor;

#pragma mark - Initialization

- (nonnull instancetype)init {
  self = [super init];
  if (self) {
    self.chartColor = [UIColor blueColor];
  }
  return self;
}

#pragma mark - Decription

- (NSString *)description{
  return [NSString stringWithFormat:@"<%@: %p \n\
          Chart color = %@>",
          self.class,
          (void *)self,
          self.chartColor
          ];
}

#pragma mark - Styles

+ (nonnull instancetype)blank {
  return [PLTBarChartStyle new];
}

@end
