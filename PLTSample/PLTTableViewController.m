//
//  PLTTableViewController.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 17.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTTableViewController.h"
#import "PLTTableViewCell.h"

#import "PLTPageViewController.h"
#import "PLTExampleConfiguration.h"

static NSString *const kPLTCell = @"kCell";

@interface PLTTableViewController ()
@property(nonatomic, copy) NSDictionary<NSString *,NSDictionary<NSString*, NSString *> *> *plotExamples;
@property(nonatomic, strong) PLTPageViewController *pageController;

@end

@implementation PLTTableViewController

@synthesize plotExamples = _plotExamples;
@synthesize pageController;

#pragma mark - ViewController lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.tableView registerClass:[PLTTableViewCell class] forCellReuseIdentifier:kPLTCell];
  self.plotExamples = [PLTExampleConfiguration chartsConfig];
  self.pageController = [[PLTPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                         navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                       options:nil];

}

- (void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
  titleLabel.textColor = [UIColor whiteColor];
  titleLabel.textAlignment = NSTextAlignmentCenter;
  titleLabel.text = @"PLTKit Demo";
  self.navigationItem.titleView = titleLabel;
}

- (void)viewDidDisappear:(BOOL)animated{
  [super viewDidDisappear:animated];
  self.navigationItem.titleView = nil;
}

#pragma mark - UITableView dataSource & delegete implementation

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.plotExamples count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return [PLTTableViewCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  PLTTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kPLTCell];
  if (cell == nil)
  {
    cell = [[PLTTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kPLTCell];
  }
  NSUInteger itemIndex = [indexPath row];
  NSString *currentKey = [self.plotExamples allKeys][itemIndex];
  cell.nameLabel.text = currentKey;
  cell.descriptionLabel.text = self.plotExamples[currentKey][kPLTDescription];
  return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSUInteger itemIndex = [indexPath row];
  NSString *plotName = [self.plotExamples allKeys][itemIndex];
  self.pageController.plotFamilyName = plotName;
  [self.navigationController pushViewController:self.pageController animated: YES];
}
#pragma clang diagnostic pop

@end
