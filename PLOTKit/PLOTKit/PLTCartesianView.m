//
//  PLTCartesianView.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 13.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTCartesianView.h"
#import "PLTCartesianView+Constraints.h"
#import "PLTAreaStyle.h"
#import "PLTGridView.h"
#import "PLTBaseLinearChartView.h"
#import "PLTAxisView.h"
#import "PLTChartData.h"
#import "PLTLegendView.h"

const CGRect kPLTDefaultFrame = {{0.0, 0.0}, {200.0, 200.0}};

typedef NSDictionary<NSString *,NSArray<NSNumber *> *> ChartData;

@interface PLTCartesianView (Constraints)

- (nonnull NSMutableArray<NSLayoutConstraint *> *)creatingConstraints;

@end

@interface PLTCartesianView ()<PLTStyleSource>

@property (nonatomic, strong, nullable) id<PLTStyleContainer> styleContainer;

@property(nonatomic, strong, nonnull) UILabel *chartNameLabel;
@property(nonatomic, strong, nonnull) PLTAxisView *xAxisView;
@property(nonatomic, strong, nonnull) PLTAxisView *yAxisView;
@property(nonatomic,strong, nonnull) PLTLegendView *legendView;
@property(nonatomic, strong, nullable) ChartData *chartData;
@property(nonatomic, strong, nonnull) PLTGridView *gridView;
@property(nonatomic, strong, nonnull) NSMutableDictionary<NSString *,__kindof PLTBaseLinearChartView *> *chartViews;

@property(nonatomic, strong, nullable) NSLayoutConstraint *legendConstraint;
@property(nonatomic, strong, nullable) NSLayoutConstraint *axisXConstraint;
@property(nonatomic, strong, nullable) NSLayoutConstraint *axisYConstraint;

@end

@implementation PLTCartesianView

@synthesize chartName = _chartName;
@synthesize axisXName = _axisXName;
@synthesize axisYName = _axisYName;
@synthesize chartData = _chartData;
@synthesize chartViews = _chartViews;
@synthesize gridView = _gridView;
@synthesize xAxisView = _xAxisView;
@synthesize yAxisView = _yAxisView;
@synthesize legendView = _legendView;
@synthesize chartNameLabel = _chartNameLabel;

@synthesize styleContainer;

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
    
    _chartViews = [NSMutableDictionary<NSString *,__kindof PLTBaseLinearChartView *> new];
    _chartData = nil;
    _chartName = @"";
    _axisXName = @"Month";
    _axisYName = @"Money, $";
    
    _gridView = [PLTGridView new];
    _xAxisView = [PLTAxisView axisWithType:PLTAxisTypeX andFrame:CGRectZero];
    _yAxisView = [PLTAxisView axisWithType:PLTAxisTypeY andFrame:CGRectZero];
    _legendView = [PLTLegendView new];
    _chartNameLabel = [[UILabel alloc] init];
  }
  return self;
}

- (null_unspecified instancetype)init {
  return [self initWithFrame:kPLTDefaultFrame];
}

#pragma mark - Custom property setters

- (void)setChartName:(nullable NSString *)chartName {
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

- (void)setAxisXName:(nullable NSString *)axisXName {
  _axisXName = axisXName;
  if (self.xAxisView) {
    self.xAxisView.axisName = axisXName;
  }
}

- (void)setAxisYName:(nullable NSString *)axisYName {
  _axisYName = axisYName;
  if (self.yAxisView) {
    self.yAxisView.axisName = axisYName;
  }
}

#pragma mark - Layout subviews

- (void)layoutSubviews {
  [super layoutSubviews];
  [self.xAxisView layoutIfNeeded];
  [self.yAxisView layoutIfNeeded];
  [self.gridView layoutIfNeeded];
  [self.legendView layoutIfNeeded];
  [self updateConstraints];
  [self setNeedsDisplay];
}

- (void)setNeedsDisplay{
  [super setNeedsDisplay];
  [self getDataFromSource];
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

- (void)getDataFromSource {
  [NSException raise:NSInternalInconsistencyException
              format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

#pragma mark - Layout subviews helpers

- (void)setupSubviews {
  [self getDataFromSource];
  
  self.backgroundColor = [[self.styleContainer areaStyle] areaColor];
  
  self.chartNameLabel.backgroundColor = [[self.styleContainer areaStyle] areaColor];
  self.chartNameLabel.textColor = [UIColor blackColor];
  self.chartNameLabel.textAlignment = NSTextAlignmentCenter;
  self.chartNameLabel.text = self.chartName;
  
  self.gridView.styleSource = self;
  self.xAxisView.styleSource = self;
  self.yAxisView.styleSource = self;
  
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

- (void)setupChartViews {
  [NSException raise:NSInternalInconsistencyException
              format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

#pragma mark - Description

- (nonnull NSString *)description{
  return [NSString stringWithFormat:@"<%@: %p \n Frame = %@ \n\
          Grig frame = %@ \n\
          Axis X frame = %@ \n\
          Axis Y frame = %@ \n\
          Legend frame = %@ \n\
          Styles: = %@>",
          self.class,
          (void *)self,
          NSStringFromCGRect(self.frame),
          NSStringFromCGRect(self.gridView.frame),
          NSStringFromCGRect(self.xAxisView.frame),
          NSStringFromCGRect(self.yAxisView.frame),
          NSStringFromCGRect(self.legendView.frame),
          self.styleContainer
          ];
}

@end
