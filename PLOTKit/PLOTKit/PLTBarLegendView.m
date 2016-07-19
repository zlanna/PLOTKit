//
//  PLTBarLegendView.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 15.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTBarLegendView.h"
#import "PLTBarChartStyle.h"
#import "PLTLegendView+Protected.h"
#import "PLTMarker.h"

static const CGFloat kPLTMarkerSize = 6.0;

@interface PLTBarLegendView ()
@property(nonatomic, copy, nullable) NSDictionary<NSString *, PLTBarChartStyle*> *chartStylesForLegend;
@end


@implementation PLTBarLegendView
@synthesize chartStylesForLegend;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"
- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  for (UIButton *button in self.buttonsContainer){
    [self addSubview:button];
    if (self.chartStylesForLegend) {
      NSString *chartName = button.titleLabel.text;
      PLTBarChartStyle *chartStyle = self.chartStylesForLegend[chartName];
      
      CGContextSaveGState(context);
      
      CGFloat buttonOriginX = CGRectGetMinX(button.frame);
      CGFloat buttonOriginY = CGRectGetMinY(button.frame);
      CGFloat buttonHeight = CGRectGetHeight(button.frame);
      CGFloat legendWidth = kPLTLegendIconWidht;
      CGRect legendContainedRect = CGRectMake(buttonOriginX - legendWidth + 1, buttonOriginY,
                                              legendWidth - 1, buttonHeight);
      PLTMarker *marker = [PLTMarker markerWithType:PLTMarkerSquare];
      marker.color = chartStyle.chartColor;
      marker.size = kPLTMarkerSize;
      
      CGImageRef cgMarkerImage = marker.markerImage.CGImage;
      CGRect markerRect = CGRectMake(CGRectGetMidX(legendContainedRect) - marker.size,
                                     CGRectGetMidY(legendContainedRect) - marker.size,
                                     2*marker.size,
                                     2*marker.size);
      CGContextDrawImage(context, markerRect, cgMarkerImage);
      CGContextRestoreGState(context);
    }
  }
}
#pragma clang diagnostic pop

@end
