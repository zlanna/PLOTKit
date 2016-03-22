//
//  PLTGrid.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PLTGridViewDelegate <NSObject>

- (CGRect) gridViewFrame;

@end


@class PLTGridStyle;

@interface PLTGridView : UIView

@property(nonatomic, weak) id<PLTGridViewDelegate> delegate;

- (nonnull instancetype)initWithStyle:(nonnull PLTGridStyle *) gridStyle;

@end
