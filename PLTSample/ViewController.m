//
//  ViewController.m
//  PLTSample
 //
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "ViewController.h"
#import "PLTLinearView.h"
#import "PLTLinearStyleContainer.h"
#import "PLTChartData.h"
#import "PLTLinearChartStyle.h"
#import "PLTMarker.h"

@interface ViewController ()<PLTLinearChartDataSource>

@property (nonatomic, strong) PLTLinearView *linearPlotView;

@end

@implementation ViewController

@synthesize linearPlotView;

- (void)viewDidLoad {
  [super viewDidLoad];
  self.linearPlotView = [[PLTLinearView alloc] initWithFrame: self.view.bounds];
  self.linearPlotView.dataSource = self;
  self.linearPlotView.styleContainer = [PLTLinearStyleContainer blank];
 
/*  PLTLinearChartStyle *chartStyle1 = [PLTLinearChartStyle blank];
  chartStyle1.chartLineColor = [UIColor grayColor];
  chartStyle1.hasFilling = YES;
  chartStyle1.hasMarkers = YES;
  chartStyle1.markerType = PLTMarkerTriangle;
  
  [self.linearPlotView.styleContainer injectChartStyle:chartStyle1 forSeries:@"Revenue"];

  PLTLinearChartStyle *chartStyle2 = [PLTLinearChartStyle blank];
  chartStyle2.chartLineColor = [UIColor greenColor];
  chartStyle2.hasFilling = YES;
  chartStyle2.hasMarkers = YES;
  [self.linearPlotView.styleContainer injectChartStyle:chartStyle2 forSeries:@"Deposit"];
*/
  self.linearPlotView.chartName = @"Budget";
  [self.view addSubview:self.linearPlotView];
}

- (PLTChartData *)dataForLinearChart{
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

/*
- (void)setupConstraints {
  NSMutableArray<NSLayoutConstraint *> *constraints = [[NSMutableArray alloc] init];
  NSDictionary<NSString *,__kindof UIView *> *views = @{
                                                        @"linearView": self.linearPlotView,
                                                        @"topLayoutGuide": self.topLayoutGuide
                                                        };
  self.linearPlotView.translatesAutoresizingMaskIntoConstraints = NO;
  [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[linearView]|"
                                                                            options:NSLayoutFormatDirectionLeadingToTrailing
                                                                            metrics:nil
                                                                              views:views]];
  [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[topLayoutGuide]-[linearView]|"
                                                                            options:NSLayoutFormatDirectionLeadingToTrailing
                                                                            metrics:nil
                                                                              views:views]];
  [self.view addConstraints:constraints];
}
*/

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  NSLog(@"Memory warning recieved.");
}
 
@end
