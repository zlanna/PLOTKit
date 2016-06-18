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
  [self.view addSubview:self.linearPlotView];
}

- (PLTChartData *)dataForLinearChart{
  PLTChartData *chartData = [PLTChartData new];
//  [chartData addPointWithXValue:@(-10) andYValue:@(-15)];
  [chartData addPointWithXValue:@"Май" andYValue:@0];
  [chartData addPointWithXValue:@1 andYValue:@1];
  [chartData addPointWithXValue:@2 andYValue:@2];
  [chartData addPointWithXValue:@"2016" andYValue:@15];
  [chartData addPointWithXValue:@4 andYValue:@4];
  [chartData addPointWithXValue:@5 andYValue:@4];
  [chartData addPointWithXValue:@"Пн" andYValue:@4];
  [chartData addPointWithXValue:@"Вт" andYValue:@(-200)];
  [chartData addPointWithXValue:@8 andYValue:@100];
  [chartData addPointWithXValue:@9 andYValue:@1];
  [chartData addPointWithXValue:@10 andYValue:@4];
  [chartData addPointWithXValue:@11 andYValue:@4];
  [chartData addPointWithXValue:@12 andYValue:@3];
  [chartData addPointWithXValue:@13 andYValue:@2];
  [chartData addPointWithXValue:@14 andYValue:@9];
  [chartData addPointWithXValue:@15 andYValue:@2];
  [chartData addPointWithXValue:@16 andYValue:@1];
  return chartData;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
 
@end
