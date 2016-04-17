//
//  PLTLinearView.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLinearView.h"
#import "UIView+PLTNestedView.h"
#import "PLTGridView.h"
#import "PLTLinearChartView.h"
#import "PLTAxisView.h"
#import "PLTAreaView.h"
//#import "PLTLinearStyleContainer.h"

static const CGFloat kNestedScale = 0.10;

@class PLTLinearStyleContainer;

@interface PLTLinearView ()<PLTAxisDelegate>

@property(nonatomic, strong) UILabel *chartNameLabel;
@property(nonatomic, strong) PLTAreaView *areaView;
@property(nonatomic, strong) PLTGridView *gridView;
@property(nonatomic, strong) PLTAxisView *xAxis;
@property(nonatomic, strong) PLTAxisView *yAxis;
@property(nonatomic, strong) PLTLinearChartView *chartView;

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

- (void)setupSubviews {
  self.areaView = [[PLTAreaView alloc] initWithFrame:self.frame];

  CGRect contentFrame = [UIView plt_nestedViewFrame:self.frame nestedScaled:kNestedScale];
  self.gridView = [[PLTGridView alloc] initWithFrame: contentFrame];
  self.chartView = [[PLTLinearChartView alloc] initWithFrame: contentFrame];
  self.xAxis = [PLTAxisView axisWithType:PLTAxisTypeX andFrame: contentFrame];
  self.yAxis = [PLTAxisView axisWithType:PLTAxisTypeY andFrame: contentFrame];
  
  [self addAutoresizingToSubview:self.gridView];
  [self addAutoresizingToSubview:self.chartView];
  [self addAutoresizingToSubview:self.xAxis];
  [self addAutoresizingToSubview:self.yAxis];
  [self addAutoresizingToSubview:self.areaView];
  
  self.areaView.styleSource = self;
  [self addSubview:self.areaView];
  
  self.gridView.styleSource = self;
  [self addSubview:self.gridView];

  self.chartView.styleSource = self;
  [self addSubview:self.chartView];
  
  self.xAxis.delegate = self;
  [self addSubview:self.xAxis];
 
  self.yAxis.delegate = self;
  [self addSubview:self.yAxis];
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

#pragma mark - PLTAxisDelegate

- (NSUInteger)axisXMarksCount {
  return 10;
}

- (NSUInteger)axisYMarksCount {
  return 10;
}


@end
