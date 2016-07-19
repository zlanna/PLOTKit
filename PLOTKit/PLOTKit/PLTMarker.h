//
//  PLTMarker.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSUInteger, PLTMarkerType) {
  PLTMarkerCircle,
  PLTMarkerSquare,
  PLTMarkerTriangle,
  PLTMarkerCross
};

@interface PLTMarker : NSObject

@property(nonnull, nonatomic, strong) UIColor *color;
@property(nonatomic) CGFloat size;
@property(nonnull, nonatomic, readonly, strong) UIImage *markerImage;

- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)markerWithType:(PLTMarkerType) markerType;

@end

NSString *_Nonnull pltStringFromMarkerType(PLTMarkerType markerType);
