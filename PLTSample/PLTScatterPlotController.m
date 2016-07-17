//
//  PLTScatterPlotController.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 17.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTScatterPlotController.h"
#import "PLTScatterView.h"
#import "PLTScatterStyleContainer.h"
#import "PLTExampleConfiguration.h"

@interface PLTScatterPlotController ()<PLTScatterChartDataSource>
@property (nonatomic, strong) PLTScatterView *scatterPlotView;
@end

@implementation PLTScatterPlotController

@synthesize scatterPlotView;

- (void)viewDidLoad {
  [super viewDidLoad];
  self.scatterPlotView = [[PLTScatterView alloc] initWithFrame: self.view.bounds];
  self.scatterPlotView.dataSource = self;
  self.scatterPlotView.styleContainer = [PLTScatterStyleContainer blank];
  if ([self.designPresetName compare:kPLTDesignPatternBlank] == NSOrderedSame) {
    self.scatterPlotView.styleContainer = [PLTScatterStyleContainer blank];
  }
  else if ([self.designPresetName compare:kPLTDesignPatternMath] == NSOrderedSame) {
    self.scatterPlotView.styleContainer = [PLTScatterStyleContainer math];
  }
  else if ([self.designPresetName compare:kPLTDesignPatternCobalt] == NSOrderedSame) {
    self.scatterPlotView.styleContainer = [PLTScatterStyleContainer cobaltStocks];
  }
  else if ([self.designPresetName compare:kPLTDesignPatternGray] == NSOrderedSame) {
    self.scatterPlotView.styleContainer = [PLTScatterStyleContainer blackAndGray];
  }
  self.scatterPlotView.chartName = @"Budget";
  [self.view addSubview:self.scatterPlotView];
}

- (PLTChartData *)dataForScatterChart {
  return [self dataForChart];
}

@end
