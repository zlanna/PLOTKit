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

static const CGFloat kNestedScale = 0.10;

@interface PLTLinearView ()<PLTGridViewDelegate, PLTAxisDelegate, PLTLinearChartDelegate, PLTAreaDelegate>

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
    
    _styleContainer = [PLTLinearStyleContainer blank];
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
  self.chartView = [[PLTLinearChart alloc] initWithFrame: contentFrame];
  self.xAxis = [PLTAxis axisWithType:PLTAxisTypeX andFrame: contentFrame];
  self.yAxis = [PLTAxis axisWithType:PLTAxisTypeY andFrame: contentFrame];
  
  [self addAutoresizingToSubview:self.gridView];
  [self addAutoresizingToSubview:self.chartView];
  [self addAutoresizingToSubview:self.xAxis];
  [self addAutoresizingToSubview:self.yAxis];
  [self addAutoresizingToSubview:self.areaView];
  
  self.areaView.delegate = self;
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

-(PLTGridStyle *)gridStyle{
  return self.styleContainer.gridStyle;
}

#pragma mark - PLTAxisDelegate

- (PLTAxisStyle *)axisXStyle {
  return self.styleContainer.axisXStyle;
}

- (PLTAxisStyle *)axisYStyle {
  return self.styleContainer.axisYStyle;
}

- (NSUInteger)axisXMarksCount {
  return 10;
}

- (NSUInteger)axisYMarksCount {
  return 10;
}

#pragma mark - PLTLinearChartDelegate

- (PLTLinearChartStyle *)chartStyle {
  return self.styleContainer.chartStyle;
}

#pragma mark - PLTAreaDelegate

- (PLTAreaStyle *)areaStyle {
  return self.styleContainer.areaStyle;
}

@end
