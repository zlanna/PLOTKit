//
//  PLTAxisYStyle.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 08.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAxisStyle.h"

typedef NS_ENUM(NSUInteger, PLTAxisYLabelPosition) {
  PLTAxisYLabelPositionNone,
  PLTAxisYLabelPositionLeft,
  PLTAxisYLabelPositionRight
};

@class PLTAxisXStyle;

@interface PLTAxisYStyle : PLTAxisStyle

@property(nonatomic) PLTAxisYLabelPosition labelPosition;

- (PLTAxisXStyle *)copyToX;
+ (PLTAxisYStyle *)blank;

@end
