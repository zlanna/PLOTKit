//
//  PLTLegendStyle.h
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 19.07.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLTLegendStyle : NSObject

@property(nonatomic, strong, nonnull) UIFont *legendFont;

@property(nonatomic, strong, nonnull) UIColor *labelColorForNormalState;
@property(nonatomic, strong, nonnull) UIColor *labelColorForSelectedState;
@property(nonatomic, strong, nonnull) UIColor *labelColorForHighlightedState;

@property(nonatomic, strong, nonnull) UIColor *titleColorForNormalState;
@property(nonatomic, strong, nonnull) UIColor *titleColorForSelectedState;
@property(nonatomic, strong, nonnull) UIColor *titleColorForHighlightedState;

+ (nonnull instancetype)blank;

@end
