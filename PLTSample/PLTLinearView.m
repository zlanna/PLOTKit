//
//  PLTLinear.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import "PLTLinearView.h"
#import "PLTLinearStyleContainer.h"

#import "PLTGridView.h"
#import "PLTGridStyle.h"

#import "PLTLinearChart.h"
#import "PLTLinearChartStyle.h"

#import "PLTAxisX.h"
#import "PLTAxisY.h"
#import "PLTAxisStyle.h"

#import "PLTMarker.h"
#import "PLTPin.h"
#import "PLTAreaView.h"
#import "UIView+PLTNestedView.h"

@interface PLTLinearView (){
  //TODO: Для класса будет нужен какой-то билдер
  PLTLinearStyleContainer *_styleContainer;
}

@property(nonatomic, strong) UILabel *chartNameLabel;
@property(nonatomic, strong) PLTAreaView *areaView;
@property(nonatomic, strong) PLTGridView *greedView;
@property(nonatomic, strong) PLTAxisX *xAxis;
@property(nonatomic, strong) PLTAxisY *yAxis;
@property(nonatomic, strong) PLTLinearChart *chartView;

@end



@implementation PLTLinearView

@synthesize delegate;
@synthesize dataSource;

@synthesize gridHidden = _gridHidden;
@synthesize pinEnable = _pinEnable;

@synthesize markerType = _markerType;

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

//TODO: Окончательно разобраться с self внутри init
//TODO: Разобраться в отличиях id и instancetype

- (nonnull instancetype)initWithFrame:(CGRect)frame {
  if(self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor lightGrayColor];
    self.userInteractionEnabled = YES;
    self.frame = frame;
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth
    |UIViewAutoresizingFlexibleHeight
    |UIViewAutoresizingFlexibleLeftMargin;
    self.contentMode = UIViewContentModeRedraw;
    
    _gridHidden = YES;
    _pinEnable = NO;
    _markerType = PLTMarkerNone;
    _chartName = @"";
    _axisXName = @"x";
    _axisYName = @"y";
    [self setupSubviews];
  }
  return self;
}

- (nonnull instancetype)init {
  return [self initWithFrame:CGRectZero];
}

/*
- (id)initWithCoder:(NSCoder *)aDecoder {
  @throw [NSException
          exceptionWithName:NSInternalInconsistencyException
          reason:@"Must use initWithFrame:"
          userInfo:nil];
}
*/

#pragma mark - Init helpers

- (void)setupSubviews {
  _styleContainer = [PLTLinearStyleContainer cobalt];
  self.greedView = [[PLTGridView alloc] initWithStyle:_styleContainer.gridStyle];
  self.chartView = [[PLTLinearChart alloc] initWithStyle:_styleContainer.chartStyle];
  self.xAxis = [[PLTAxisX alloc] initWithStyle:_styleContainer.axisXStyle];
  self.yAxis = [[PLTAxisY alloc] initWithStyle:_styleContainer.axisYStyle];
  self.areaView = [[PLTAreaView alloc] initWithFrame:self.bounds];

  [self addAutoresizeToSubview:self.greedView];
  [self addAutoresizeToSubview:self.chartView];
  [self addAutoresizeToSubview:self.xAxis];
  [self addAutoresizeToSubview:self.yAxis];
  [self addAutoresizeToSubview:self.areaView];
  
  self.areaView.style = _styleContainer.areaStyle;
  [self addSubview:self.areaView];
  
  self.greedView.delegate = self;
  [self addSubview:self.greedView];

  self.chartView.delegate = self;
  [self addSubview:chartView];
  
  self.xAxis.delegate = self;
  [self addSubview:xAxis];
 
  self.yAxis.delegate = self;
  [self addSubview:yAxis];
}

- (void)addAutoresizeToSubview:(UIView *)subview {
  subview.autoresizingMask = UIViewAutoresizingFlexibleWidth
  |UIViewAutoresizingFlexibleHeight
  |UIViewAutoresizingFlexibleLeftMargin;
  subview.contentMode = UIViewContentModeRedraw;
}

#pragma mark - PLTGridViewDelegate

- (CGRect)gridViewFrame {
  if (self.areaView != nil) {
    return [UIView plt_nestedViewFrame:self.areaView.frame nestedScaled:0.05f];
  }
  else {
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
