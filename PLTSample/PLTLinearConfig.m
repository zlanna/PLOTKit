//
//  PLTLinearConfig.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 27.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLinearConfig.h"

@implementation PLTLinearConfig

//  Grid config
@synthesize horizontalGridlineEnable = _horizontalGridlineEnable;
@synthesize verticalGridlineEnable = _verticalGridlineEnable;
@synthesize gridHasLabels = _gridHasLabels;
@synthesize horizontalGridLabelPosition = _horizontalGridLabelPosition;
@synthesize verticalGridLabelPosition = _verticalGridLabelPosition;
@synthesize gridLineStyle = _gridLineStyle;
@synthesize gridLineWeight = _gridLineWeight;
//  Axis X config
@synthesize xHidden = _xHidden;
@synthesize xHasArrow = _xHasArrow;
@synthesize xHasName = _xHasName;
@synthesize xHasMarks = _xHasMarks;
@synthesize xIsAutoformat = _xIsAutoformat;
@synthesize xMarksType = _xMarksType;
@synthesize xAxisLineWeight = _xAxisLineWeight;
//  Axis Y config
@synthesize yHidden = _yHidden;
@synthesize yHasArrow = _yHasArrow;
@synthesize yHasName = _yHasName;
@synthesize yHasMarks = _yHasMarks;
@synthesize yIsAutoformat = _yIsAutoformat;
@synthesize yMarksType = _yMarksType;
@synthesize yAxisLineWeight = _yAxisLineWeight;
//  Chart config
@synthesize chartHasFilling = _chartHasFilling;
@synthesize chartHasMarkers = _chartHasMarkers;

#pragma mark - Initialization

- (null_unspecified instancetype)init {
  self = [super init];
  if (self) {
    _horizontalGridlineEnable = YES;
    _verticalGridlineEnable = YES;
    _gridHasLabels = YES;
    _horizontalGridLabelPosition = PLTGridLabelHorizontalPositionLeft;
    _verticalGridLabelPosition = PLTGridLabelVerticalPositionBottom;
    _gridLineStyle = PLTLineStyleDash;
    _gridLineWeight = 1.0;
    
    _xHidden = NO;
    _xHasArrow = NO;
    _xHasMarks = YES;
    _xHasName = NO;
    _xIsAutoformat = YES;
    _xMarksType = PLTMarksTypeOutside;
    _xAxisLineWeight = 1.0;
    
    _yHidden = _xHidden;
    _yHasArrow = _xHasArrow;
    _yHasMarks = _xHasMarks;
    _yHasName = _xHasName;
    _yIsAutoformat = _xIsAutoformat;
    _yMarksType = _xMarksType;
    _yAxisLineWeight = _xAxisLineWeight;
    
    _chartHasMarkers = YES;
    _chartHasFilling = YES;
  }
  return self;
}

#pragma mark - Configurations

+ (nonnull instancetype)blank {
  PLTLinearConfig *config = [PLTLinearConfig new];
  return config;
}

+ (nonnull instancetype)math {
  PLTLinearConfig *config = [PLTLinearConfig new];
  config.horizontalGridlineEnable = YES;
  config.verticalGridlineEnable = YES;
  config.gridHasLabels = YES;
  config.horizontalGridLabelPosition = PLTGridLabelHorizontalPositionLeft;
  config.verticalGridLabelPosition = PLTGridLabelVerticalPositionBottom;
  config.gridLineStyle = PLTLineStyleSolid;
  config.gridLineWeight = 1.0;
  
  config.xHidden = NO;
  config.xHasArrow = YES;
  config.xHasMarks = YES;
  config.xHasName = NO;
  config.xIsAutoformat = YES;
  config.xMarksType = PLTMarksTypeOutside;
  config.xAxisLineWeight = 1.0;
  
  config.yHidden = config.xHidden;
  config.yHasArrow = config.xHasArrow;
  config.yHasMarks = config.xHasMarks;
  config.yHasName = config.xHasName;
  config.yIsAutoformat = config.xIsAutoformat;
  config.yMarksType = config.xMarksType;
  config.yAxisLineWeight = config.xAxisLineWeight;
  
  config.chartHasMarkers = NO;
  config.chartHasFilling = NO;
  return config;
}

+ (nonnull instancetype)stocks {
  PLTLinearConfig *config = [PLTLinearConfig new];
  config.horizontalGridlineEnable = YES;
  config.verticalGridlineEnable = YES;
  config.gridHasLabels = YES;
  config.horizontalGridLabelPosition = PLTGridLabelHorizontalPositionLeft;
  config.verticalGridLabelPosition = PLTGridLabelVerticalPositionBottom;
  config.gridLineStyle = PLTLineStyleDot;
  config.gridLineWeight = 1.0;
  
  config.xHidden = NO;
  config.xHasArrow = NO;
  config.xHasMarks = NO;
  config.xHasName = NO;
  config.xIsAutoformat = YES;
  config.xAxisLineWeight = 1.0;
  
  config.yHidden = config.xHidden;
  config.yHasArrow = config.xHasArrow;
  config.yHasMarks = config.xHasMarks;
  config.yHasName = config.xHasName;
  config.yIsAutoformat = config.xIsAutoformat;
  config.yAxisLineWeight = config.xAxisLineWeight;
  
  config.chartHasMarkers = YES;
  config.chartHasFilling = YES;
  return config;
}

@end
