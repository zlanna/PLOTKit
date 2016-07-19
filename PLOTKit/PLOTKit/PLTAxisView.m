//
//  PLTAxis.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 04.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAxisView.h"
#import "PLTAxisXView.h"
#import "PLTAxisYView.h"

@implementation PLTAxisView

@synthesize style = _style;
@synthesize marksCount = _marksCount;
@synthesize labels = _labels;
@synthesize axisName = _axisName;
@synthesize axisNameLabelFont = _axisNameLabelFont;
@synthesize axisLabelsFont = _axisLabelsFont;
@synthesize constriction = _constriction;

@synthesize styleSource;
@synthesize dataSource;
@synthesize axisNameLabel;
@synthesize markerPoints;

# pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _marksCount = 0;
    // FIXME: 10 label default count 
    _labels = [[LabelsCollection alloc] initWithCapacity:10];
    _axisNameLabelFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    _axisLabelsFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    _constriction = 0;
    
    self.backgroundColor = [UIColor clearColor];
  }
  
  return self;
}

+ (nonnull instancetype)axisWithType:(PLTAxisType)type andFrame:(CGRect)frame {
  switch (type) {
    case PLTAxisTypeX:
      return [[PLTAxisXView alloc] initWithFrame:frame];    
    case PLTAxisTypeY:
      return [[PLTAxisYView alloc] initWithFrame:frame];
  }
}

#pragma mark - Custom properties

- (void)setConstriction:(CGFloat)constriction{
  if(![@(_constriction)  isEqual: @(constriction)]){
    _constriction = constriction;
    [self setNeedsDisplay];
  }
}

#pragma mark - Custom property setters

- (void)setAxisName:(NSString *)axisName {
  _axisName = axisName;
  if (axisName == nil || [axisName compare: @""] == NSOrderedSame) {
    if (self.axisNameLabel){
      [self.axisNameLabel removeFromSuperview];
    }
  }
}

# pragma mark - Hit testing

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
  return NO;
}
#pragma clang diagnostic pop

@end
