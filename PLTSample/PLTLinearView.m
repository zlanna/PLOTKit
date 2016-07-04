//
//  PLTLinearView.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLinearView.h"
#import "PLTLinearView+Constraints.h"
#import "PLTAreaStyle.h"
#import "PLTGridView.h"
#import "PLTLinearChartView.h"
#import "PLTAxisView.h"
#import "PLTChartData.h"
#import "PLTAxisDataFormatter.h"

const CGRect kPLTDefaultFrame = {{0.0, 0.0}, {200.0, 200.0}};

typedef NSDictionary<NSString *,NSArray<NSNumber *> *> ChartData;

@interface PLTLinearView ()<PLTStyleSource, PLTInternalLinearChartDataSource>

@property(nonatomic, strong) UILabel *chartNameLabel;
@property(nonatomic, strong) PLTGridView *gridView;
@property(nonatomic, strong) PLTAxisView *xAxisView;
@property(nonatomic, strong) PLTAxisView *yAxisView;
@property(nonatomic, strong) PLTLinearChartView *chartView;
@property(nonatomic, strong) PLTLinearChartView *chartView2;
@property(nonatomic, strong, nullable) ChartData *chartData;

@end

@implementation PLTLinearView

@synthesize dataSource;

@synthesize chartName = _chartName;
@synthesize axisXName = _axisXName;
@synthesize axisYName = _axisYName;
@synthesize chartData = _chartData;

@synthesize styleContainer;
@synthesize chartNameLabel;
@synthesize gridView;
@synthesize xAxisView;
@synthesize yAxisView;
@synthesize chartView;
@synthesize chartView2;


#pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth
    |UIViewAutoresizingFlexibleHeight;
    self.contentMode = UIViewContentModeRedraw;
    
    _chartData = nil;
    _chartName = @"";
    _axisXName = @"x";
    _axisYName = @"y";
  }
  return self;
}

- (null_unspecified instancetype)init {
  return [self initWithFrame:kPLTDefaultFrame];
}

#pragma mark - Layout subviews

- (void)layoutSubviews {
  [super layoutSubviews];
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self setupSubviews];
  });
  [self setNeedsDisplay];
}

- (void)setNeedsDisplay{
  [super setNeedsDisplay];
  // FIXME: Скрытая временная привязка
  // FIXME: Контейнер теперь придется хранить
  self.chartData = [[self.dataSource dataForLinearChart] internalData];
  [self.gridView setNeedsDisplay];
  [self.xAxisView setNeedsDisplay];
  [self.yAxisView setNeedsDisplay];
  [self.chartView setNeedsDisplay];
  [self.chartView2 setNeedsDisplay];
}

#pragma mark - Layout subviews helpers

