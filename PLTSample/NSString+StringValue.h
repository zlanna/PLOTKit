//
//  NSString+StringValue.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 18.06.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;

@interface NSString (StringValue)<PLTStringValue>

- (nonnull NSString *)stringValue;

@end
