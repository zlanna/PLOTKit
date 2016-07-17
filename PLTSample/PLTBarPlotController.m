//
//  PLTBarPlotController.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 17.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTBarPlotController.h"
#import "PLTBarView.h"
#import "PLTBarStyleContainer.h"
#import "PLTExampleConfiguration.h"

@interface PLTPlotController ()<PLTBarChartDataSource>
@property (nonatomic, strong) PLTBarView *barPlotView;
@end

@implementation PLTBarPlotController

@synthesize barPlotView;

- (void)viewDidLoad {
  [super viewDidLoad];
  self.barPlotView = [[PLTBarView alloc] initWithFrame: self.view.bounds];
  self.barPlotView.dataSource = self;
  if ([self.designPresetName compare:kPLTDesignPatternBlank] == NSOrderedSame) {
    self.barPlotView.styleContainer = [PLTBarStyleContainer blank];
  }
  else if ([self.designPresetName compare:kPLTDesignPatternMath] == NSOrderedSame) {
    self.barPlotView.styleContainer = [PLTBarStyleContainer math];
  }
  else if ([self.designPresetName compare:kPLTDesignPatternCobalt] == NSOrderedSame) {
    self.barPlotView.styleContainer = [PLTBarStyleContainer cobaltStocks];
  }
  else if ([self.designPresetName compare:kPLTDesignPatternGray] == NSOrderedSame) {
    self.barPlotView.styleContainer = [PLTBarStyleContainer blackAndGray];
  }
  self.barPlotView.chartName = @"Budget";
  [self.view addSubview:self.barPlotView];
}

- (PLTChartData *)dataForBarChart {
  return [self dataForChart];
}

@end
