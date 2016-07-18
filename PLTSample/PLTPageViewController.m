//
//  PLTPageViewController.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 17.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTPageViewController.h"

#import "PLTPlotController.h"
#import "PLTBarPlotController.h"
#import "PLTScatterPlotController.h"
#import "PLTLinearPlotController.h"

#import "PLTExampleConfiguration.h"

@interface PLTPageViewController ()<UIPageViewControllerDataSource>

@property (nonatomic, strong) NSMutableArray<__kindof PLTPlotController *>* plotControllers;

@end

@implementation PLTPageViewController

@synthesize plotFamilyName;
@synthesize plotControllers;

- (void)viewDidLoad{
  [super viewDidLoad];
  self.dataSource = self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"
- (void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  NSArray *designNames = [PLTExampleConfiguration designPresetNames];
  self.plotControllers = [[NSMutableArray alloc] initWithCapacity:designNames.count];
  PLTPlotController *plotController;
  
  if ([self.plotFamilyName compare:kPLTLinearPlotName] == NSOrderedSame) {
    plotController = [[PLTLinearPlotController alloc] init];
  }
  else if ([self.plotFamilyName compare:kPLTScatterPlotName] == NSOrderedSame){
    plotController = [[PLTScatterPlotController alloc] init];
  }
  else if([self.plotFamilyName compare:kPLTBarPlotName] == NSOrderedSame) {
    plotController = [[PLTBarPlotController alloc] init];
  }
  
  for (NSString *designName in designNames){
    PLTPlotController *newPlotController = [[[plotController class] alloc] init];
    newPlotController.designPresetName = designName;
    [self.plotControllers addObject:newPlotController];
  }
  
  [self setViewControllers:@[self.plotControllers[0]]
                 direction:UIPageViewControllerNavigationDirectionForward
                  animated:YES
                  completion:nil];
   
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController{
  NSUInteger viewControllerIndex = [self.plotControllers indexOfObject:(PLTPlotController *)viewController];
  NSInteger previousIndex = (NSInteger)viewControllerIndex - 1;
  if (previousIndex < 0) {
    return nil;
  }
  return self.plotControllers[previousIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController{
  NSUInteger viewControllerIndex = [self.plotControllers indexOfObject:(PLTPlotController *)viewController];
  NSInteger nextIndex = viewControllerIndex + 1;
  if (nextIndex > (self.plotControllers.count - 1)) {
    return nil;
  }
  return self.plotControllers[nextIndex];
}
#pragma clang diagnostic pop

@end
