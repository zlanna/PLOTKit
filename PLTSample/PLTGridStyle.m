//
//  PLTGridStyle.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 03.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTGridStyle.h"


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
    _lineWeight = 0.0;
  }
  return self;
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
