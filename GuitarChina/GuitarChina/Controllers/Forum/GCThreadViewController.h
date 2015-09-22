//
//  GCThreadViewController.h
//  GuitarChina
//
//  Created by 陈大捷 on 15/9/4.
//  Copyright (c) 2015年 陈大捷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCBaseTableViewController.h"

@interface GCThreadViewController : GCBaseTableViewController

@property (nonatomic, copy) NSString *tid;

@property (nonatomic, strong) GCForumThreadModel *forumThreadModel;

@property (nonatomic, strong) GCHotThreadModel *hotThreadModel;

@end
