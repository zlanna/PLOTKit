
//
//  PLTLinear.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLTDelegate.h"
#import "PLTDataSource.h"
#import "PLTGridView.h"
#import "PLTAxis.h"
#import "PLTLinearChart.h"

typedef enum PLTMarkerType{
  PLTMarkerNone,
  PLTMarkerCircle,
  PLTMarkerSquare
}PLTMarkerType;


@interface PLTLinearView : UIView<PLTGridViewDelegate, PLTAxisDelegate, PLTLinearChartDelegate>

@property (nonatomic, weak, nullable) id<PLTDelegate> delegate;
@property (nonatomic, weak, nullable) id<PLTDataSource> dataSource;

@property (nonatomic) BOOL gridHidden;
@property (nonatomic) BOOL pinEnable;

@property (nonatomic) PLTMarkerType markerType;

@property (nonatomic, copy, nullable) NSString *chartName;
@property (nonatomic, copy, nullable) NSString *axisXName;
@property (nonatomic, copy, nullable) NSString *axisYName;

- (nonnull instancetype)initWithFrame:(CGRect)frame;

@end
