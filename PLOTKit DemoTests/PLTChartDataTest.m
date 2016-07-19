//
//  PLTChartDataTest.m
//  PLOTKit Demo
//
//  Created by ALEXEY ULENKOV on 20.04.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import XCTest;
#import "PLTChartData.h"

@interface PLTChartDataTest : XCTestCase{
  PLTChartData *_chartData;
}

@end

@implementation PLTChartDataTest

- (void)setUp {
    [super setUp];
  _chartData = [PLTChartData new];
}

- (void)tearDown {
  _chartData = nil;
    [super tearDown];
}

- (void)testDataAdding {
  [_chartData addPointWithXValue:@10 andYValue:@20];
  [_chartData addPointWithXValue:@30 andYValue:@5];
  [_chartData addPointWithXValue:@35 andYValue:@15];
  ChartData *container = @{
                           @"X": @[@10,@30,@35],
                           @"Y": @[@20,@5,@15]
                           };
  XCTAssertTrue([[_chartData internalData] isEqualToDictionary:container]);
}

@end
