//
//  PLTAxis.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 04.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAxisView.h"
#import "PLTAxisXView.h"
#import "PLTAxisYView.h"

@implementation PLTAxisView

@synthesize styleSource;
@synthesize dataSource;
@synthesize axisName;
@synthesize style = _style;
@synthesize marksCount = _marksCount;
@synthesize axisNameLabel;
@synthesize labels = _labels;
@synthesize markerPoints;

# pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _marksCount = 0;
    // TODO: 10 вообще-то должно быть связано с количеством меток по умолчанию
    _labels = [[LabelsCollection alloc] initWithCapacity:10];
    
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

# pragma mark - Hit testing

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
  return NO;
}

#pragma clang diagnostic pop

@end
