//
//  GCAboutCell.m
//  GuitarChina
//
//  Created by mac on 15/11/13.
//  Copyright © 2015年 陈大捷. All rights reserved.
//

#import "GCAboutCell.h"

@interface GCAboutCell()

@property (nonatomic, strong) UIView *separatorViewBottom;

@end

@implementation GCAboutCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = [GCColor cellSelectedColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self configureView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.leftImageView.frame = CGRectMake(15, 12, 20, 20);
    self.titleLabel.frame = CGRectMake(15, 0, ScreenWidth - 80, 44);
    self.separatorViewBottom.frame = CGRectMake(13, 43.5, ScreenWidth - 13, 0.5);
}

- (void)configureView {
//    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.separatorViewBottom];
}

#pragma mark - Getters

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [UIView createImageView:CGRectZero
                                     contentMode:UIViewContentModeScaleAspectFill];
    }
    return _leftImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UIView createLabel:CGRectZero
                                     text:@"陈大捷"
                                     font:[UIFont systemFontOfSize:16]
                                textColor:[GCColor fontColor]];
    }
    return _titleLabel;
}

- (UIView *)separatorViewBottom {
    if (!_separatorViewBottom) {
        _separatorViewBottom = [[UIView alloc] initWithFrame:CGRectZero];
        _separatorViewBottom.backgroundColor = [GCColor separatorLineColor];
    }
    return _separatorViewBottom;
}

@end
