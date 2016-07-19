//
//  PLTBarView.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 15.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTBarView.h"
#import "PLTBarChartView.h"
#import "PLTGridView.h"
#import "PLTAxisView.h"
#import "PLTLegendView.h"
#import "PLTBarLegendView.h"
#import "PLTChartData.h"
#import "PLTCartesianView+Protected.h"
#import "PLTAxisDataFormatter.h"

@interface PLTBarView ()<PLTBarStyleSource ,PLTInternalBarChartDataSource, PLTLegendViewDataSource, PLTViewConstriction>
@end

@implementation PLTBarView

@synthesize dataSource;
@synthesize styleContainer;

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.legendView = [[PLTBarLegendView alloc] init];
    self.gridView.dataSource = self;
    self.xAxisView.dataSource = self;
    self.yAxisView.dataSource = self;
    self.legendView.dataSource = self;
  }
  return self;
}

- (void)getDataFromSource {
  self.chartData = [[self.dataSource dataForBarChart] internalData];
}

- (void)setupChartViews {
  NSMutableArray<NSLayoutConstraint *> *constraints = [[NSMutableArray<NSLayoutConstraint *> alloc] init];
  NSArray *seriesNames = [[self.dataSource dataForBarChart] seriesNames];
  
  if (seriesNames) {
    for (NSString *seriesName in seriesNames){
      PLTBarChartView *chartView = [[PLTBarChartView alloc] initWithFrame:CGRectZero];
      chartView.seriesName = seriesName;
      chartView.translatesAutoresizingMaskIntoConstraints = NO;
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

#pragma mark - PLTLegendViewDataSource

- (void)selectChart:(nullable NSString *)chartName {
  if(chartName) {
    PLTBarChartView *chartView = self.chartViews[(NSString *_Nonnull)chartName];
    [self bringSubviewToFront:chartView];
  }
}

// FIXME: Fix protocol implementation
- (nullable NSDictionary<NSString *, PLTLinearChartStyle *> *)chartViewsLegend {
  if (self.chartViews && self.chartViews.count>0) {
    NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc] initWithCapacity:self.chartViews.count];
    for (NSString *chartName in self.chartViews){
      PLTBarChartStyle *chartStyle = [self.styleContainer chartStyleForSeries:chartName];
      [resultDictionary setObject:chartStyle
                           forKey:chartName];
    }
    return [resultDictionary copy];
  }
  else {
    return nil;
  }
}

#pragma mark - PLTInternalBarChartDataSource

- (nullable NSDictionary<NSString *, NSArray<NSNumber *> *> *)chartDataSetForSeries:(nullable NSString *)seriesName {
  return [[self.dataSource dataForBarChart] dataForSeriesWithName:seriesName];
}

- (nullable NSArray<NSNumber *> *)xDataSet{
  return self.chartData?self.chartData[kPLTXAxis]:nil;
}

- (nullable NSArray<NSNumber *> *)yDataSet {
  if (self.chartData) {
    return [PLTAxisDataFormatter axisDataSetFromChartValues:self.chartData[kPLTYAxis]
                                         withGridLinesCount:5.0];
  }
  else {
    return nil;
  }
}

- (NSUInteger)axisXMarksCount {
  return self.chartData?[[self xDataSet] count] - 1:0;
}

- (NSUInteger)axisYMarksCount {
  return self.chartData?[[self yDataSet] count] - 1:0;
}

- (NSUInteger)seriesIndex:(nonnull NSString*)seriesName{
  return [[self.dataSource dataForBarChart] seriesIndex:seriesName];
}

- (NSUInteger)seriesCount{
  return [[self.dataSource dataForBarChart] count];
}

#pragma mark - View constriction

- (void)addConstriction:(CGFloat)constriction{
  self.gridView.xConstriction = constriction;
  self.xAxisView.constriction = constriction;
}

@end
