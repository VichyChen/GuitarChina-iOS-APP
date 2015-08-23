//
//  GCBaseModel.m
//  GuitarChina
//
//  Created by 陈大捷 on 15/8/23.
//  Copyright (c) 2015年 陈大捷. All rights reserved.
//

#import "GCBaseModel.h"

@implementation GCBaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.cookiepre       = [dictionary objectForKey:@"cookiepre"];
        self.auth            = [dictionary objectForKey:@"auth"];
        self.saltkey         = [dictionary objectForKey:@"saltkey"];
        self.member_uid      = [dictionary objectForKey:@"member_uid"];
        self.member_username = [dictionary objectForKey:@"member_username"];
        self.member_avatar   = [dictionary objectForKey:@"member_avatar"];
        self.groupid         = [dictionary objectForKey:@"groupid"];
        self.formhash        = [dictionary objectForKey:@"formhash"];
        self.ismoderator     = [dictionary objectForKey:@"ismoderator"];
        self.readaccess      = [dictionary objectForKey:@"readaccess"];
        
        NSDictionary *notice = [dictionary objectForKey:@"notice"];
        GCBaseNoticeModel *noticeModel = [[GCBaseNoticeModel alloc] init];
        noticeModel.newpush   = [notice objectForKey:@"newpush"];
        noticeModel.newpm     = [notice objectForKey:@"newpm"];
        noticeModel.newprompt = [notice objectForKey:@"newprompt"];
        noticeModel.newmypost = [notice objectForKey:@"newmypost"];
        self.notice = noticeModel;
    }
    return self;
}
@end