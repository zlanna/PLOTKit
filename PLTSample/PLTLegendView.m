//
//  PLTLegendView.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLegendView.h"

@interface PLTLegendView ()

@property(nonatomic, copy, nullable) NSDictionary<NSString *, NSArray*> *legendData;

@end


@implementation PLTLegendView

@synthesize dataSource;
@synthesize legendData;

- (nonnull instancetype)init {
  self = [super initWithFrame:CGRectZero];
  if (self) {
    
  }
  return self;
}

- (void)setNeedsDisplay {
  NSLog(@"%@", NSStringFromCGRect(self.frame));
  self.legendData = [self.dataSource chartViewsLegend];
  if (self.legendData && self.legendData.count>0) {
    
  }
  else {
    self.frame = CGRectZero;
  }
}

@end
