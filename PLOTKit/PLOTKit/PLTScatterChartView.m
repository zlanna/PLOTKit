//
//  PLTScatterChartView.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 13.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTScatterChartView.h"
#import "PLTBaseLinearChartView+Protected.h"

@implementation PLTScatterChartView

@synthesize styleSource;

- (void)drawRect:(CGRect)rect{
  if (self.chartData) {
    self.chartPoints = [self prepareChartPoints:rect];
    [self drawMarkers];
    [self drawPin];
  }
}

@end

