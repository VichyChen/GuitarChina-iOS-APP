//
//  GCPostThreadViewController.m
//  GuitarChina
//
//  Created by mac on 16/1/19.
//  Copyright © 2016年 陈大捷. All rights reserved.
//

#import "GCPostThreadViewController.h"

@interface GCPostThreadViewController () <UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;

@property (weak, nonatomic) IBOutlet UITextField *subjectTextField;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeHoldLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet UIView *pickerBackgroundView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UIButton *selectTypeCompleteButton;
- (IBAction)selectTypeAction:(UITapGestureRecognizer *)sender;
- (IBAction)selectedPickerViewCompleteAction:(UIButton *)sender;

@property (assign, nonatomic) NSInteger pickerViewSelectedIndex;
@property (copy, nonatomic) NSString *selectedType;

@end

@implementation GCPostThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureView];
    self.subjectTextField.placeholder = NSLocalizedString(@"Title (Required)", nil);
    self.typeLabel.text = NSLocalizedString(@"Select thread type.", nil);
    self.placeHoldLabel.text = NSLocalizedString(@"Write reply.", nil);
    self.typeLabel.textColor = [UIColor GCLightGrayFontColor];
    self.placeHoldLabel.textColor = [UIColor GCLightGrayFontColor];
    self.selectTypeCompleteButton.tintColor = [UIColor GCLightGrayFontColor];
    
    self.scrollViewHeight.constant = ScreenHeight - 64 + 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerBackgroundView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 240);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    return YES;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerBackgroundView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 240);
    }];
 
}

//- (void)textViewDidEndEditing:(UITextView *)textView {
//    if (self.messageTextView.text.length > 0) {
//        self.placeHoldLabel.hidden = YES;
//    } else {
//        self.placeHoldLabel.hidden = NO;
//    }
//}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.messageTextView.text.length > 0) {
        self.placeHoldLabel.hidden = YES;
    } else {
        self.placeHoldLabel.hidden = NO;
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.threadTypes allKeys].count;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self.threadTypes allValues] objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35;
}

#pragma mark - Private Methods

- (void)configureView {
    self.title = NSLocalizedString(@"Post Thread", nil);
    self.edgesForExtendedLayout = UIRectEdgeNone;

    UIBarButtonItem *rightBarItem = [UIView createBarButtonItem:NSLocalizedString(@"Send", nil) target:self action:@selector(sendAction)];
    rightBarItem.tintColor = [UIColor GCBlueColor];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

#pragma mark - Event Responses

- (void)sendAction {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    [[GCNetworkManager manager] postNewThreadWithFid:self.fid subject:self.subjectTextField.text message:self.messageTextView.text type:self.selectedType formhash:self.formhash Success:^(GCNewThreadModel *model) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)selectTypeAction:(UITapGestureRecognizer *)sender {
    [self.pickerView selectRow:self.pickerViewSelectedIndex inComponent:0 animated:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerBackgroundView.frame = CGRectMake(0, ScreenHeight - 240, ScreenWidth, 240);
    }];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (IBAction)selectedPickerViewCompleteAction:(UIButton *)sender {
    self.typeLabel.textColor = [UIColor GCDarkGrayFontColor];
    self.pickerViewSelectedIndex = [self.pickerView selectedRowInComponent:0];
    self.selectedType = [NSString stringWithFormat:@"%@", [[self.threadTypes allKeys] objectAtIndex:[self.pickerView selectedRowInComponent:0]]];
    self.typeLabel.text = [[self.threadTypes allValues] objectAtIndex:[self.pickerView selectedRowInComponent:0]];
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerBackgroundView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 240);
    }];
}
@end
