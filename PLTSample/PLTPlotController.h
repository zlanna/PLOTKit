//
//  PLTPlotController.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 17.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

#import "PLTChartData.h"

@interface PLTPlotController : UIViewController

@property(nonatomic, copy, nonnull) NSString *designPresetName;

- (nonnull PLTChartData *)dataForChart;

@end
