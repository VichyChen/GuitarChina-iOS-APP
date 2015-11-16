//
//  GCReplyThreadView.h
//  GuitarChina
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 陈大捷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCReplyThreadView : UIView

@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UIView *separatorLineView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placeholderLabel;

@end
