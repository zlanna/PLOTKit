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

NSString *_Nonnull pltStringFromGridLabelsVerticalPosition(PLTGridLabelVerticalPosition position) {
  switch (position) {
    case PLTGridLabelVerticalPositionNone: {
      return @"PLTGridLabelVerticalPositionNone";
    }
    case PLTGridLabelVerticalPositionTop: {
      return @"PLTGridLabelVerticalPositionTop";
    }
    case PLTGridLabelVerticalPositionBottom: {
      return @"PLTGridLabelVerticalPositionBottom";
    }
  }
}
NSString *_Nonnull pltStringFromGridLabelsHorizontalPosition(PLTGridLabelHorizontalPosition position) {
  switch (position) {
    case PLTGridLabelHorizontalPositionNone: {
      return @"PLTGridLabelHorizontalPositionNone";
    }
    case PLTGridLabelHorizontalPositionLeft: {
      return @"PLTGridLabelHorizontalPositionLeft";
    }
    case PLTGridLabelHorizontalPositionRight: {
      return @"PLTGridLabelHorizontalPositionRight";
    }
  }
}

@implementation PLTGridStyle

@synthesize horizontalGridlineEnable = _horizontalGridlineEnable;
@synthesize horizontalLineColor = _horizontalLineColor;

@synthesize verticalGridlineEnable = _verticalGridlineEnable;
@synthesize verticalLineColor = _verticalLineColor;

@synthesize backgroundColor = _backgroundColor;

@synthesize horizontalLabelPosition = _horizontalLabelPosition;
@synthesize verticalLabelPosition = _verticalLabelPosition;

@synthesize lineStyle = _lineStyle;
@synthesize lineWeight = _lineWeight;

@synthesize labelFontColor = _labelFontColor;
@synthesize hasLabels;


#pragma mark - Initialization

- (null_unspecified instancetype)init {
  self = [super init];
  if (self) {
    _horizontalGridlineEnable = NO;
    _verticalGridlineEnable = NO;
    _backgroundColor = [UIColor whiteColor];
    
    _verticalLabelPosition = PLTGridLabelVerticalPositionNone;
    _horizontalLabelPosition = PLTGridLabelHorizontalPositionNone;
    _labelFontColor = [UIColor blackColor];
    
    _lineStyle = PLTLineStyleNone;
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
          Horizontal labels posotion = %@ \n\
          Vertical labels position = %@ \n\
          Line style = %@ \n\
          Line weight = %@ \n\
          Labels font color = %@ \n\
          Has labels = %@>",
          self.class,
          (void *)self,
          self.horizontalGridlineEnable?@"YES":@"NO",
          self.horizontalLineColor!=nil?self.horizontalLineColor:@"nil",
          self.verticalGridlineEnable?@"YES":@"NO",
          self.verticalLineColor!=nil?self.verticalLineColor:@"nil",
          self.backgroundColor,
          pltStringFromGridLabelsHorizontalPosition(self.horizontalLabelPosition),
          pltStringFromGridLabelsVerticalPosition(self.verticalLabelPosition),
          pltStringFromLineStyle(self.lineStyle),
          @(self.lineWeight),
          self.labelFontColor,
          self.hasLabels?@"YES":@"NO"
          ];
}

#pragma mark - Static

+ (nonnull instancetype)blank {
  return [PLTGridStyle new];
}

+ (nonnull instancetype)defaultStyle {
  PLTGridStyle *style = [PLTGridStyle new];
  style.horizontalGridlineEnable = YES;
  style.horizontalLineColor = [UIColor grayColor];
  
  style.verticalGridlineEnable = YES;
  style.verticalLineColor = [UIColor grayColor];
  
  style.verticalLabelPosition = PLTGridLabelVerticalPositionBottom;
  style.horizontalLabelPosition = PLTGridLabelHorizontalPositionLeft;
  
  style.backgroundColor = [UIColor whiteColor];
  
  style.lineStyle = PLTLineStyleDot;
  style.lineWeight = 1.0;
  
  return style;
}

@end
