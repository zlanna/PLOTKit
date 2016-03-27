//
//  PLTColorSheme.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 27.03.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PLTColorSheme : NSObject

@property(nonatomic, strong) UIColor *gridVerticalLineColor;
@property(nonatomic, strong) UIColor *gridHorizontalLineColor;
@property(nonatomic, strong) UIColor *gridBackgroundColor;
@property(nonatomic, strong) UIColor *gridLabelFontColor;

//TODO: Add axis colors shenmes

@property(nonatomic, strong) UIColor *chartLineColor;

+ (PLTColorSheme *)plain;
+ (PLTColorSheme *)cobalt;

@end
