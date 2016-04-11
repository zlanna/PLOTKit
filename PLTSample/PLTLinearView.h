
//
//  PLTLinearView.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

@protocol PLTDataSource <NSObject>
@end

@protocol PLTDelegate <NSObject>
@end

@interface PLTLinearView : UIView

@property (nonatomic, weak, nullable) id<PLTDelegate> delegate;
@property (nonatomic, weak, nullable) id<PLTDataSource> dataSource;

@property (nonatomic, copy, nullable) NSString *chartName;
@property (nonatomic, copy, nullable) NSString *axisXName;
@property (nonatomic, copy, nullable) NSString *axisYName;

- (null_unspecified instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(null_unspecified NSCoder *)aDecoder NS_UNAVAILABLE;
@end
