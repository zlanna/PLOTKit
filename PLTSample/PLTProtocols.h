//
//  PLTProtocols.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 16.04.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#pragma once

@protocol PLTStyleContainer <NSObject>

@end

@class PLTGridStyle;
@class PLTAxisStyle;
@class PLTLinearChartStyle;
@class PLTAreaStyle;
@class PLTLinearStyleContainer;

@protocol PLTLinearStyleContainer <PLTStyleContainer>

- (nullable PLTGridStyle *)gridStyle;
- (nullable PLTAxisStyle *)axisXStyle;
- (nullable PLTAxisStyle *)axisYStyle;
- (nullable PLTLinearChartStyle *)chartStyle;
- (nullable PLTAreaStyle *)areaStyle;
+ (nonnull PLTLinearStyleContainer<PLTLinearStyleContainer> *)blank;

@end

@protocol PLTStyleSource <NSObject>

- (nullable id<PLTLinearStyleContainer>)styleContainer;

@end
