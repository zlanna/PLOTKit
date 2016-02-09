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

#pragma mark - Static

+ (nonnull PLTAxisStyle *)defaultStyle {
  PLTAxisStyle *defaultStyle = [PLTAxisStyle new];
  return defaultStyle;
}

@end
