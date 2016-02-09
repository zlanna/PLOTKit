//
//  PLTView.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLTDelegate.h"
#import "PLTDataSource.h"

@class PLTAreaView;
@class PLTLegendView;

typedef enum PLTType{
  PLTTypeLinear,
  PLTTypeBarChart
} PLTType;

@interface PLTView : UIView {
@protected
  PLTAreaView *_plotArea;
  PLTType _plotType;
  PLTLegendView *_legend;
}

@property (nonatomic, weak) id<PLTDelegate> delegate;
@property (nonatomic, weak) id<PLTDataSource> dataSource;

- (id)initWithPlotType:(PLTType) plotType;

@end
