//
//  PLTAxisXStyle.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 08.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAxisStyle.h"

typedef NS_ENUM(NSUInteger, PLTAxisXLabelPosition) {
  PLTAxisXLabelPositionNone,
  PLTAxisXLabelPositionBottom,
  PLTAxisXLabelPositionTop
};

@class PLTAxisYStyle;

@interface PLTAxisXStyle : PLTAxisStyle

@property(nonatomic) PLTAxisXLabelPosition labelPosition;

- (PLTAxisYStyle *)copyToY;
+ (PLTAxisXStyle *)blank;

@end
