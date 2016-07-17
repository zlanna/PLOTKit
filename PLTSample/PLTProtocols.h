//
//  PLTProtocols.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 16.04.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#pragma once

@class PLTChartData;

#pragma mark - Data Sources

@protocol PLTLinearChartDataSource <NSObject>
- (nonnull PLTChartData *)dataForLinearChart;
@end

@protocol PLTScatterChartDataSource <NSObject>
- (nonnull PLTChartData *)dataForScatterChart;
@end

@protocol PLTBarChartDataSource <NSObject>
- (nonnull PLTChartData *)dataForBarChart;
@end

#pragma mark - Style containers

@class PLTGridStyle;
@class PLTAxisXStyle;
@class PLTAxisYStyle;
@class PLTAreaStyle;
@class PLTLinearStyleContainer;

@protocol PLTStyleContainer <NSObject>
- (nullable PLTGridStyle *)gridStyle;
- (nullable PLTAxisXStyle *)axisXStyle;
- (nullable PLTAxisYStyle *)axisYStyle;
- (nullable PLTAreaStyle *)areaStyle;
+ (nonnull PLTLinearStyleContainer<PLTStyleContainer> *)blank;
@end

@class PLTLinearChartStyle;

@protocol PLTLinearStyleContainer <PLTStyleContainer>
- (nullable PLTLinearChartStyle *)chartStyle;
- (nonnull PLTLinearChartStyle *)chartStyleForSeries:(nullable NSString *)seriesName;
- (void)injectChartStyle:(nonnull PLTLinearChartStyle *)chartStyle forSeries:(nonnull NSString *)seriesName;

@end

@class PLTScatterChartStyle;

@protocol PLTScatterStyleContainer <PLTStyleContainer>
- (nullable PLTScatterChartStyle *)chartStyle;
- (nonnull PLTScatterChartStyle *)chartStyleForSeries:(nullable NSString *)seriesName;
- (void)injectChartStyle:(nonnull PLTScatterChartStyle *)chartStyle forSeries:(nonnull NSString *)seriesName;
@end

@class PLTBarChartStyle;

@protocol PLTBarStyleContainer <PLTStyleContainer>
- (nullable PLTBarChartStyle *)chartStyle;
- (nonnull PLTBarChartStyle *)chartStyleForSeries:(nullable NSString *)seriesName;
- (void)injectChartStyle:(nonnull PLTBarChartStyle *)chartStyle forSeries:(nonnull NSString *)seriesName;
@end

#pragma mark - Data Sources

@protocol PLTStyleSource<NSObject>
- (nullable id<PLTStyleContainer>)styleContainer;
@end

@protocol PLTLinearStyleSource<NSObject>
- (nullable id<PLTLinearStyleContainer>)styleContainer;
@end

@protocol PLTScatterStyleSource<NSObject>
- (nullable id<PLTScatterStyleContainer>)styleContainer;
@end

@protocol PLTBarStyleSource<NSObject>
- (nullable id<PLTBarStyleContainer>)styleContainer;
@end

#pragma mark - Internal data sources

@protocol PLTInternalLinearChartDataSource<NSObject>
- (nullable NSDictionary<NSString *, NSArray<NSNumber *> *> *)chartDataSetForSeries:(nullable NSString *)seriesName;
- (nullable NSArray<NSNumber *> *)xDataSet;
- (nullable NSArray<NSNumber *> *)yDataSet;
- (NSUInteger)axisXMarksCount;
- (NSUInteger)axisYMarksCount;
@end

@protocol PLTInternalBarChartDataSource<PLTInternalLinearChartDataSource>
- (NSUInteger)seriesIndex:(nonnull NSString*)seriesName;
- (NSUInteger)seriesCount;
@end

#pragma mark - View constriction

@protocol PLTViewConstriction<NSObject>

- (void)addConstriction:(CGFloat)constriction;

@end

#pragma mark - String value

@protocol PLTStringValue<NSObject>
- (nullable NSString *)stringValue;
@end

#pragma mark - Autolayout

@protocol PLTAutolayoutWidth<NSObject>
- (CGFloat)viewRequaredWidth;
@end

@protocol PLTAutolayoutHeight<NSObject>
- (CGFloat)viewRequaredHeight;
@end
