//
//  PLTGridStyle.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 03.02.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import "PLTGridStyle.h"


@implementation PLTGridStyle

@synthesize horizontalGridlineEnable;
@synthesize horizontalLineColor;

@synthesize verticalGridlineEnable;
@synthesize verticalLineColor;

@synthesize backgroundColor;

@synthesize horizontalLabelPosition;
@synthesize verticalLabelPosition;

@synthesize lineStyle;
@synthesize lineWeight;


#pragma mark - Initialization

//TODO: Переписать этот инициализатор

- (nonnull instancetype)init {
  if(self = [super init]){
    self.horizontalGridlineEnable = NO;
    self.verticalGridlineEnable = NO;
    self.backgroundColor = [UIColor whiteColor];
    
    self.verticalLabelPosition = PLTGridLabelVerticalPositionNone;
    self.horizontalLabelPosition = PLTGridLabelHorizontalPositionNone;
    self.labelFontColor = [UIColor blackColor];
    
    self.lineStyle = PLTLineStyleNone;
    self.lineWeight = 0.0f;
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
