//
//  PLTCortesianView+Constraints.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 13.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTCartesianView+Constraints.h"
#import "PLTGridView.h"
#import "PLTAxisXView.h"
#import "PLTAxisYView.h"
#import "PLTLegendView.h"


@interface PLTCartesianView ()

@property(nonatomic, strong) UILabel *chartNameLabel;
@property(nonatomic, strong) PLTAxisXView *xAxisView;
@property(nonatomic, strong) PLTAxisYView *yAxisView;
@property(nonatomic,strong) PLTLegendView *legendView;
@property(nonatomic,strong) PLTGridView *gridView;

@property(nonatomic, strong, nullable) NSLayoutConstraint *legendConstraint;
@property(nonatomic, strong, nullable) NSLayoutConstraint *axisXConstraint;
@property(nonatomic, strong, nullable) NSLayoutConstraint *axisYConstraint;

@end


@implementation PLTCartesianView (Constraints)

#pragma mark - Creating constraints

- (NSMutableArray<NSLayoutConstraint *> *)creatingConstraints {
  self.chartNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.gridView.translatesAutoresizingMaskIntoConstraints = NO;
  self.xAxisView.translatesAutoresizingMaskIntoConstraints = NO;
  self.yAxisView.translatesAutoresizingMaskIntoConstraints = NO;
  self.legendView.translatesAutoresizingMaskIntoConstraints = NO;
  
  NSMutableArray<NSLayoutConstraint *> *constraints = [[NSMutableArray alloc] init];
  NSDictionary<NSString *,__kindof UIView *> *views = @{
                                                        @"chartName": self.chartNameLabel,
                                                        @"axisXView": self.xAxisView,
                                                        @"axisYView": self.yAxisView,
                                                        @"gridView": self.gridView,
                                                        @"legendView": self.legendView
                                                        };
  NSDictionary<NSString *, NSNumber *> *metrics = @{
                                                    @"head":@(10),
                                                    @"tail":@(10)
                                                    };
  
  self.legendConstraint = [NSLayoutConstraint constraintWithItem: self.legendView
                                                       attribute: NSLayoutAttributeHeight
                                                       relatedBy: NSLayoutRelationEqual
                                                          toItem: nil
                                                       attribute: NSLayoutAttributeNotAnAttribute
                                                      multiplier: 0.0
                                                        constant: [self.legendView viewRequaredHeight]];
  self.axisXConstraint = [NSLayoutConstraint constraintWithItem: self.xAxisView
                                                      attribute: NSLayoutAttributeHeight
                                                      relatedBy: NSLayoutRelationEqual
                                                         toItem: nil
                                                      attribute: NSLayoutAttributeNotAnAttribute
                                                     multiplier: 0.0
                                                       constant: [self.xAxisView viewRequaredHeight]];
  self.axisYConstraint = [NSLayoutConstraint constraintWithItem: self.yAxisView
                                                      attribute: NSLayoutAttributeWidth
                                                      relatedBy: NSLayoutRelationEqual
                                                         toItem: nil
                                                      attribute: NSLayoutAttributeNotAnAttribute
                                                     multiplier: 0.0
                                                       constant: [self.yAxisView viewRequaredWidth]];
  
  [constraints addObject: (NSLayoutConstraint *_Nonnull)self.legendConstraint];
  [constraints addObject: (NSLayoutConstraint *_Nonnull)self.axisXConstraint];
  [constraints addObject: (NSLayoutConstraint *_Nonnull)self.axisYConstraint];
  
  [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[chartName]-|"
                                                                            options:NSLayoutFormatDirectionLeadingToTrailing
                                                                            metrics:nil
                                                                              views:views]];
  [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-head-[chartName]-[axisYView][axisXView]-[legendView]|"
                                                                            options:NSLayoutFormatDirectionLeadingToTrailing
                                                                            metrics:metrics
                                                                              views:views]];
  [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-head-[chartName]-[gridView][axisXView]-[legendView]|"
                                                                            options:NSLayoutFormatDirectionLeadingToTrailing
                                                                            metrics:metrics
                                                                              views:views]];
  [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[axisYView][gridView]-tail-|"
                                                                            options:NSLayoutFormatDirectionLeadingToTrailing
                                                                            metrics:metrics
                                                                              views:views]];
  [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"H:[axisXView(==gridView)]-tail-|"
                                                                            options:NSLayoutFormatDirectionLeadingToTrailing
                                                                            metrics:metrics
                                                                              views:views]];
  [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[legendView]-10-|"
                                                                            options:NSLayoutFormatDirectionLeadingToTrailing
                                                                            metrics:nil
                                                                              views:views]];
  return constraints;
}

- (NSMutableArray<NSLayoutConstraint *> *)creatingChartConstraints:(UIView *)chartView
                                                     withExpansion:(CGFloat)expansion {
  chartView.translatesAutoresizingMaskIntoConstraints = NO;
  NSMutableArray<NSLayoutConstraint *> *constraints = [[NSMutableArray alloc] init];
  [constraints addObject:[NSLayoutConstraint constraintWithItem:chartView
                                                      attribute:NSLayoutAttributeWidth
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.gridView
                                                      attribute:NSLayoutAttributeWidth
                                                     multiplier:1.0
                                                       constant:2*expansion]];
  [constraints addObject:[NSLayoutConstraint constraintWithItem:chartView
                                                      attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.gridView
                                                      attribute:NSLayoutAttributeHeight
                                                     multiplier:1.0
                                                       constant:2*expansion]];
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
  return constraints;
}

#pragma mark - Updating constraints

- (void)updateConstraints {
  self.legendConstraint.constant = [self.legendView viewRequaredHeight];
  self.axisXConstraint.constant = [self.xAxisView viewRequaredHeight];
  self.axisYConstraint.constant = [self.yAxisView viewRequaredWidth];
  [super updateConstraints];
}

@end
