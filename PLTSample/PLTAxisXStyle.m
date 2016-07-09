//
//  PLTAxisXStyle.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 08.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAxisXStyle.h"
#import "PLTAxisYStyle.h"

NSString *_Nonnull pltStringFromAxisXLabelPosition(PLTAxisXLabelPosition labelPosition) {
  switch (labelPosition) {
    case PLTAxisXLabelPositionNone:
      return @"PLTAxisLabelPositionNone";
    case PLTAxisXLabelPositionBottom:
      return @"PLTAxisLabelPositionBottom";
    case PLTAxisXLabelPositionTop:
      return @"PLTAxisLabelPositionTop";
  }
}

@implementation PLTAxisXStyle

@synthesize labelPosition = _labelPosition;
@synthesize hasLabels = _hasLabels;

#pragma mark - Initialization

- (nonnull instancetype)init {
  self = [super init];
  if (self) {
    _hasLabels = YES;
    _labelPosition = PLTAxisXLabelPositionBottom;
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
          pltStringFromAxisXLabelPosition(self.labelPosition),
          [super description]
          ];
}

#pragma mark - Copy helper

- (PLTAxisYStyle *)copyToY {
  PLTAxisYStyle *newStyle = [PLTAxisYStyle new];
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

+ (PLTAxisXStyle*)blank {
  return [PLTAxisXStyle new];
}

@end
