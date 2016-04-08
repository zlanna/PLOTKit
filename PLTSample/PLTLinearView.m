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

@interface PLTLinearView ()<PLTGridViewDelegate, PLTAxisDelegate, PLTLinearChartDelegate>

@property(nonatomic, strong) PLTLinearStyleContainer *styleContainer;
@property(nonatomic, strong) UILabel *chartNameLabel;
@property(nonatomic, strong) PLTAreaView *areaView;
@property(nonatomic, strong) PLTGridView *gridView;
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

@synthesize styleContainer = _styleContainer;
@synthesize chartNameLabel = _chartNameLabel;
@synthesize areaView = _areaView;
@synthesize gridView;
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
    
    _styleContainer = [PLTLinearStyleContainer cobalt];
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
  self.gridView = [[PLTGridView alloc] initWithStyle: self.styleContainer.gridStyle];
  self.chartView = [[PLTLinearChart alloc] initWithStyle: self.styleContainer.chartStyle];
  self.xAxis = [PLTAxis axisWithType:PLTAxisTypeX andStyle: self.styleContainer.axisXStyle];
  self.yAxis = [PLTAxis axisWithType:PLTAxisTypeY andStyle: self.styleContainer.axisYStyle];
  self.areaView = [[PLTAreaView alloc] initWithFrame:self.bounds];
  
  [self addAutoresizingToSubview:self.gridView];
  [self addAutoresizingToSubview:self.chartView];
  [self addAutoresizingToSubview:self.xAxis];
  [self addAutoresizingToSubview:self.yAxis];
  [self addAutoresizingToSubview:self.areaView];
  
  self.areaView.style = _styleContainer.areaStyle;
  [self addSubview:self.areaView];
  
  self.gridView.delegate = self;
  [self addSubview:self.gridView];

  self.chartView.delegate = self;
  [self addSubview:self.chartView];
  
  self.xAxis.delegate = self;
  [self addSubview:self.xAxis];
 
  self.yAxis.delegate = self;
  [self addSubview:self.yAxis];
}
#pragma clang diagnostic pop

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
