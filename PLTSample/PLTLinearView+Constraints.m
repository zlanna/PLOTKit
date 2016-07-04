//
//  PLTLinearView+Constraints.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 04.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLinearView+Constraints.h"
#import "PLTGridView.h"
#import "PLTAxisView.h"
#import "PLTAreaView.h"

@interface PLTLinearView ()

@property(nonatomic, strong) UILabel *chartNameLabel;
@property(nonatomic, strong) PLTGridView *gridView;
@property(nonatomic, strong) PLTAxisView *xAxisView;
@property(nonatomic, strong) PLTAxisView *yAxisView;

@end

@implementation PLTLinearView (Constraints)

#pragma mark - Making constraints

- (NSMutableArray<NSLayoutConstraint *> *)creatingConstraints {
  self.chartNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.gridView.translatesAutoresizingMaskIntoConstraints = NO;
  self.xAxisView.translatesAutoresizingMaskIntoConstraints = NO;
  self.yAxisView.translatesAutoresizingMaskIntoConstraints = NO;
  
  NSMutableArray<NSLayoutConstraint *> *constraints = [[NSMutableArray alloc] init];
  NSDictionary<NSString *,__kindof UIView *> *views = @{
                                                        @"chartName": self.chartNameLabel,
                                                        @"axisXView": self.xAxisView,
                                                        @"axisYView": self.yAxisView,
                                                         @"gridView": self.gridView
                                                        };
  NSDictionary<NSString *, NSNumber *> *metrics = @{
                                                    @"head":@(20),
                                                    @"legendStub":@(80),
                                                    @"tail":@(20)
                                                    };
  [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[chartName]|"
                                                                            options:NSLayoutFormatDirectionLeadingToTrailing
                                                                            metrics:nil
                                                                              views:views]];
  [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[axisYView(==70)][gridView]-tail-|"
                                                                            options:NSLayoutFormatDirectionLeadingToTrailing
                                                                            metrics:metrics
                                                                              views:views]];
  [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-head-[chartName]-legendStub-[axisYView][axisXView]|"
                                                                            options:NSLayoutFormatDirectionLeadingToTrailing
                                                                            metrics:metrics
                                                                              views:views]];
  [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-head-[chartName]-legendStub-[gridView][axisXView]|"
                                                                            options:NSLayoutFormatDirectionLeadingToTrailing
                                                                            metrics:metrics
                                                                              views:views]];
  [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[axisXView(==70)]|"
                                                                            options:NSLayoutFormatDirectionLeadingToTrailing
                                                                            metrics:nil
                                                                              views:views]];
  [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"H:[axisXView(==gridView)]-tail-|"
                                                                            options:NSLayoutFormatDirectionLeadingToTrailing
                                                                            metrics:metrics
                                                                              views:views]];
  return constraints;
}

@end
