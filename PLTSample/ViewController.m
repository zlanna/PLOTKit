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
/* 
  PLTLinearChartStyle *chartStyle1 = [PLTLinearChartStyle blank];
  chartStyle1.chartLineColor = [UIColor yellowColor];
  chartStyle1.hasFilling = YES;
  chartStyle1.hasMarkers = YES;
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
  
  [chartData addPointWithArgument:@"Jan" andValue:@2000 forSeries:@"Revenue"];
  [chartData addPointWithArgument:@"Feb" andValue:@2000 forSeries:@"Revenue"];
  [chartData addPointWithArgument:@"March" andValue:@2000 forSeries:@"Revenue"];
  [chartData addPointWithArgument:@"Apr" andValue:@2100 forSeries:@"Revenue"];
  [chartData addPointWithArgument:@"May" andValue:@2500 forSeries:@"Revenue"];
  [chartData addPointWithArgument:@"June" andValue:@2000 forSeries:@"Revenue"];
  [chartData addPointWithArgument:@"July" andValue:@3000 forSeries:@"Revenue"];
  [chartData addPointWithArgument:@"Aug" andValue:@5000 forSeries:@"Revenue"];
  
  [chartData addPointWithArgument:@"Jan" andValue:@1000 forSeries:@"Expence"];
  [chartData addPointWithArgument:@"Feb" andValue:@1000 forSeries:@"Expence"];
  [chartData addPointWithArgument:@"March" andValue:@1000 forSeries:@"Expence"];
  [chartData addPointWithArgument:@"Apr" andValue:@1100 forSeries:@"Expence"];
  [chartData addPointWithArgument:@"May" andValue:@1500 forSeries:@"Expence"];
  [chartData addPointWithArgument:@"June" andValue:@1000 forSeries:@"Expence"];
  [chartData addPointWithArgument:@"July" andValue:@1000 forSeries:@"Expence"];
  [chartData addPointWithArgument:@"Aug" andValue:@1000 forSeries:@"Expence"];
  
  [chartData addPointWithArgument:@"Jan" andValue:@(-1000) forSeries:@"Deposit"];
  [chartData addPointWithArgument:@"Feb" andValue:@(-1000) forSeries:@"Deposit"];
  [chartData addPointWithArgument:@"March" andValue:@(-1000) forSeries:@"Deposit"];
  [chartData addPointWithArgument:@"Apr" andValue:@(-1100) forSeries:@"Deposit"];
  [chartData addPointWithArgument:@"May" andValue:@(-1500) forSeries:@"Deposit"];
  [chartData addPointWithArgument:@"June" andValue:@(-1000) forSeries:@"Deposit"];
  [chartData addPointWithArgument:@"July" andValue:@(-1000) forSeries:@"Deposit"];
  [chartData addPointWithArgument:@"Aug" andValue:@(-1000) forSeries:@"Deposit"];
  
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
