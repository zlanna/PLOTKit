//
//  PLTScatterView.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 13.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTScatterView.h"
#import "PLTScatterChartView.h"
#import "PLTGridView.h"
#import "PLTAxisView.h"
#import "PLTLegendView.h"
#import "PLTChartData.h"
#import "PLTCartesianView+Protected.h"
#import "PLTAxisDataFormatter.h"

@interface PLTScatterView ()<PLTScatterStyleSource ,PLTInternalLinearChartDataSource, PLTLegendViewDataSource>
@end

@implementation PLTScatterView

@synthesize dataSource;
@synthesize styleContainer;

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.gridView.dataSource = self;
    self.xAxisView.dataSource = self;
    self.yAxisView.dataSource = self;
    self.legendView.dataSource = self;
  }
  return self;
}

- (void)getDataFromSource {
  self.chartData = [[self.dataSource dataForScatterChart] internalData];
}

- (void)setupChartViews {
  NSArray *seriesNames = [[self.dataSource dataForScatterChart] seriesNames];
  
  if (seriesNames) {
    for (NSString *seriesName in seriesNames){
      PLTScatterChartView *chartView = [[PLTScatterChartView alloc] init];
      chartView.seriesName = seriesName;
      chartView.styleSource = self;
      chartView.dataSource = self;
      
      [self.chartViews setObject:chartView forKey:seriesName];
      [self addSubview:chartView];
      [self addConstraints: [self creatingChartConstraints:chartView withExpansion:chartView.chartExpansion]];
    }
  }
}

#pragma mark - PLTLegendViewDataSource

- (void)selectChart:(nullable NSString *)chartName {
  if(chartName) {
    PLTScatterChartView *chartView = self.chartViews[(NSString *_Nonnull)chartName];
    [self bringSubviewToFront:chartView];
  }
}

// FIXME: Protocol implementation
- (nullable NSDictionary<NSString *, PLTLinearChartStyle *> *)chartViewsLegend {
  if (self.chartViews && self.chartViews.count>0) {
    NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc] initWithCapacity:self.chartViews.count];
    for (NSString *chartName in self.chartViews){
      PLTScatterChartStyle *chartStyle = [self.styleContainer chartStyleForSeries:chartName];
      [resultDictionary setObject:chartStyle
                           forKey:chartName];
    }
    return [resultDictionary copy];
  }
  else {
    return nil;
  }
}

#pragma mark - PLTInternalLinearChartDataSource

- (nullable NSDictionary<NSString *, NSArray<NSNumber *> *> *)chartDataSetForSeries:(nullable NSString *)seriesName {
  return [[self.dataSource dataForScatterChart] dataForSeriesWithName:seriesName];
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

@end
