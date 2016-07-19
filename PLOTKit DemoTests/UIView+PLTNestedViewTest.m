//
//  UIView+PLTNestedViewTest.m
//  PLOTKit Demo
//
//  Created by ALEXEY ULENKOV on 07.04.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIView+PLTNestedView.h"

@interface UIView_PLTNestedViewTest : XCTestCase{
  UIView *_parentView;
  UIView *_nestedView;
  CGFloat _scale;
}

@end

@implementation UIView_PLTNestedViewTest

- (void)setUp {
    [super setUp];
  _parentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
  _nestedView = [[UIView alloc] init];
}

- (void)tearDown {
  _parentView = nil;
  _nestedView = nil;
  _scale = 0.0;
  [super tearDown];
}

- (void)testFrameScalingNormalWay {
  _scale = 0.15;
  _nestedView.frame = [UIView plt_nestedViewFrame:_parentView.frame nestedScaled:_scale];
  CGFloat scaleFactor = 1.0 - _scale;
  CGFloat parentLeftEdgeX = CGRectGetMinX(_parentView.frame);
  CGFloat parentLeftEdgeY = CGRectGetMinY(_parentView.frame);
  CGFloat parentWidth = CGRectGetWidth(_parentView.frame);
  CGFloat parentHeight = CGRectGetHeight(_parentView.frame);
  CGFloat newLeftEdgeX = parentLeftEdgeX + parentWidth*_scale/2.0;
  CGFloat newLeftEdgeY = parentLeftEdgeY + parentHeight*_scale/2.0;
  CGFloat newWidth = parentWidth * scaleFactor;
  CGFloat newHeight = parentHeight * scaleFactor;
  XCTAssertEqual(CGRectGetMinX(_nestedView.frame), newLeftEdgeX);
  XCTAssertEqual(CGRectGetMinY(_nestedView.frame), newLeftEdgeY);
  XCTAssertEqual(CGRectGetWidth(_nestedView.frame), newWidth);
  XCTAssertEqual(CGRectGetHeight(_nestedView.frame), newHeight);
}

- (void)testFrameScalingZeroFrame {
  _scale = 0.15;
  _parentView.frame = CGRectZero;
  _nestedView.frame = [UIView plt_nestedViewFrame:_parentView.frame nestedScaled:_scale];
  CGFloat scaleFactor = 1.0 - _scale;
  CGFloat parentLeftEdgeX = CGRectGetMinX(_parentView.frame);
  CGFloat parentLeftEdgeY = CGRectGetMinY(_parentView.frame);
  CGFloat parentWidth = CGRectGetWidth(_parentView.frame);
  CGFloat parentHeight = CGRectGetHeight(_parentView.frame);
  CGFloat newLeftEdgeX = parentLeftEdgeX + parentWidth*_scale/2.0;
  CGFloat newLeftEdgeY = parentLeftEdgeY + parentHeight*_scale/2.0;
  CGFloat newWidth = parentWidth * scaleFactor;
  CGFloat newHeight = parentHeight * scaleFactor;
  XCTAssertEqual(CGRectGetMinX(_nestedView.frame), newLeftEdgeX);
  XCTAssertEqual(CGRectGetMinY(_nestedView.frame), newLeftEdgeY);
  XCTAssertEqual(CGRectGetWidth(_nestedView.frame), newWidth);
  XCTAssertEqual(CGRectGetHeight(_nestedView.frame), newHeight);
}

- (void)testFrameScalingZeroScale {
  _scale = 0.0;
  _nestedView.frame = [UIView plt_nestedViewFrame:_parentView.frame nestedScaled:_scale];
  CGFloat scaleFactor = 1.0 - _scale;
  CGFloat parentLeftEdgeX = CGRectGetMinX(_parentView.frame);
  CGFloat parentLeftEdgeY = CGRectGetMinY(_parentView.frame);
  CGFloat parentWidth = CGRectGetWidth(_parentView.frame);
  CGFloat parentHeight = CGRectGetHeight(_parentView.frame);
  CGFloat newLeftEdgeX = parentLeftEdgeX + parentWidth*_scale/2.0;
  CGFloat newLeftEdgeY = parentLeftEdgeY + parentHeight*_scale/2.0;
  CGFloat newWidth = parentWidth * scaleFactor;
  CGFloat newHeight = parentHeight * scaleFactor;
  XCTAssertEqual(CGRectGetMinX(_nestedView.frame), newLeftEdgeX);
  XCTAssertEqual(CGRectGetMinY(_nestedView.frame), newLeftEdgeY);
  XCTAssertEqual(CGRectGetWidth(_nestedView.frame), newWidth);
  XCTAssertEqual(CGRectGetHeight(_nestedView.frame), newHeight);
}

@end
