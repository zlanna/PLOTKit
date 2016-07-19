//
//  PLTAxisStyle.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 04.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAxisStyle.h"

NSString *_Nonnull pltStringFromAxisMarkType(PLTMarksType markType) {
  switch (markType) {
    case PLTMarksTypeCenter:
      return @"PLTMarksTypeCenter";
    case PLTMarksTypeInside: {
      return @"PLTMarksTypeInside";
    }
    case PLTMarksTypeOutside: {
      return @"PLTMarksTypeOutside";
    }
  }
}

@implementation PLTAxisStyle

@synthesize hidden = _hidden;
@synthesize hasArrow = _hasArrow;
@synthesize hasName = _hasName;
@synthesize hasMarks = _hasMarks;
@synthesize isAutoformat = _isAutoformat;
@synthesize isStickToZero = _isStickToZero;
@synthesize marksType = _marksType;
@synthesize axisColor = _axisColor;
@synthesize axisLineWeight = _axisLineWeight;
@synthesize hasLabels = _hasLabels;
@synthesize labelFontColor = _labelFontColor;

#pragma mark - Initialization

- (null_unspecified instancetype)init {
  self = [super init];
  if (self) {
    _hidden = NO;
    _hasArrow = NO;
    _hasName = NO;
    _hasMarks = YES;
    _isAutoformat = YES;
    _isStickToZero = YES;
    _marksType = PLTMarksTypeOutside;
    _axisColor = [UIColor blackColor];
    _axisLineWeight = 1.0;
    _hasLabels = YES;
    _labelFontColor = [UIColor blackColor];
  }
  return self;
}

#pragma mark - Decription

- (NSString *)description{
  return [NSString stringWithFormat:@"<%@: %p \n\
          Hidden = %@ \n\
          Has arrow = %@ \n\
          Has name = %@ \n\
          Has marks = %@ \n\
          Autoformat = %@ \n\
          Marks type = %@ \n\
          Axis color = %@ \n\
          Axis line weight = %@ \n\
          Has labels = %@ \n\
          Label font color = %@ >",
          self.class,
          (void *)self,
          self.hidden?@"YES":@"NO",
          self.hasArrow?@"YES":@"NO",
          self.hasName?@"YES":@"NO",
          self.hasMarks?@"YES":@"NO",
          self.isAutoformat?@"YES":@"NO",
          pltStringFromAxisMarkType(self.marksType),
          self.axisColor,
          @(self.axisLineWeight),
          self.hasLabels?@"YES":@"NO",
          self.labelFontColor
          ];
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

@end
