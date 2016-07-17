//
//  PLTTableViewCell.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 17.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import UIKit;

@interface PLTTableViewCell : UITableViewCell

@property (nonatomic, strong, nonnull) UILabel *nameLabel;
@property (nonatomic, strong, nonnull) UILabel *descriptionLabel;

+ (CGFloat)cellHeight;

@end
