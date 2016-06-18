//
//  PLTArraySortAndRemoveTest.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 21.04.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+SortAndRemove.h"

@interface PLTArraySortAndRemoveTest : XCTestCase{
  NSArray<NSNumber *> *_testArray;
}

@end

@implementation PLTArraySortAndRemoveTest

- (void)setUp {
    [super setUp];
  _testArray = @[@(-10),@(-5),@(-10),@(-1),@0,@3,@1,@3,@0,@5,@8,@6,@6,@8];
}

- (void)tearDown {
  _testArray = nil;
    [super tearDown];
}

- (void)testSorting {
  _testArray = [NSArray plt_sortAndRemoveDublicatesNumbers:_testArray];
  NSArray *resultArray = @[@(-10),@(-5),@(-1),@0,@1,@3,@5,@6,@8];
  XCTAssertTrue([_testArray isEqualToArray:resultArray]);
}

- (void)testGetPositiveArray {
  _testArray = [NSArray plt_sortAndRemoveDublicatesNumbers:_testArray];
  _testArray = [NSArray plt_positiveNumbersArray:_testArray];
  NSArray *resultArray = @[@0,@1,@3,@5,@6,@8];
  NSLog(@"%@", _testArray);
  XCTAssertTrue([_testArray isEqualToArray:resultArray]);
}

- (void)testGetNegativeArray {
  _testArray = [NSArray plt_sortAndRemoveDublicatesNumbers:_testArray];
  _testArray = [NSArray plt_negativeNumbersArray:_testArray];
  NSArray *resultArray = @[@(-10),@(-5),@(-1)];
  NSLog(@"%@", _testArray);
  XCTAssertTrue([_testArray isEqualToArray:resultArray]);
}

//TODO: Тесты на пустые массивы

@end
