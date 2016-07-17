//
//  PLTStackedBarView.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 17.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTStackedBarView.h"
#import "PLTChartData.h"
#import "PLTStackedBarChartView.h"
#import "PLTGridView.h"
#import "PLTBarView+Protected.h"
#import "PLTCartesianView+Protected.h"

@implementation PLTStackedBarView

- (void)setupChartViews {
  NSMutableArray<NSLayoutConstraint *> *constraints = [[NSMutableArray<NSLayoutConstraint *> alloc] init];
  NSArray *seriesNames = [[self.dataSource dataForBarChart] seriesNames];
  
  if (seriesNames) {
    for (NSString *seriesName in seriesNames){
      PLTStackedBarChartView *chartView = [[PLTStackedBarChartView alloc] initWithFrame:CGRectZero];
      chartView.seriesName = seriesName;
      chartView.translatesAutoresizingMaskIntoConstraints = NO;
      // FIXME:
      chartView.styleSource = self;
      chartView.dataSource = self;
      chartView.delegate = self;
      
      [self.chartViews setObject:chartView forKey:seriesName];
      [self addSubview:chartView];
      
      [constraints addObject:[NSLayoutConstraint constraintWithItem:chartView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.gridView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:2*chartView.chartExpansion]];
      [constraints addObject:[NSLayoutConstraint constraintWithItem:chartView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.gridView
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:2*chartView.chartExpansion]];
      [constraints addObject:[NSLayoutConstraint constraintWithItem:chartView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.gridView
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
      [constraints addObject:[NSLayoutConstraint constraintWithItem:chartView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.gridView
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
      
      [self addConstraints:constraints];
      
    }
  }
}

@end
