//
//  PLTLinearStyle.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 22.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTLinearStyleContainer.h"
#import "PLTGridStyle.h"
#import "PLTAxisStyle.h"
#import "PLTLinearChartStyle.h"
#import "PLTAreaStyle.h"

#define RGBCOLOR(x,y,z) \
    [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]

@implementation PLTLinearStyleContainer

@synthesize gridStyle;
@synthesize axisXStyle;
@synthesize axisYStyle;
@synthesize chartStyle;
@synthesize areaStyle;

#pragma mark - Static

+ (nonnull instancetype)createContainer {
  PLTLinearStyleContainer *styleContainer = [PLTLinearStyleContainer new];
  styleContainer.gridStyle = [PLTGridStyle blank];
  styleContainer.axisXStyle = [PLTAxisStyle blank];
  styleContainer.axisYStyle = [PLTAxisStyle blank];
  styleContainer.chartStyle = [PLTLinearChartStyle blank];
  styleContainer.areaStyle = [PLTAreaStyle blank];
  return styleContainer;
}

#pragma mark - Styles

+ (nonnull instancetype)blank {
  return [PLTLinearStyleContainer createContainer];
}

+ (nonnull instancetype)defaultStyle {
  PLTLinearStyleContainer *styleContainer = [PLTLinearStyleContainer new];
  styleContainer.gridStyle = [PLTGridStyle defaultStyle];
  styleContainer.axisXStyle = [PLTAxisStyle defaultStyle];
  styleContainer.axisYStyle = [PLTAxisStyle defaultStyle];
  styleContainer.chartStyle = [PLTLinearChartStyle defaultStyle];
  styleContainer.areaStyle = [PLTAreaStyle defaultStyle];
  return styleContainer;
}

+ (nonnull instancetype)math {
  PLTLinearStyleContainer *styleContainer = [PLTLinearStyleContainer createContainer];
  
  //Grid style:
  styleContainer.gridStyle.horizontalGridlineEnable = YES;
  styleContainer.gridStyle.horizontalLineColor = [UIColor lightGrayColor];
  styleContainer.gridStyle.verticalGridlineEnable = YES;
  styleContainer.gridStyle.verticalLineColor = [UIColor lightGrayColor];
  styleContainer.gridStyle.backgroundColor = [UIColor whiteColor];
  styleContainer.gridStyle.hasLabels = YES;
  styleContainer.gridStyle.horizontalLabelPosition = PLTGridLabelHorizontalPositionLeft;
  styleContainer.gridStyle.verticalLabelPosition = PLTGridLabelVerticalPositionBottom;
  styleContainer.gridStyle.labelFontColor = [UIColor blackColor];
  styleContainer.gridStyle.lineStyle = PLTLineStyleSolid;
  styleContainer.gridStyle.lineWeight = 1.0;
  //Axis X style:
  styleContainer.axisXStyle.hidden = NO;
  styleContainer.axisXStyle.hasArrow = YES;
  styleContainer.axisXStyle.hasName = YES;
  styleContainer.axisXStyle.hasMarks = YES;
  styleContainer.axisXStyle.isAutoformat = YES;
  styleContainer.axisXStyle.marksType = PLTMarksTypeCenter;
  styleContainer.axisXStyle.axisColor = [UIColor blackColor];
  styleContainer.axisXStyle.axisLineWeight = 1.0;
  //Axis Y style:
  styleContainer.axisYStyle = [styleContainer.axisXStyle copy];
  //Chart style:
  styleContainer.chartStyle.hasFilling = NO;
  styleContainer.chartStyle.hasMarkers = NO;
  styleContainer.chartStyle.chartLineColor = [UIColor blueColor];
  //TODO: Остальные параметры стиля графика. + что если линий несколько
  
  return styleContainer;
}

+ (nonnull instancetype)cobalt {
  PLTLinearStyleContainer *styleContainer = [PLTLinearStyleContainer createContainer];
  
  //Grid style:
  styleContainer.gridStyle.horizontalGridlineEnable = NO;
  styleContainer.gridStyle.verticalGridlineEnable = YES;
  styleContainer.gridStyle.verticalLineColor = RGBCOLOR(255.0, 191.0, 54.0);
  styleContainer.gridStyle.backgroundColor = RGBCOLOR(0.0, 34.0, 64.0);
  styleContainer.gridStyle.hasLabels = YES;
  styleContainer.gridStyle.horizontalLabelPosition = PLTGridLabelHorizontalPositionLeft;
  styleContainer.gridStyle.verticalLabelPosition = PLTGridLabelVerticalPositionBottom;
  styleContainer.gridStyle.labelFontColor = RGBCOLOR(256.0, 170.0, 28.0);
  styleContainer.gridStyle.lineStyle = PLTLineStyleDash;
  styleContainer.gridStyle.lineWeight = 1.0;
  //Axis X style:
  styleContainer.axisXStyle.hidden = NO;
  styleContainer.axisXStyle.hasArrow = NO;
  styleContainer.axisXStyle.hasName = YES;
  styleContainer.axisXStyle.hasMarks = NO;
  styleContainer.axisXStyle.isAutoformat = YES;
  styleContainer.axisXStyle.axisColor = RGBCOLOR(246.0, 170.0, 17.0);
  styleContainer.axisXStyle.axisLineWeight = 1.5;
  //Axis Y style:
  styleContainer.axisYStyle = [styleContainer.axisXStyle copy];
  //Area style:
  styleContainer.areaStyle.areaColor = styleContainer.gridStyle.backgroundColor;
  //Chart style:
  styleContainer.chartStyle.hasFilling = YES;
  styleContainer.chartStyle.hasMarkers = YES;
  styleContainer.chartStyle.chartLineColor = RGBCOLOR(58.0, 217.0, 0.0);
  
  return styleContainer;
}

/*
+ (nonnull PLTLinearStyleContainer*)basic {
  PLTLinearStyleContainer *styleContainer = [PLTLinearStyleContainer createContainer];
  return styleContainer;
}

+ (nonnull PLTLinearStyleContainer*)darcula {
  PLTLinearStyleContainer *styleContainer = [PLTLinearStyleContainer createContainer];
  return styleContainer;
}

+ (nonnull PLTLinearStyleContainer*)aqueduct {
  PLTLinearStyleContainer *styleContainer = [PLTLinearStyleContainer createContainer];
  return styleContainer;
}

+ (nonnull PLTLinearStyleContainer*)blackboardStyle {
  PLTLinearStyleContainer *styleContainer = [PLTLinearStyleContainer createContainer];
  return styleContainer;
}
*/
@end
