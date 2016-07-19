//
//  PLTTableViewController.m
//  PLOTKit Demo
//
//  Created by ALEXEY ULENKOV on 17.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTTableViewController.h"
#import "PLTTableViewCell.h"

#import "PLTPageViewController.h"
#import "PLTExampleConfiguration.h"

static NSString *const kPLTAppName = @"PLOTKit Demo";
static NSString *const kPLTCell = @"kCell";

@interface PLTTableViewController ()
@property(nonatomic, copy) NSDictionary<NSString *,NSDictionary<NSString*, NSString *> *> *plotExamples;
@end

@implementation PLTTableViewController

@synthesize plotExamples = _plotExamples;

#pragma mark - ViewController lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.tableView registerClass:[PLTTableViewCell class] forCellReuseIdentifier:kPLTCell];
  self.plotExamples = [PLTExampleConfiguration chartsConfig];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:31.0/255.0
                                                                         green:136.0/255.0
                                                                          blue:254.0/255.0
                                                                         alpha:1.0];
  self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
  titleLabel.textColor = [UIColor whiteColor];
  titleLabel.textAlignment = NSTextAlignmentCenter;
  titleLabel.text = kPLTAppName;
  self.navigationItem.titleView = titleLabel;
}

- (void)viewDidDisappear:(BOOL)animated {
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
  PLTPageViewController *pageController =
              [[PLTPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                               navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                             options:nil];
  pageController.plotFamilyName = plotName;
  [self.navigationController pushViewController:pageController animated: YES];
}
#pragma clang diagnostic pop

@end
