//
//  PLTLinearPlotController.m
//  PLOTKit Demo
//
//  Created by ALEXEY ULENKOV on 17.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLinearPlotController.h"
#import "PLTExampleConfiguration.h"

@interface PLTLinearPlotController ()<PLTLinearChartDataSource>
@property (nonatomic, strong) PLTLinearView *linearPlotView;
@end

@implementation PLTLinearPlotController

@synthesize linearPlotView;

- (void)viewDidLoad {
  [super viewDidLoad];
  self.linearPlotView = [[PLTLinearView alloc] initWithFrame: self.view.bounds];
  self.linearPlotView.dataSource = self;
  if ([self.designPresetName compare:kPLTDesignPatternBlank] == NSOrderedSame) {
    self.linearPlotView.styleContainer = [PLTLinearStyleContainer blank];
  }
  else if ([self.designPresetName compare:kPLTDesignPatternMath] == NSOrderedSame) {
    self.linearPlotView.styleContainer = [PLTLinearStyleContainer math];
  }
  else if ([self.designPresetName compare:kPLTDesignPatternCobalt] == NSOrderedSame) {
    self.linearPlotView.styleContainer = [PLTLinearStyleContainer cobaltStocks];
  }
  else if ([self.designPresetName compare:kPLTDesignPatternGray] == NSOrderedSame) {
    self.linearPlotView.styleContainer = [PLTLinearStyleContainer blackAndGray];
  }
  self.linearPlotView.chartName = @"Budget";
  [self.linearPlotView setupSubviews];
  [self.view addSubview:self.linearPlotView];
}

- (PLTChartData *)dataForLinearChart {
  return [self dataForChart];
}
  
@end

