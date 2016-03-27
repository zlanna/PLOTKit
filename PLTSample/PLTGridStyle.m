//
//  PLTGridStyle.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 03.02.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
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


#pragma mark - Initialization

//TODO: Переписать этот инициализатор

- (nonnull instancetype)init {
  if(self = [super init]){
    _horizontalGridlineEnable = NO;
    _verticalGridlineEnable = NO;
    _backgroundColor = [UIColor whiteColor];
    
    _verticalLabelPosition = PLTGridLabelVerticalPositionNone;
    _horizontalLabelPosition = PLTGridLabelHorizontalPositionNone;
    _labelFontColor = [UIColor blackColor];
    
    _lineStyle = PLTLineStyleNone;
    _lineWeight = 0.0f;
  }
  return self;
}

#pragma mark - Static

+ (nonnull PLTGridStyle *)blank {
  return [PLTGridStyle new];
}

+ (nonnull PLTGridStyle *)defaultStyle {
  
  PLTGridStyle *style = [PLTGridStyle new];
  style.horizontalGridlineEnable = YES;
  style.horizontalLineColor = [UIColor grayColor];
  
  style.verticalGridlineEnable = YES;
  style.verticalLineColor = [UIColor grayColor];
  
  style.verticalLabelPosition = PLTGridLabelVerticalPositionBottom;
  style.horizontalLabelPosition = PLTGridLabelHorizontalPositionLeft;
  
  style.backgroundColor = [UIColor whiteColor];
  
  style.lineStyle = PLTLineStyleDot;
  style.lineWeight = 1.0f;
  
  return style;
}

@end
