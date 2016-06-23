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
  // FIX: Скрытая временная привязка
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
  [self addSubview:self.xAxisView];
  [self addSubview:self.yAxisView];
  [self addSubview:self.chartView];
  
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
  // TODO: Incapsulate formatting in object
  if (self.chartData) {
    double gridLinesCount = 2;
    
    __block double max = 0.0;
    __block double min = 0.0;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"
    [self.chartData[kPLTYAxis] enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      double current = [obj doubleValue];
      if(current>max) max=current;
      if(current<min) min=current;
    }];
#pragma clang diagnostic pop
    
    double absMax = (fabs(max) > fabs(min))?fabs(max):fabs(min);
    double additionalMultiplier = 1;
    double y = absMax;
    
    if (y<10) {
      additionalMultiplier = 10;
      y = y*additionalMultiplier;
    }
    y = ceil(y);
    double digitsCount = floor(log10(y) + 1);
    double multiplier = pow(10, digitsCount - 2);
    double mostSignDigits = y/multiplier;
    double gridEdge;
    if (mostSignDigits <= 20) {
      gridEdge = ceil(mostSignDigits/2)*2;
    }
    else {
      gridEdge = ceil(mostSignDigits/10)*10;
    }
    gridEdge = (gridEdge * multiplier) / additionalMultiplier;
    
    
    double gridYDelta = gridEdge/gridLinesCount;
    NSMutableArray<NSNumber *> *resultArray = [NSMutableArray<NSNumber *> new];
  
    if ( (max>0) && (min<0) ) {
      if (absMax == fabs(max)) {
        for (NSUInteger i = 0; (gridEdge - i*gridYDelta)>= (min - gridYDelta/2); ++i) {
            [resultArray addObject:[NSNumber numberWithDouble:gridEdge - i*gridYDelta]];
        }
        resultArray = [[[resultArray reverseObjectEnumerator] allObjects] mutableCopy];
      }
      else if (absMax == fabs(min)) {
        for (NSUInteger i = 0; (-gridEdge + i*gridYDelta)<= (max + gridYDelta/2); ++i) {
          [resultArray addObject:[NSNumber numberWithDouble:-gridEdge + i*gridYDelta]];
        }
      }
    }
    else if ((max>0) && (min>=0)) {
      for (NSUInteger i = 0; i<=gridLinesCount; ++i) {
        [resultArray addObject:[NSNumber numberWithDouble:i*gridYDelta]];
      }
    }
    else if ((max<=0) && (min<0)) {
      [resultArray addObject:[NSNumber numberWithDouble:0]];
      for (NSUInteger i = 1; i<=gridLinesCount; ++i) {
        [resultArray addObject:[NSNumber numberWithDouble:-(double)i*gridYDelta]];
      }
      resultArray = [[[resultArray reverseObjectEnumerator] allObjects] mutableCopy];
    }
    return [resultArray copy];
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
