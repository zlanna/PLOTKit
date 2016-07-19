//
//  PLTLegendStyle.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 19.07.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import "PLTLegendStyle.h"

@implementation PLTLegendStyle

@synthesize legendFont = _legendFont;

@synthesize labelColorForNormalState = _labelColorForNormalState;
@synthesize labelColorForHighlightedState = _labelColorForHighlightedState;
@synthesize labelColorForSelectedState = _labelColorForSelectedState;

@synthesize titleColorForNormalState =  _titleColorForNormalState;
@synthesize titleColorForHighlightedState = _titleColorForHighlightedState;
@synthesize titleColorForSelectedState = _titleColorForSelectedState;

#pragma mark - Initialization

- (null_unspecified instancetype)init {
  self = [super init];
  if (self) {
    _legendFont = [UIFont systemFontOfSize:14.0];
    _labelColorForNormalState = [UIColor whiteColor];
    _labelColorForHighlightedState = [UIColor blueColor];
    _labelColorForSelectedState = [UIColor blueColor];
    
    _titleColorForNormalState = [UIColor blackColor];
    _titleColorForHighlightedState = [UIColor whiteColor];
    _titleColorForSelectedState = [UIColor whiteColor];
  }
  return self;
}

+(nonnull instancetype)blank {
  return [self new];
}

#pragma mark - Decription

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@: %p \n\
          Label color for normal = %@ \n\
          Label color for highlighted = %@ \n\
          Label color for selected = %@ \n\
          Title color for normal = %@ \n\
          Title color for highlighted = %@ \n\
          Title color for selected = %@ \n\
          Title font = %@ >",
          self.class,
          (void *)self,
          self.labelColorForNormalState,
          self.labelColorForHighlightedState,
          self.labelColorForSelectedState,
          self.titleColorForNormalState,
          self.titleColorForHighlightedState,
          self.titleColorForSelectedState,
          self.legendFont
          ];
}

@end
