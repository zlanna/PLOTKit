//
//  PLTLinearChart.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 06.02.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSDictionary<const NSString *,NSArray<NSNumber *> *> ChartData;

@protocol PLTLinearChartDelegate <NSObject>

- (CGRect)chartFrame;

@end

@class PLTLinearChartStyle;

@interface PLTLinearChart : UIView

@property(nonatomic, weak, nullable) id<PLTLinearChartDelegate> delegate;
//TODO: В виде ключа возможно использовать свой тип
@property(nonatomic, nullable, strong) ChartData *chartData;

- (nonnull instancetype)initWithStyle:(nonnull PLTLinearChartStyle *) style;

@end
