//
//  PLTLinearView.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLinearView.h"
#import "UIView+PLTNestedView.h"

#import "PLTLinearStyleContainer.h"

#import "PLTGridView.h"
#import "PLTLinearChart.h"
#import "PLTAxis.h"
#import "PLTAreaView.h"

static const CGFloat gridViewScale = 0.05;

@interface PLTLinearView ()<PLTGridViewDelegate, PLTAxisDelegate, PLTLinearChartDelegate> {
  //TODO: Для класса будет нужен какой-то билдер
  PLTLinearStyleContainer *_styleContainer;
}

@property(nonatomic, strong) UILabel *chartNameLabel;
@property(nonatomic, strong) PLTAreaView *areaView;
@property(nonatomic, strong) PLTGridView *greedView;
@property(nonatomic, strong) PLTAxis *xAxis;
@property(nonatomic, strong) PLTAxis *yAxis;
@property(nonatomic, strong) PLTLinearChart *chartView;

@end


@implementation PLTLinearView

@synthesize delegate;
@synthesize dataSource;

@synthesize chartName = _chartName;
@synthesize axisXName = _axisXName;
@synthesize axisYName = _axisYName;

@synthesize chartNameLabel = _chartNameLabel;
@synthesize areaView = _areaView;
@synthesize greedView;
@synthesize xAxis;
@synthesize yAxis;
@synthesize chartView;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor lightGrayColor];
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth
    |UIViewAutoresizingFlexibleHeight;
    self.contentMode = UIViewContentModeRedraw;
    
    _chartName = @"";
    _axisXName = @"x";
    _axisYName = @"y";
  }
  return self;
}

- (null_unspecified instancetype)init {
  return [self initWithFrame:CGRectMake(0.0, 0.0, 200.0, 200.0)];
}

#pragma mark - Layout subviews

- (void)layoutSubviews {
  [super layoutSubviews];
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
     [self setupSubviews];
  });
}

#pragma mark - Layout subviews helpers

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdirect-ivar-access"

- (void)setupSubviews {
  _styleContainer = [PLTLinearStyleContainer cobalt];
  self.greedView = [[PLTGridView alloc] initWithStyle:_styleContainer.gridStyle];
  self.chartView = [[PLTLinearChart alloc] initWithStyle:_styleContainer.chartStyle];
  self.xAxis = [PLTAxis axisWithType:PLTAxisTypeX andStyle:_styleContainer.axisXStyle];
  self.yAxis = [PLTAxis axisWithType:PLTAxisTypeY andStyle:_styleContainer.axisYStyle];
  self.areaView = [[PLTAreaView alloc] initWithFrame:self.bounds];
  
  [self addAutoresizingToSubview:self.greedView];
  [self addAutoresizingToSubview:self.chartView];
  [self addAutoresizingToSubview:self.xAxis];
  [self addAutoresizingToSubview:self.yAxis];
  [self addAutoresizingToSubview:self.areaView];
  
  self.areaView.style = _styleContainer.areaStyle;
  [self addSubview:self.areaView];
  
  self.greedView.delegate = self;
  [self addSubview:self.greedView];

  self.chartView.delegate = self;
  [self addSubview:self.chartView];
  
  self.xAxis.delegate = self;
  [self addSubview:self.xAxis];
 
  self.yAxis.delegate = self;
  [self addSubview:self.yAxis];
  NSLog(@"%@", [self description]);
}
#pragma clang diagnostic pop

- (void)addAutoresizingToSubview:(UIView *)subview {
  subview.autoresizingMask = UIViewAutoresizingFlexibleWidth
  |UIViewAutoresizingFlexibleHeight;
  subview.contentMode = UIViewContentModeRedraw;
}

#pragma mark - PLTGridViewDelegate

- (CGRect)gridViewFrame {
  if (self.areaView != nil) {
    return [UIView plt_nestedViewFrame:self.areaView.frame nestedScaled:gridViewScale];
  }
  else {
     //???: Тут нужно или кидать исключении или делать какой-то отладочный вывод, такого не должно случаться
     return CGRectZero;
  }
}

#pragma mark - PLTAxisDelegate

- (CGRect)axisFrame {
  return [self gridViewFrame];
}

- (NSUInteger)axisXMarksCount {
  return 10;
}

- (NSUInteger)axisYMarksCount {
  return 10;
}

#pragma mark - PLTLinearChartDelegate

- (CGRect)chartFrame {
  return [self gridViewFrame];
}

@end
