//
//  PLTAreaStyle.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 22.03.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface PLTAreaStyle : NSObject

@property(nonatomic, strong, nonnull) UIColor *areaColor;

- (null_unspecified instancetype)init NS_UNAVAILABLE;

+ (nonnull instancetype)blank;

@end
