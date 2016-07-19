//
//  PLTLinearChartStyle.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 06.02.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLinearChartStyle.h"

@interface PLTLinearChartStyle ()
+ (instancetype)new;
@end
 
@implementation PLTLinearChartStyle
@synthesize hasFilling;
@synthesize hasMarkers;
@synthesize animation;
@synthesize interpolationStrategy;
@synthesize chartColor;
@synthesize markerType;
@synthesize lineWeight;
@synthesize markerSize;

#pragma mark - Initialization

- (nonnull instancetype)init {
  self = [super init];
  if (self) {
    self.lineWeight = 2.0;
    self.hasFilling = YES;
    self.hasMarkers = YES;
    self.animation = PLTLinearChartAnimationNone;
    self.interpolationStrategy = PLTLinearChartInterpolationLinear;
    self.chartColor = [UIColor blueColor];
    self.markerType = PLTMarkerCircle;
    self.markerSize = (CGFloat)2.5 * self.lineWeight;
  }
  return self;
}

#pragma mark - Decription

- (NSString *)description{
  return [NSString stringWithFormat:@"<%@: %p \n\
          Has filling = %@ \n\
          Has markers = %@ \n\
          Marker type = %@ \n\
          Animation = %@ \n\
          Interpolation = %@ \n\
          Chart line color = %@ \n\
          Line weight = %@>",
          self.class,
          (void *)self,
          self.hasFilling?@"YES":@"NO",
          self.hasMarkers?@"YES":@"NO",
          pltStringFromMarkerType(self.markerType),
          pltStringFromLineatChartAnimation(self.animation),
          pltStringFromLinearChartInterpolation(self.interpolationStrategy),
          self.chartColor,
          @(self.lineWeight)
          ];
}

#pragma mark - Styles

+ (nonnull instancetype)blank {
  return [PLTLinearChartStyle new];
}

+ (nonnull instancetype)new {
  return [[PLTLinearChartStyle alloc] init];
}

@end
