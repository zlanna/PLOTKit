//
//  PLTAxisYStyle.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 08.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAxisYStyle.h"
#import "PLTAxisXStyle.h"

NSString *_Nonnull pltStringFromAxisYLabelPosition(PLTAxisYLabelPosition labelPosition) {
  switch (labelPosition) {
    case PLTAxisYLabelPositionNone:
      return @"PLTAxisYLabelPositionNone";
    case PLTAxisYLabelPositionLeft:
      return @"PLTAxisLabelPositionLeft";
    case PLTAxisYLabelPositionRight:
      return @"PLTAxisLabelPositionRight";
  }
}

@implementation PLTAxisYStyle

@synthesize labelPosition = _labelPosition;
@synthesize hasLabels = _hasLabels;

#pragma mark - Initialization

- (nonnull instancetype)init {
  self = [super init];
  if (self) {
    _hasLabels = YES;
    _labelPosition = PLTAxisYLabelPositionLeft;
  }
  return self;
}

#pragma mark - Description

- (NSString *)description{
  return [NSString stringWithFormat:@"<%@: %p \n\
          Labels type = %@ \n\
          Axis basics = %@ >",
          self.class,
          (void *)self,
          pltStringFromAxisYLabelPosition(self.labelPosition),
          [super description]
          ];
}

#pragma mark - Copy helper

- (PLTAxisXStyle *)copyToX {
  PLTAxisXStyle *newStyle = [PLTAxisXStyle new];
  newStyle.hidden = self.hidden;
  newStyle.hasArrow = self.hasArrow;
  newStyle.hasName = self.hasName;
  newStyle.hasMarks = self.hasMarks;
  newStyle.isAutoformat = self.isAutoformat;
  newStyle.marksType = self.marksType;
  newStyle.axisColor = [self.axisColor copy];
  newStyle.axisLineWeight = self.axisLineWeight;
  newStyle.hasLabels = self.hasLabels;
  newStyle.labelFontColor = self.labelFontColor;
  newStyle.labelPosition = PLTAxisYLabelPositionLeft;
  return newStyle;
}

#pragma mark - Styles

+ (PLTAxisYStyle*)blank {
  return [PLTAxisYStyle new];
}

@end
