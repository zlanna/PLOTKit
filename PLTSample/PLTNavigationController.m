//
//  PLTNavigationController.m
//  PLTSample
 //
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTNavigationController.h"
#import "PLTTableViewController.h"

@interface PLTNavigationController ()
@property(nonatomic, strong) PLTTableViewController *examplesTableViewController;
@end

@implementation PLTNavigationController

@synthesize examplesTableViewController = _examplesTableViewController;

- (instancetype)init {
  self = [super init];
  if (self) {
    self.navigationBar.translucent = NO;
    _examplesTableViewController = [[PLTTableViewController alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [self pushViewController:self.examplesTableViewController animated:NO];
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  NSLog(@"Memory warning recieved.");
}
 
@end
