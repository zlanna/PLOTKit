//
//  PLTTableViewCell.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 17.07.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTTableViewCell.h"
#import "PLTTableViewCell.h"

@implementation PLTTableViewCell

@synthesize nameLabel = _nameLabel;
@synthesize descriptionLabel = _descriptionLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self){
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 15, 200, 17)];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.adjustsFontSizeToFitWidth = YES;
    
    _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 37, 200, 15)];
    _descriptionLabel.textColor = [UIColor lightGrayColor];
    _descriptionLabel.font = [UIFont systemFontOfSize:12];
    _descriptionLabel.adjustsFontSizeToFitWidth = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_descriptionLabel];
  }
  return self;
}

+ (CGFloat)cellHeight {
  return (CGFloat)57;
}

@end
