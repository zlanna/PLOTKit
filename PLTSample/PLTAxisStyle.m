//
//  PLTAxisStyle.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 04.02.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import "PLTAxisStyle.h"


@implementation PLTAxisStyle

@synthesize hidden;
@synthesize hasArrow;
@synthesize hasName;
@synthesize hasMarks;
@synthesize isAutoformat;
@synthesize marksType;
@synthesize axisColor;
@synthesize axisLineWeight;

#pragma mark - Initialization

- (nonnull instancetype)init {
  if (self = [super init]) {
    self.hidden = NO;
    self.hasArrow = YES;
    self.hasName = NO;
    self.hasMarks = YES;
    self.isAutoformat = YES;
    self.marksType = PLTMarksTypeCenter;
    self.axisColor = [UIColor blackColor];
    self.axisLineWeight = 1.0f;
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

+ (nonnull PLTAxisStyle *)blank {
  return [PLTAxisStyle new];
}

+ (nonnull PLTAxisStyle *)defaultStyle {
  PLTAxisStyle *defaultStyle = [PLTAxisStyle new];
  return defaultStyle;
}

@end
