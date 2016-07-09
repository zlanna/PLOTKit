//
//  PLTGridStyle.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 03.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTGridStyle.h"

NSString *_Nonnull pltStringFromLineStyle(PLTLineStyle style) {
  switch (style) {
    case PLTLineStyleDot: {
      return @"PLTLineStyleDot";
    }
    case PLTLineStyleSolid: {
      return @"PLTLineStyleSolid";
    }
    case PLTLineStyleDash: {
      return @"PLTLineStyleDash";
    }
    case PLTLineStyleNone: {
      return @"PLTLineStyleNone";
    }
  }
}

@implementation PLTGridStyle

@synthesize horizontalGridlineEnable = _horizontalGridlineEnable;
@synthesize horizontalLineColor = _horizontalLineColor;

@synthesize verticalGridlineEnable = _verticalGridlineEnable;
@synthesize verticalLineColor = _verticalLineColor;

@synthesize backgroundColor = _backgroundColor;

@synthesize lineStyle = _lineStyle;
@synthesize lineWeight = _lineWeight;

#pragma mark - Initialization

- (null_unspecified instancetype)init {
  self = [super init];
  if (self) {
    _horizontalGridlineEnable = YES;
    _verticalGridlineEnable = YES;
    _backgroundColor = [UIColor whiteColor];
    
    _lineStyle = PLTLineStyleDash;
    _lineWeight = 1.0;
  }
  return self;
}

#pragma mark - Decription

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@: %p \n\
          Horizontal lines enable = %@ \n\
          Horizontal lines color = %@ \n\
          Vertical lines enable = %@ \n\
          Vertival lines color = %@ \n\
          Background color = %@ \n\
          Line style = %@ \n\
          Line weight = %@ >",
          self.class,
          (void *)self,
          self.horizontalGridlineEnable?@"YES":@"NO",
          self.horizontalLineColor!=nil?self.horizontalLineColor:@"nil",
          self.verticalGridlineEnable?@"YES":@"NO",
          self.verticalLineColor!=nil?self.verticalLineColor:@"nil",
          self.backgroundColor,
          pltStringFromLineStyle(self.lineStyle),
          @(self.lineWeight)
          ];
}

#pragma mark - Styles

+ (nonnull instancetype)blank {
  return [PLTGridStyle new];
}

@end
