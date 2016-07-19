//
//  PLTStackedBarView.m
//  PLOTKit
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
  NSArray *seriesNames = [[self.dataSource dataForBarChart] seriesNames];
  
  if (seriesNames) {
    for (NSString *seriesName in seriesNames){
      PLTStackedBarChartView *chartView = [[PLTStackedBarChartView alloc] init];
      chartView.seriesName = seriesName;
      chartView.styleSource = self;
      chartView.dataSource = self;
      chartView.delegate = self;
      
      [self.chartViews setObject:chartView forKey:seriesName];
      [self addSubview:chartView];
      [self addConstraints: [self creatingChartConstraints:chartView withExpansion:chartView.chartExpansion]];
    }
  }
}

@end
