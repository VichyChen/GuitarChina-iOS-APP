//
//  GCNewPostThreadCell.h
//  GuitarChina
//
//  Created by mac on 17/1/31.
//  Copyright © 2017年 陈大捷. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, GCNewPostThreadCellStyle) {
    GCNewPostThreadCellStyleSegmentedControl    = 0,
    GCNewPostThreadCellStyleTextField           = 1,
    GCNewPostThreadCellStyleOnlyTextField       = 2,
    GCNewPostThreadCellStyleTextView            = 3,
    GCNewPostThreadCellStyleOnlyTextView        = 4,
    GCNewPostThreadCellStyleRadioButton         = 5,
    GCNewPostThreadCellStyleCheckButton         = 6,
    GCNewPostThreadCellStyleLabelArrow          = 7
};

@interface GCNewPostThreadCell : UITableViewCell

@property (nonatomic, strong) UIView *containView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, assign) GCNewPostThreadCellStyle cellStyle;

@property (nonatomic, copy) void(^textFieldValueChangeBlock)(UITextField *textField);
@property (nonatomic, copy) void(^textViewValueChangeBlock)(UITextView *textView);

+ (CGFloat)getCellHeightWithDictionary:(NSDictionary *)dictionary;

@end
