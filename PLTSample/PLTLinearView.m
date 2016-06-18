//
//  PLTLinearView.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLinearView.h"
#import "UIView+PLTNestedView.h"
#import "NSArray+SortAndRemove.h"
#import "PLTGridView.h"
#import "PLTLinearChartView.h"
#import "PLTAxisView.h"
#import "PLTAreaView.h"
#import "PLTChartData.h"

const CGRect kPLTDefaultFrame = {{0.0, 0.0}, {200.0, 200.0}};

static const CGFloat kNestedScale = 0.10;
typedef NSDictionary<NSString *,NSArray<NSNumber *> *> ChartData;

@interface PLTLinearView ()<PLTStyleSource, PLTInternalLinearChartDataSource>

@property(nonatomic, strong) UILabel *chartNameLabel;
@property(nonatomic, strong) PLTAreaView *areaView;
@property(nonatomic, strong) PLTGridView *gridView;
@property(nonatomic, strong) PLTAxisView *xAxisView;
@property(nonatomic, strong) PLTAxisView *yAxisView;
@property(nonatomic, strong) PLTLinearChartView *chartView;
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
@synthesize areaView;
@synthesize gridView;
@synthesize xAxisView;
@synthesize yAxisView;
@synthesize chartView;


#pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor lightGrayColor];
    
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
}

- (void)setNeedsDisplay{
  [super setNeedsDisplay];
  //FIX: Скрытая временная привязка
  self.chartData = [[self.dataSource dataForLinearChart] internalData];
  [self.areaView setNeedsDisplay];
  [self.gridView setNeedsDisplay];
  [self.xAxisView setNeedsDisplay];
  [self.yAxisView setNeedsDisplay];
  [self.chartView setNeedsDisplay];
}

#pragma mark - Layout subviews helpers

- (void)setupSubviews {
  self.areaView = [[PLTAreaView alloc] initWithFrame:self.frame];

  CGRect contentFrame = [UIView plt_nestedViewFrame:self.frame nestedScaled:kNestedScale];
  self.gridView = [[PLTGridView alloc] initWithFrame: contentFrame];
  self.chartView = [[PLTLinearChartView alloc] initWithFrame: contentFrame];
  self.xAxisView = [PLTAxisView axisWithType:PLTAxisTypeX andFrame: contentFrame];
  self.yAxisView = [PLTAxisView axisWithType:PLTAxisTypeY andFrame: contentFrame];
  
  [self addAutoresizingToSubview:self.gridView];
  [self addAutoresizingToSubview:self.chartView];
  [self addAutoresizingToSubview:self.xAxisView];
  [self addAutoresizingToSubview:self.yAxisView];
  [self addAutoresizingToSubview:self.areaView];
  
  self.areaView.styleSource = self;
  self.gridView.styleSource = self;
  self.chartView.styleSource = self;
  self.xAxisView.styleSource = self;
  self.yAxisView.styleSource = self;
  
  self.gridView.dataSource = self;
  self.chartView.dataSource = self;
  self.xAxisView.dataSource = self;
  self.yAxisView.dataSource = self;
  
  [self addSubview:self.areaView];
  [self addSubview:self.gridView];
  [self addSubview:self.chartView];
  [self addSubview:self.xAxisView];
  [self addSubview:self.yAxisView];
  [self setNeedsDisplay];
}

- (void)addAutoresizingToSubview:(UIView *)subview {
  subview.autoresizingMask = UIViewAutoresizingFlexibleWidth
  |UIViewAutoresizingFlexibleHeight;
  subview.contentMode = UIViewContentModeRedraw;
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

- (nullable NSDictionary<NSString *, NSArray<NSNumber *> *> *)chartDataSet{
  return self.chartData?self.chartData:nil;
}

- (nullable NSArray<NSNumber *> *)xDataSet{
  return self.chartData?self.chartData[kPLTXAxis]:nil;
}

- (nullable NSArray<NSNumber *> *)yDataSet{
  //HACK:
  if (self.chartData) {
    //FIX: Считается только для положительной части оси
    NSArray *sortedArray = [NSArray plt_sortAndRemoveDublicatesNumbers:self.chartData[kPLTYAxis]];
    NSArray *positiveValuesArray = [NSArray plt_positiveNumbersArray:sortedArray];
    NSArray *negativeValuesArray = [NSArray plt_negativeNumbersArray:sortedArray];
    NSMutableArray<NSNumber *> *resultArray = [NSMutableArray<NSNumber *> new];
    if (positiveValuesArray.count > negativeValuesArray.count) {
      double max = [[sortedArray lastObject] doubleValue];
      double min = [sortedArray[0] doubleValue];
      double gridCount = 10.0;
      double gridDelta = max/gridCount;
      for (NSUInteger i=1; i*(-gridDelta)>=min; ++i) {
        [resultArray addObject:[NSNumber numberWithDouble:i*(-gridDelta)]];
      }
      
      resultArray = [[[resultArray reverseObjectEnumerator] allObjects] mutableCopy];
      
      for (NSUInteger i=0; i*gridDelta<=max; ++i) {
        [resultArray addObject:[NSNumber numberWithDouble:i*gridDelta]];
      }
    }
    else {
      
    }
    return [resultArray copy];
  }
  else {
    return nil;
  }
}

- (NSUInteger)axisXMarksCount {
  return self.chartData?[[self xDataSet] count]:0;
}

- (NSUInteger)axisYMarksCount {
  return self.chartData?[[self yDataSet] count]:0;
}

@end
