//
//  ViewController.m
//  PLTSample
 //
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "ViewController.h"
#import "PLTLinearView.h"

@interface ViewController ()<PLTDelegate, PLTDataSource>

@property (nonatomic, strong) PLTLinearView *linearPlot;

@end

@implementation ViewController

@synthesize linearPlot;

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  //TODO: Переделать PLTView на класс кластер
  self.linearPlot = [[PLTLinearView alloc] initWithFrame: self.view.bounds];
  self.linearPlot.delegate = self;
  self.linearPlot.dataSource = self;
  [self.view addSubview:self.linearPlot];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
 
@end
