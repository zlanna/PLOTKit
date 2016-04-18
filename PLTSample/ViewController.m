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

@interface ViewController ()<PLTDelegate, PLTDataSource>

@property (nonatomic, strong) PLTLinearView *linearPlotView;

@end

@implementation ViewController

@synthesize linearPlotView;

- (void)viewDidLoad {
  [super viewDidLoad];
  self.linearPlotView = [[PLTLinearView alloc] initWithFrame: self.view.bounds];
  self.linearPlotView.delegate = self;
  self.linearPlotView.dataSource = self;
  self.linearPlotView.styleContainer = [PLTLinearStyleContainer blank];
  [self.view addSubview:self.linearPlotView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
 
@end
