//
//  PLTScatterView.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 13.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTScatterView.h"
#import "PLTScatterChartView.h"
#import "PLTAreaStyle.h"
#import "PLTGridView.h"
#import "PLTLinearChartView.h"
#import "PLTAxisView.h"
#import "PLTChartData.h"

@implementation PLTScatterView

- (void)setupChartViews {
  NSMutableArray<NSLayoutConstraint *> *constraints = [[NSMutableArray<NSLayoutConstraint *> alloc] init];
  NSArray *seriesNames = [[self.dataSource dataForLinearChart] seriesNames];
  
  if (seriesNames) {
    for (NSString *seriesName in seriesNames){
      PLTScatterChartView *chartView = [[PLTScatterChartView alloc] initWithFrame:CGRectZero];
      chartView.seriesName = seriesName;
      chartView.translatesAutoresizingMaskIntoConstraints = NO;
      chartView.styleSource = self;
      chartView.dataSource = self;
      
      [self.chartViews setObject:chartView forKey:seriesName];
      [self addSubview:chartView];
      
      [constraints addObject:[NSLayoutConstraint constraintWithItem:chartView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.gridView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:2*10.0]];
      [constraints addObject:[NSLayoutConstraint constraintWithItem:chartView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.gridView
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:2*10.0]];
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