- (void)setupSubviews {
  self.backgroundColor = [[self.styleContainer areaStyle] areaColor];
  
  self.gridView = [PLTGridView new];
  self.xAxisView = [PLTAxisView axisWithType:PLTAxisTypeX andFrame:CGRectZero];
  self.yAxisView = [PLTAxisView axisWithType:PLTAxisTypeY andFrame:CGRectZero];
  
  self.gridView.translatesAutoresizingMaskIntoConstraints = NO;
  self.xAxisView.translatesAutoresizingMaskIntoConstraints = NO;
  self.yAxisView.translatesAutoresizingMaskIntoConstraints = NO;
  
  self.gridView.styleSource = self;
  self.xAxisView.styleSource = self;
  self.yAxisView.styleSource = self;
  
  self.gridView.dataSource = self;
  self.xAxisView.dataSource = self;
  self.yAxisView.dataSource = self;
  
  [self addSubview:self.gridView];
  [self addSubview:self.xAxisView];
  [self addSubview:self.yAxisView];
  
  self.chartView = [[PLTLinearChartView alloc] initWithFrame:self.gridView.bounds];
  self.chartView2 = [[PLTLinearChartView alloc] initWithFrame:self.gridView.bounds];
  
  NSMutableArray<NSLayoutConstraint *> *constraints = [self creatingConstraints];
  
  self.chartView.seriesName = @"Revenue";
  self.chartView2.seriesName = @"Expence";
  
  self.chartView.translatesAutoresizingMaskIntoConstraints = NO;
  self.chartView2.translatesAutoresizingMaskIntoConstraints = NO;
  
  self.chartView.styleSource = self;
  self.chartView2.styleSource = self;
  
  self.chartView.dataSource = self;
  self.chartView2.dataSource = self;
  
  [self addSubview:self.chartView];
  [self addSubview:self.chartView2];
  
  [constraints addObject:[NSLayoutConstraint constraintWithItem:self.chartView
                                                      attribute:NSLayoutAttributeWidth
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.gridView
                                                      attribute:NSLayoutAttributeWidth
                                                     multiplier:1.0
                                                       constant:2*10.0]];
  [constraints addObject:[NSLayoutConstraint constraintWithItem:self.chartView
                                                      attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.gridView
                                                      attribute:NSLayoutAttributeHeight
                                                     multiplier:1.0
                                                       constant:2*10.0]];
  [constraints addObject:[NSLayoutConstraint constraintWithItem:self.chartView
                                                      attribute:NSLayoutAttributeCenterX
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.gridView
                                                      attribute:NSLayoutAttributeCenterX
                                                     multiplier:1.0
                                                       constant:0.0]];
  [constraints addObject:[NSLayoutConstraint constraintWithItem:self.chartView
                                                      attribute:NSLayoutAttributeCenterY
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.gridView
                                                      attribute:NSLayoutAttributeCenterY
                                                     multiplier:1.0
                                                       constant:0.0]];
  
  [constraints addObject:[NSLayoutConstraint constraintWithItem:self.chartView2
                                                      attribute:NSLayoutAttributeWidth
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.gridView
                                                      attribute:NSLayoutAttributeWidth
                                                     multiplier:1.0
                                                       constant:2*10.0]];
  [constraints addObject:[NSLayoutConstraint constraintWithItem:self.chartView2
                                                      attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.gridView
                                                      attribute:NSLayoutAttributeHeight
                                                     multiplier:1.0
                                                       constant:2*10.0]];
  [constraints addObject:[NSLayoutConstraint constraintWithItem:self.chartView2
                                                      attribute:NSLayoutAttributeCenterX
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.gridView
                                                      attribute:NSLayoutAttributeCenterX
                                                     multiplier:1.0
                                                       constant:0.0]];
  [constraints addObject:[NSLayoutConstraint constraintWithItem:self.chartView2
                                                      attribute:NSLayoutAttributeCenterY
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.gridView
                                                      attribute:NSLayoutAttributeCenterY
                                                     multiplier:1.0
                                                       constant:0.0]];
  
  [self addConstraints:constraints];
}

#pragma mark - Description

- (NSString *)description{
  return [NSString stringWithFormat:@"<%@: %p \n Frame = %@ \n Styles: = %@>",
          self.class,
          (void *)self,
          NSStringFromCGRect(self.frame),
          self.styleContainer
          ];
}

#pragma mark - PLTInternalLinearChartDataSource

- (nullable NSDictionary<NSString *, NSArray<NSNumber *> *> *)chartDataSetForSeries:(NSString *)seriesName {
  return [[self.dataSource dataForLinearChart] dataForSeriesWithName:seriesName];
}

- (nullable NSArray<NSNumber *> *)xDataSet{
  return self.chartData?self.chartData[kPLTXAxis]:nil;
}

- (nullable NSArray<NSNumber *> *)yDataSet {
  if (self.chartData) {
    return [PLTAxisDataFormatter axisDataSetFromChartValues:self.chartData[kPLTYAxis]
                                         withGridLinesCount:10.0];
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
