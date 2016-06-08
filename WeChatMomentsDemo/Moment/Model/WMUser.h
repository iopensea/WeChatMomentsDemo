//
//  WMUser.h
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 apple. All rights reserved.
//

@interface WMUser : NSObject

@property (nonatomic, copy) NSString *profileimage;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *username;


+ (instancetype)userWithDict:(NSDictionary *)dict;

@end
