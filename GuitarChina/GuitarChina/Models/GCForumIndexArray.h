//
//  GCForumIndexArray.h
//  GuitarChina
//
//  Created by 陈大捷 on 15/8/22.
//  Copyright (c) 2015年 陈大捷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCForumIndexNoticeModel : NSObject

@property (nonatomic, copy) NSString *newpush;
@property (nonatomic, copy) NSString *newpm;
@property (nonatomic, copy) NSString *newprompt;
@property (nonatomic, copy) NSString *newmypost;

@end

@interface GCForumIndexGroupModel : NSObject

@end

@interface GCForumGroupModel : NSObject

@property (nonatomic, copy) NSString *fid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *forums;  //GCForumModel

@end

@interface GCForumModel : NSObject

@property (nonatomic, copy) NSString *fid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *threads;
@property (nonatomic, copy) NSString *posts;
@property (nonatomic, copy) NSString *todayposts;
@property (nonatomic, copy) NSString *descript;

@end

@interface GCForumIndexArray : NSObject

@property (nonatomic, copy) NSString *cookiepre;
@property (nonatomic, copy) NSString *auth;
@property (nonatomic, copy) NSString *saltkey;
@property (nonatomic, copy) NSString *member_uid;
@property (nonatomic, copy) NSString *member_username;
@property (nonatomic, copy) NSString *member_avatar;
@property (nonatomic, copy) NSString *groupid;
@property (nonatomic, copy) NSString *formhash;
@property (nonatomic, copy) NSString *ismoderator;
@property (nonatomic, copy) NSString *readaccess;
@property (nonatomic, copy) NSString *member_email;
@property (nonatomic, copy) NSString *member_credits;
@property (nonatomic, copy) NSString *setting_bbclosed;

@property (nonatomic, strong) GCForumIndexNoticeModel *notice;
@property (nonatomic, strong) GCForumIndexGroupModel *group;
@property (nonatomic, strong) NSArray *data;    //GCForumGroupModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end