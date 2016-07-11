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
#import "PLTLegendView.h"

const CGRect kPLTDefaultFrame = {{0.0, 0.0}, {200.0, 200.0}};

typedef NSDictionary<NSString *,NSArray<NSNumber *> *> ChartData;

@interface PLTLinearView (Constraints)

- (NSMutableArray<NSLayoutConstraint *> *)creatingConstraints;

@end

@interface PLTLinearView ()<PLTStyleSource, PLTInternalLinearChartDataSource, PLTLegendViewDataSource>

@property(nonatomic, strong) UILabel *chartNameLabel;
@property(nonatomic, strong) PLTGridView *gridView;
@property(nonatomic, strong) PLTAxisView *xAxisView;
@property(nonatomic, strong) PLTAxisView *yAxisView;
@property(nonatomic,strong) PLTLegendView *legendView;
@property(nonatomic, strong, nonnull) NSMutableDictionary<NSString *,PLTLinearChartView *> *chartViews;
@property(nonatomic, strong, nullable) ChartData *chartData;

@property(nonatomic, strong, nullable) NSLayoutConstraint *legendConstraint;
@property(nonatomic, strong, nullable) NSLayoutConstraint *axisXConstraint;
@property(nonatomic, strong, nullable) NSLayoutConstraint *axisYConstraint;

@end

@implementation PLTLinearView

@synthesize dataSource;

@synthesize chartName = _chartName;
@synthesize axisXName = _axisXName;
@synthesize axisYName = _axisYName;
@synthesize chartData = _chartData;
@synthesize chartViews = _chartViews;

@synthesize styleContainer;
@synthesize chartNameLabel;
@synthesize gridView;
@synthesize xAxisView;
@synthesize yAxisView;
@synthesize legendView;

@synthesize legendConstraint;
@synthesize axisXConstraint;
@synthesize axisYConstraint;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth
    |UIViewAutoresizingFlexibleHeight;
    self.contentMode = UIViewContentModeRedraw;
    
    _chartViews = [NSMutableDictionary<NSString *, PLTLinearChartView *> new];
    _chartData = nil;
    _chartName = @"";
    _axisXName = @"Month";
    _axisYName = @"$";
  }
  return self;
}

- (null_unspecified instancetype)init {
  return [self initWithFrame:kPLTDefaultFrame];
}

#pragma mark - Custom property setters

- (void)setChartName:(NSString *)chartName {
  _chartName = [chartName copy];
  if(self.chartNameLabel){
    self.chartNameLabel.text = chartName;
    if(chartName) {
      CGFloat newWidth = [chartName sizeWithAttributes:@{NSFontAttributeName : self.chartNameLabel.font}].width;
      CGPoint center = self.chartNameLabel.center;
      CGRect currentFrame = self.chartNameLabel.frame;
      CGRect newPinValueLabelFrame = CGRectMake(center.x - newWidth/2,CGRectGetMinY(currentFrame),
                                                newWidth, CGRectGetHeight(currentFrame));
      self.chartNameLabel.frame = newPinValueLabelFrame;
      self.chartNameLabel.text = chartName;
    }
    else {
      self.chartNameLabel.frame = CGRectZero;
    }
  }
}

- (void)setAxisXName:(NSString *)axisXName {
  _axisXName = axisXName;
  if (self.xAxisView) {
    self.xAxisView.axisName = axisXName;
  }
}

- (void)setAxisYName:(NSString *)axisYName {
  _axisYName = axisYName;
  if (self.yAxisView) {
    self.yAxisView.axisName = axisYName;
  }
}

#pragma mark - Layout subviews

- (void)layoutSubviews {
  [super layoutSubviews];
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self setupSubviews];
  });
  [self.xAxisView layoutIfNeeded];
  [self.yAxisView layoutIfNeeded];
  [self.gridView layoutIfNeeded];
  [self.legendView layoutIfNeeded];
  [self updateConstraints];
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
  if (self.chartViews.count > 0) {
    for (NSString *seriesName in self.chartViews) {
      [self.chartViews[seriesName] setNeedsDisplay];
    }
  }
  [self.legendView setNeedsDisplay];
}

#pragma mark - Layout subviews helpers

- (void)setupSubviews {
  self.backgroundColor = [[self.styleContainer areaStyle] areaColor];
  //self.backgroundColor = [UIColor lightGrayColor];
  
  self.chartNameLabel = [[UILabel alloc] init];
  self.chartNameLabel.backgroundColor = [[self.styleContainer areaStyle] areaColor];
  self.chartNameLabel.textColor = [UIColor blackColor];
  self.chartNameLabel.textAlignment = NSTextAlignmentCenter;
  self.chartNameLabel.text = self.chartName;
  
  self.gridView = [PLTGridView new];
  self.xAxisView = [PLTAxisView axisWithType:PLTAxisTypeX andFrame:CGRectZero];
  self.yAxisView = [PLTAxisView axisWithType:PLTAxisTypeY andFrame:CGRectZero];
  self.legendView = [PLTLegendView new];
  
  self.gridView.styleSource = self;
  self.xAxisView.styleSource = self;
  self.yAxisView.styleSource = self;
  
  self.gridView.dataSource = self;
  self.xAxisView.dataSource = self;
  self.yAxisView.dataSource = self;
  self.legendView.dataSource = self;
  
  self.xAxisView.axisName = self.axisXName;
  self.yAxisView.axisName = self.axisYName;
  
  [self addSubview:self.chartNameLabel];
  [self addSubview:self.gridView];
  [self addSubview:self.xAxisView];
  [self addSubview:self.yAxisView];
  [self addSubview:self.legendView];
  
  NSMutableArray<NSLayoutConstraint *> *constraints = [self creatingConstraints];
  [self addConstraints:constraints];
  [self setupChartViews];
}

#pragma mark - Setup chartviews helper

// FIXME: Magic numbers
- (void)setupChartViews {
  NSMutableArray<NSLayoutConstraint *> *constraints = [[NSMutableArray<NSLayoutConstraint *> alloc] init];
  NSArray *seriesNames = [[self.dataSource dataForLinearChart] seriesNames];
  
  if (seriesNames) {
    for (NSString *seriesName in seriesNames){
      PLTLinearChartView *chartView = [[PLTLinearChartView alloc] initWithFrame:CGRectZero];
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

#pragma mark - Description

- (NSString *)description{
  return [NSString stringWithFormat:@"<%@: %p \n Frame = %@ \n Styles: = %@>",
          self.class,
          (void *)self,
          NSStringFromCGRect(self.frame),
          self.styleContainer
          ];
}

#pragma mark - PLTLegendViewDataSource

- (nullable NSDictionary<NSString *, PLTLinearChartStyle *> *)chartViewsLegend {
  if (self.chartViews && self.chartViews.count>0) {
    NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc] initWithCapacity:self.chartViews.count];
    for (NSString *chartName in self.chartViews){
      PLTLinearChartStyle *chartStyle = [self.styleContainer chartStyleForSeries:chartName];
      [resultDictionary setObject:chartStyle
                           forKey:chartName];
    }
    return [resultDictionary copy];
  }
  else {
    return nil;
  }
}

- (void)selectChart:(nullable NSString *)chartName {
  if(chartName) {
    PLTLinearChartView *chartView = self.chartViews[(NSString *_Nonnull)chartName];
    [self bringSubviewToFront:chartView];
  }
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
