//
//  PLTLegendView.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

@protocol PLTLegendViewDataSource <NSObject>

- (nullable NSDictionary<NSString *, NSDictionary *> *)chartViewsLegend;
- (void)selectChart:(nullable NSString *)chartName;

@end


@interface PLTLegendView : UIView

@property(nonatomic, weak, nullable) id<PLTLegendViewDataSource> dataSource;

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (nonnull instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;

@end
