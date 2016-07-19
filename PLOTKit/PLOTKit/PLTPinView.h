//
//  PLTPin.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

@protocol PLTPinViewDataSource <NSObject>

- (NSUInteger)closingSignicantPointIndexForPoint:(CGPoint)currentPoint;
- (CGPoint)pointForIndex:(NSUInteger)pointIndex;
- (nullable NSNumber *)valueForIndex:(NSUInteger)valueIndex;
- (NSUInteger)pointsCount;
@optional
- (nullable id<PLTStringValue>)labelForIndex:(NSUInteger)labelIndex;

@end


@interface PLTPinView : UIView

@property(nonatomic, weak, nullable) id<PLTPinViewDataSource> dataSource;
@property(nonatomic, strong, null_unspecified) UIColor *pinColor;

- (null_unspecified instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(nullable NSCoder *)aDecoder NS_UNAVAILABLE;

- (null_unspecified instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@end
