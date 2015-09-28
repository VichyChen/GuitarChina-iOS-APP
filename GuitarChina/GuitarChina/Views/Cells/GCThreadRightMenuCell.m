//
//  GCThreadRightMenuCell.m
//  GuitarChina
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 陈大捷. All rights reserved.
//

#import "GCThreadRightMenuCell.h"

@interface GCThreadRightMenuCell()


@end

@implementation GCThreadRightMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configureView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"%.f", self.contentView.frame.size.width);
    self.iconImageView.frame = CGRectMake(self.contentView.frame.size.width / 2 - 70, 15, 20, 20);
    self.titleLabel.frame = CGRectMake(self.iconImageView.frame.origin.x + 40, 15, 120, 20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        [UIView animateWithDuration:0.3 animations:^{
            self.contentView.backgroundColor = [UIColor backgroundColor];
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.contentView.backgroundColor = [UIColor whiteColor];
        }];
    }
}

#pragma mark - Private Method

- (void)configureView {
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
}

#pragma mark - Getters

- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        _iconImageView = [UIView createImageView:CGRectZero
                                     contentMode:UIViewContentModeScaleAspectFit];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UIView createLabel:CGRectZero
                                     text:@""
                                     font:[UIFont systemFontOfSize:18]
                                textColor:[UIColor FontColor]];
    }
    return _titleLabel;
}


@end
