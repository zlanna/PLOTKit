//
//  Number+CGFloat.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 04.04.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "NSNumber+CGFloat.h"


@implementation NSNumber (CGFloat)

- (CGFloat)plt_CGFloatValue{
#if (CGFLOAT_IS_DOUBLE == 1)
  CGFloat result = [self doubleValue];
#else
  CGFloat result = [self floatValue];

#endif
  return result;
}

@end
