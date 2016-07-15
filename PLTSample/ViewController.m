//
//  ViewController.m
//  PLTSample
 //
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "ViewController.h"

#import "PLTChartData.h"
#import "PLTLinearChartStyle.h"
#import "PLTMarker.h"

#import "PLTLinearView.h"
#import "PLTLinearStyleContainer.h"

#import "PLTScatterView.h"
#import "PLTScatterStyleContainer.h"

#import "PLTBarView.h"
#import "PLTBarStyleContainer.h"

@interface ViewController ()<PLTLinearChartDataSource, PLTScatterChartDataSource, PLTBarChartDataSource>

@property (nonatomic, strong) PLTLinearView *linearPlotView;
@property (nonatomic, strong) PLTScatterView *scatterPlotView;
@property (nonatomic, strong) PLTBarView *barPlotView;

@end

@implementation ViewController

@synthesize linearPlotView;
@synthesize scatterPlotView;
@synthesize barPlotView;

- (void)viewDidLoad {
  [super viewDidLoad];
 /* self.linearPlotView = [[PLTLinearView alloc] initWithFrame: self.view.bounds];
  self.linearPlotView.dataSource = self;
  self.linearPlotView.styleContainer = [PLTLinearStyleContainer blank];
 
  PLTLinearChartStyle *chartStyle1 = [PLTLinearChartStyle blank];
  chartStyle1.chartColor = [UIColor brownColor];
  chartStyle1.hasFilling = YES;
  chartStyle1.hasMarkers = YES;
  chartStyle1.markerType = PLTMarkerTriangle;
  
  [self.linearPlotView.styleContainer injectChartStyle:chartStyle1 forSeries:@"Revenue"];

  PLTLinearChartStyle *chartStyle2 = [PLTLinearChartStyle blank];
  chartStyle2.chartColor = [UIColor yellowColor];
  chartStyle2.hasFilling = YES;
  chartStyle2.hasMarkers = YES;
  chartStyle2.markerType = PLTMarkerSquare;
  [self.linearPlotView.styleContainer injectChartStyle:chartStyle2 forSeries:@"Deposit"];

  self.linearPlotView.chartName = @"Budget";
  [self.view addSubview:self.linearPlotView];
  */
  /*
  self.scatterPlotView = [[PLTScatterView alloc] initWithFrame: self.view.bounds];
  self.scatterPlotView.dataSource = self;
  self.scatterPlotView.styleContainer = [PLTScatterStyleContainer blank];
  
  self.scatterPlotView.chartName = @"Budget";
  [self.view addSubview:self.scatterPlotView];
   */
  self.barPlotView = [[PLTBarView alloc] initWithFrame: self.view.bounds];
  self.barPlotView.dataSource = self;
  self.barPlotView.styleContainer = [PLTBarStyleContainer blank];
  
  self.barPlotView.chartName = @"Budget";
  [self.view addSubview:self.barPlotView];
}

- (PLTChartData *)dataForBarChart {
  return [self dataForLinearChart];
}

- (PLTChartData *)dataForScatterChart {
  return [self dataForLinearChart];
}

- (PLTChartData *)dataForLinearChart {
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

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  NSLog(@"Memory warning recieved.");
}
 
@end
