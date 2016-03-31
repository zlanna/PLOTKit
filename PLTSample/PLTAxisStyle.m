//
//  PLTAxisStyle.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 04.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAxisStyle.h"


@implementation PLTAxisStyle

@synthesize hidden = _hidden;
@synthesize hasArrow = _hasArrow;
@synthesize hasName = _hasName;
@synthesize hasMarks = _hasMarks;
@synthesize isAutoformat = _isAutoformat;
@synthesize marksType = _marksType;
@synthesize axisColor = _axisColor;
@synthesize axisLineWeight = _axisLineWeight;

#pragma mark - Initialization

- (null_unspecified instancetype)init {
  self = [super init];
  if (self) {
    _hidden = NO;
    _hasArrow = YES;
    _hasName = NO;
    _hasMarks = YES;
    _isAutoformat = YES;
    _marksType = PLTMarksTypeCenter;
    _axisColor = [UIColor blackColor];
    _axisLineWeight = 1.0;
  }
  return self;
}

#pragma mark - Copy

- (nonnull PLTAxisStyle *)copy {
  PLTAxisStyle *newStyle = [PLTAxisStyle new];
  newStyle.hidden = self.hidden;
  newStyle.hasArrow = self.hasArrow;
  newStyle.hasName = self.hasName;
  newStyle.hasMarks = self.hasMarks;
  newStyle.isAutoformat = self.isAutoformat;
  newStyle.marksType = self.marksType;
  newStyle.axisColor = [self.axisColor copy];
  newStyle.axisLineWeight = self.axisLineWeight;
  return newStyle;
}

#pragma mark - Static

+ (nonnull instancetype)blank {
  return [PLTAxisStyle new];
}

+ (nonnull instancetype)defaultStyle {
  PLTAxisStyle *defaultStyle = [PLTAxisStyle new];
  return defaultStyle;
}

@end
