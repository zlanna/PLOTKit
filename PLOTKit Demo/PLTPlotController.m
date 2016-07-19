//
//  PLTPlotController.m
//  PLOTKit Demo
//
//  Created by ALEXEY ULENKOV on 17.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//
#import "PLTPlotController.h"
#import "PLTExampleConfiguration.h"

@implementation PLTPlotController

@synthesize designPresetName = _designPresetName;

- (instancetype)init {
  self = [super init];
  if (self) {
    _designPresetName = kPLTDesignPatternBlank;
  }
  return self;
}

- (nonnull PLTChartData *)dataForChart {
  PLTChartData *chartData = [PLTChartData new];
  
  NSString *chartName = @"Revenue";
  [chartData addPointWithArgument:@"Jan" andValue:@2000 forSeries:chartName];
  [chartData addPointWithArgument:@"Feb" andValue:@2000 forSeries:chartName];
  [chartData addPointWithArgument:@"March" andValue:@2000 forSeries:chartName];
  [chartData addPointWithArgument:@"Apr" andValue:@2100 forSeries:chartName];
  [chartData addPointWithArgument:@"May" andValue:@2500 forSeries:chartName];
  [chartData addPointWithArgument:@"June" andValue:@2000 forSeries:chartName];
  [chartData addPointWithArgument:@"July" andValue:@3000 forSeries:chartName];
  [chartData addPointWithArgument:@"Aug" andValue:@5000 forSeries:chartName];
  
  chartName = @"Expence";
  [chartData addPointWithArgument:@"Jan" andValue:@1000 forSeries:chartName];
  [chartData addPointWithArgument:@"Feb" andValue:@1000 forSeries:chartName];
  [chartData addPointWithArgument:@"March" andValue:@1000 forSeries:chartName];
  [chartData addPointWithArgument:@"Apr" andValue:@1100 forSeries:chartName];
  [chartData addPointWithArgument:@"May" andValue:@1800 forSeries:chartName];
  [chartData addPointWithArgument:@"June" andValue:@1000 forSeries:chartName];
  [chartData addPointWithArgument:@"July" andValue:@1000 forSeries:chartName];
  [chartData addPointWithArgument:@"Aug" andValue:@1000 forSeries:chartName];
  
  chartName = @"Deposit";
  [chartData addPointWithArgument:@"Jan" andValue:@(-1000) forSeries:chartName];
  [chartData addPointWithArgument:@"Feb" andValue:@(-1000) forSeries:chartName];
  [chartData addPointWithArgument:@"March" andValue:@(-1000) forSeries:chartName];
  [chartData addPointWithArgument:@"Apr" andValue:@(-1100) forSeries:chartName];
  [chartData addPointWithArgument:@"May" andValue:@(-1500) forSeries:chartName];
  [chartData addPointWithArgument:@"June" andValue:@(-1000) forSeries:chartName];
  [chartData addPointWithArgument:@"July" andValue:@(-1000) forSeries:chartName];
  [chartData addPointWithArgument:@"Aug" andValue:@(-1000) forSeries:chartName];
  
  chartName = @"Debt";
  [chartData addPointWithArgument:@"Jan" andValue:@(-1000) forSeries:chartName];
  [chartData addPointWithArgument:@"Feb" andValue:@(-900) forSeries:chartName];
  [chartData addPointWithArgument:@"March" andValue:@(-800) forSeries:chartName];
  [chartData addPointWithArgument:@"Apr" andValue:@(-700) forSeries:chartName];
  [chartData addPointWithArgument:@"May" andValue:@(-600) forSeries:chartName];
  [chartData addPointWithArgument:@"June" andValue:@(-500) forSeries:chartName];
  [chartData addPointWithArgument:@"July" andValue:@(-400) forSeries:chartName];
  [chartData addPointWithArgument:@"Aug" andValue:@(-300) forSeries:chartName];
  
  return chartData;
}

@end
