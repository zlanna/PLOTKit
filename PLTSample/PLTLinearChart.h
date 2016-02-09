//
//  PLTLinearChart.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 06.02.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PLTLinearChartDelegate <NSObject>

- (CGRect)chartFrame;

@end

@class PLTLinearChartStyle;

@interface PLTLinearChart : UIView

@property(nonatomic, weak) id<PLTLinearChartDelegate> delegate;
//TODO: В виде ключа возможно использовать свой тип
@property(nonatomic, nullable, strong) NSDictionary<const NSString *,NSArray<NSNumber *> *> *chartData;

- (nonnull instancetype)initWithStyle:(nonnull PLTLinearChartStyle *) style;

@end
