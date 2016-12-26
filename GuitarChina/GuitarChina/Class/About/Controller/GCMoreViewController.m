//
//  GCMoreViewController.m
//  GuitarChina
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 陈大捷. All rights reserved.
//

#import "GCMoreViewController.h"
#import "GCMoreCell.h"
#import "GCThreadDetailViewController.h"
#import "GCLoginViewController.h"
#import "GCSettingViewController.h"
#import "GCMyThreadViewController.h"
#import "GCMyFavThreadViewController.h"

@interface GCMoreViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GCTableViewKit *tableViewKit;

@property (nonatomic, strong) NSArray *array;

@end

@implementation GCMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"More", nil);
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    [self configureView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Private Methods

- (void)configureView {
    [self.view addSubview:self.tableView];
}

#pragma mark - Event Responses

- (void)loginAction {
    if (![[NSUD stringForKey:kGCLogin] isEqualToString:@"1"]) {
        GCLoginViewController *loginViewController = [[GCLoginViewController alloc] initWithNibName:@"GCLoginViewController" bundle:nil];
        @weakify(self);
        loginViewController.loginSuccessBlock = ^{
            @strongify(self);
            [self.tableView reloadData];
        };
        GCNavigationController *navigationController = [[GCNavigationController alloc] initWithRootViewController:loginViewController];
        [self presentViewController:navigationController animated:YES completion:nil];
    }
}

#pragma mark - Getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [GCColor backgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.tableViewKit = [[GCTableViewKit alloc] initWithSystem];
        @weakify(self);
        self.tableViewKit.numberOfSectionsInTableViewBlock = ^{
            @strongify(self);
            return (NSInteger)self.array.count;
        };
        self.tableViewKit.numberOfRowsInSectionBlock = ^(NSInteger section) {
            @strongify(self);
            NSDictionary *dictionary = self.array[section];
            NSArray *array = dictionary[[dictionary allKeys][0]];
            return (NSInteger)array.count;
        };
        self.tableViewKit.cellForRowAtIndexPathBlock = ^(NSIndexPath *indexPath) {
            @strongify(self);
            NSArray *array = self.array[indexPath.section][[self.array[indexPath.section] allKeys][0]];
            NSDictionary *dictionary = [array objectAtIndex:indexPath.row];
            
            GCMoreCell *cell = [[GCMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.titleLabel.text = [dictionary objectForKey:@"title"];
            
            NSNumber *enable = [dictionary objectForKey:@"enable"];
            if ([enable boolValue]) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return cell;
        };
        self.tableViewKit.heightForRowAtIndexPathBlock = ^(NSIndexPath *indexPath) {
            return 44.0;
        };
        self.tableViewKit.viewForHeaderInSectionBlock = ^(NSInteger section) {
            @strongify(self);
            if (section == 0) {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
                view.backgroundColor = [UIColor whiteColor];
                
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
                imageView.clipsToBounds = YES;
                imageView.layer.cornerRadius = 8;
                [view addSubview:imageView];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(80, 30, 200, 20);
                button.enabled = NO;
                button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [button setTitleColor:[GCColor fontColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:button];
                if ([[NSUD stringForKey:kGCLogin] isEqualToString:@"1"]) {
                    [button setTitle:[NSUD stringForKey:kGCLoginName] forState:UIControlStateNormal];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:GCNetworkAPI_URL_BigAvtarImage([NSUD stringForKey:kGCLoginID])]];
                    button.titleLabel.font = [UIFont systemFontOfSize:16];
                } else {
                    [button setTitle:@"未登录" forState:UIControlStateNormal];
                    button.titleLabel.font = [UIFont systemFontOfSize:15];
                    //
                }
                
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 79.5, ScreenWidth, 0.5)];
                line.backgroundColor = [GCColor separatorLineColor];
                [view addSubview:line];
                
                @weakify(self);
                [view bk_whenTapped:^{
                    @strongify(self);
                    [self loginAction];
                }];
                
                return view;
            } else {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
                view.backgroundColor = [GCColor backgroundColor];
                UILabel *label = [UIView createLabel:CGRectMake(15, 0, 200, 40)
                                                text:@""
                                                font:[UIFont systemFontOfSize:16]
                                           textColor:[GCColor blueColor]];
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, ScreenWidth, 0.5)];
                line.backgroundColor = [GCColor separatorLineColor];
                [view addSubview:label];
                [view addSubview:line];
                
                NSDictionary *dictionary = self.array[section];
                label.text = [dictionary allKeys][0];
                
                return view;
            }
        };
        self.tableViewKit.heightForHeaderInSectionBlock = ^(NSInteger section) {
            if (section == 0) {
                return 80.0;
            } else {
                return 40.0;
            }
        };
        self.tableViewKit.viewForFooterInSectionBlock = ^(NSInteger section) {
            return [[UIView alloc] init];
        };
        self.tableViewKit.heightForFooterInSectionBlock = ^(NSInteger section) {
            return 0.01;
        };
        self.tableViewKit.didSelectRowAtIndexPathBlock = ^(NSIndexPath *indexPath) {
            @strongify(self);
            switch (indexPath.section) {
                case 0:
                    switch (indexPath.row) {
                        case 0://我的主题
                        {
                            if ([[NSUD stringForKey:kGCLogin] isEqualToString:@"1"]) {
                                GCMyThreadViewController *userThreadViewController = [[GCMyThreadViewController alloc] init];
                                [self.navigationController pushViewController:userThreadViewController animated:YES];
                            } else {
                                [self loginAction];
                            }
                            break;
                        }
                        case 1://我的收藏
                        {
                            if ([[NSUD stringForKey:kGCLogin] isEqualToString:@"1"]) {
                                GCMyFavThreadViewController *myFavThreadViewController = [[GCMyFavThreadViewController alloc] init];
                                [self.navigationController pushViewController:myFavThreadViewController animated:YES];
                            } else {
                                [self loginAction];
                            }
                            break;
                        }
                    }
                    break;
                    
                case 1:
                    switch (indexPath.row) {
                        case 0://开发信息
                        {
                            GCThreadDetailViewController *controller = [[GCThreadDetailViewController alloc] init];
                            controller.tid = @"2036691";
                            [self.navigationController pushViewController:controller animated:YES];
                            
                            break;
                        }
                        case 1://意见反馈
                        {
                            GCThreadDetailViewController *controller = [[GCThreadDetailViewController alloc] init];
                            controller.tid = @"2036853";
                            [self.navigationController pushViewController:controller animated:YES];
                            
                            break;
                        }
                        case 2://评分
                        {
                            [Util openScorePageInAppStore:AppleID];
                            
                            break;
                        }
                        case 3:
                        {
                            GCSettingViewController *userOtherViewController = [[GCSettingViewController alloc] init];
                            [self.navigationController pushViewController:userOtherViewController animated:YES];
                            
                            break;
                        }
                    }
                    break;
            }
        };
        [self.tableViewKit configureTableView:_tableView];
    }
    return _tableView;
}

- (NSArray *)array {
    if (!_array) {
        NSDictionary *myTheme = @{@"title" : NSLocalizedString(@"My Theme", nil), @"enable" : @YES };
        NSDictionary *myFavour = @{@"title" : NSLocalizedString(@"My Favour", nil), @"enable" : @YES };
        
        NSDictionary *developer = @{@"title" : NSLocalizedString(@"Information Development", nil), @"enable" : @YES };
        NSDictionary *feedback = @{@"title" : NSLocalizedString(@"Feedback", nil), @"enable" : @YES };
        NSDictionary *score = @{@"title" : NSLocalizedString(@"To Score", nil), @"enable" : @YES };
        NSDictionary *setting = @{@"title" : NSLocalizedString(@"Setting", nil), @"enable" : @YES };
        
        NSDictionary *meDictionary = @{NSLocalizedString(@"Me", nil) : @[myTheme, myFavour] };
        NSDictionary *othersDictionary = @{ NSLocalizedString(@"Others", nil) : @[developer, feedback, score, setting] };
        
        _array = @[meDictionary, othersDictionary];
    }
    
    return _array;
}

@end
