//
//  PLTArea.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLTAreaStyle;

@interface PLTAreaView : UIView

@property(nonatomic, strong, nonnull) PLTAreaStyle *style;

@end