//
//  PLTAreaStyle.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 22.03.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PLTAreaStyle : NSObject

@property(nonatomic, strong, nonnull) UIColor *areaColor;

+ (nonnull PLTAreaStyle *)blank;
+ (nonnull PLTAreaStyle *)defaultStyle;

@end
