//
//  PLTScatterChartStyle.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 13.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//
#import "PLTScatterChartStyle.h"

@interface PLTScatterChartStyle ()
@property(nonatomic) BOOL hasMarkers;

+ (instancetype)new;
@end

@implementation PLTScatterChartStyle
@synthesize chartColor;
@synthesize markerType;
@synthesize markerSize;
@synthesize hasMarkers;

#pragma mark - Initialization

- (nonnull instancetype)init {
  self = [super init];
  if (self) {
    self.chartColor = [UIColor blueColor];
    self.markerType = PLTMarkerCircle;
    self.markerSize = 6.0;
    self.hasMarkers = YES;
  }
  return self;
}

#pragma mark - Decription

- (NSString *)description{
  return [NSString stringWithFormat:@"<%@: %p \n\
          Marker type = %@ \n\
          Chart line color = %@>",
          self.class,
          (void *)self,
          pltStringFromMarkerType(self.markerType),
          self.chartColor
          ];
}

#pragma mark - Styles

+ (nonnull instancetype)blank {
  return [PLTScatterChartStyle new];
}

+ (nonnull instancetype)new {
  return [[PLTScatterChartStyle alloc] init];
}

@end
