//
//  PLTBaseConfig.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 14.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTBaseConfig.h"

@implementation PLTBaseConfig

//  Grid config
@synthesize horizontalGridlineEnable = _horizontalGridlineEnable;
@synthesize verticalGridlineEnable = _verticalGridlineEnable;
@synthesize gridLineStyle = _gridLineStyle;
@synthesize gridLineWeight = _gridLineWeight;
//  Axis X config
@synthesize xHidden = _xHidden;
@synthesize xHasArrow = _xHasArrow;
@synthesize xHasName = _xHasName;
@synthesize xHasMarks = _xHasMarks;
@synthesize xIsAutoformat = _xIsAutoformat;
@synthesize xIsStickToZero = _xIsStickToZero;
@synthesize xMarksType = _xMarksType;
@synthesize xAxisLineWeight = _xAxisLineWeight;
@synthesize xLabelPosition = _xLabelPosition;
@synthesize xHasLabels = _xHasLabels;
//  Axis Y config
@synthesize yHidden = _yHidden;
@synthesize yHasArrow = _yHasArrow;
@synthesize yHasName = _yHasName;
@synthesize yHasMarks = _yHasMarks;
@synthesize yIsAutoformat = _yIsAutoformat;
@synthesize yIsStickToZero = _yIsStickToZero;
@synthesize yMarksType = _yMarksType;
@synthesize yAxisLineWeight = _yAxisLineWeight;
@synthesize yLabelPosition = _yLabelPosition;
@synthesize yHasLabels = _yHasLabels;

#pragma mark - Initialization

- (null_unspecified instancetype)init {
  self = [super init];
  if (self) {
    _horizontalGridlineEnable = YES;
    _verticalGridlineEnable = YES;
    _gridLineStyle = PLTLineStyleDash;
    _gridLineWeight = 1.0;
    
    _xHidden = NO;
    _xHasArrow = NO;
    _xHasMarks = YES;
    _xHasName = NO;
    _xIsAutoformat = YES;
    _xIsStickToZero = YES;
    _xMarksType = PLTMarksTypeOutside;
    _xAxisLineWeight = 1.0;
    _xHasLabels = YES;
    _xLabelPosition = PLTAxisXLabelPositionBottom;
    
    _yHidden = _xHidden;
    _yHasArrow = _xHasArrow;
    _yHasMarks = _xHasMarks;
    _yHasName = _xHasName;
    _yIsAutoformat = _xIsAutoformat;
    _yIsStickToZero = _xIsStickToZero;
    _yMarksType = _xMarksType;
    _yAxisLineWeight = _xAxisLineWeight;
    _yHasLabels = _xHasLabels;
    _yLabelPosition = PLTAxisYLabelPositionLeft;
  }
  return self;
}

#pragma mark - Configurations

+ (nonnull instancetype)blank {
  return [PLTBaseConfig new];
}

+ (nonnull instancetype)math {
  PLTBaseConfig *config = [PLTBaseConfig new];
  config.horizontalGridlineEnable = YES;
  config.verticalGridlineEnable = YES;
  config.gridLineStyle = PLTLineStyleSolid;
  config.gridLineWeight = 1.0;
  
  config.xHidden = NO;
  config.xHasArrow = YES;
  config.xHasMarks = YES;
  config.xHasName = NO;
  config.xIsAutoformat = YES;
  config.xIsStickToZero = YES;
  config.xMarksType = PLTMarksTypeOutside;
  config.xAxisLineWeight = 1.0;
  
  config.yHidden = config.xHidden;
  config.yHasArrow = config.xHasArrow;
  config.yHasMarks = config.xHasMarks;
  config.yHasName = config.xHasName;
  config.yIsAutoformat = config.xIsAutoformat;
  config.yIsStickToZero = config.xIsStickToZero;
  config.yMarksType = config.xMarksType;
  config.yAxisLineWeight = config.xAxisLineWeight;
  
  return config;
}

+ (nonnull instancetype)stocks {
  PLTBaseConfig *config = [PLTBaseConfig new];
  config.horizontalGridlineEnable = YES;
  config.verticalGridlineEnable = YES;
  config.gridLineStyle = PLTLineStyleDot;
  config.gridLineWeight = 1.0;
  
  config.xHidden = NO;
  config.xHasArrow = NO;
  config.xHasMarks = NO;
  config.xHasName = NO;
  config.xIsAutoformat = YES;
  config.xIsStickToZero = NO;
  config.xAxisLineWeight = 1.0;
  
  config.yHidden = config.xHidden;
  config.yHasArrow = config.xHasArrow;
  config.yHasMarks = config.xHasMarks;
  config.yHasName = config.xHasName;
  config.yIsAutoformat = config.xIsAutoformat;
  config.yIsStickToZero = config.xIsStickToZero;
  config.yAxisLineWeight = config.xAxisLineWeight;
  
  return config;
}

+ (nonnull instancetype)blackAndGray{
  PLTBaseConfig *config = [PLTBaseConfig new];
  config.horizontalGridlineEnable = YES;
  config.verticalGridlineEnable = NO;
  config.gridLineStyle = PLTLineStyleSolid;
  config.gridLineWeight = 1.0;
  
  config.xHidden = NO;
  config.xHasArrow = NO;
  config.xHasMarks = YES;
  config.xHasName = NO;
  config.xIsAutoformat = YES;
  config.xIsStickToZero = NO;
  config.xAxisLineWeight = 1.0;
  
  config.yHidden = config.xHidden;
  config.yHasArrow = config.xHasArrow;
  config.yHasMarks = config.xHasMarks;
  config.yHasName = config.xHasName;
  config.yIsAutoformat = config.xIsAutoformat;
  config.yIsStickToZero = config.xIsStickToZero;
  config.yAxisLineWeight = config.xAxisLineWeight;
  
  return config;
}

@end
