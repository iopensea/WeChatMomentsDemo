//
//  WMSender.h
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMSender : NSObject

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nick;
@property (nonatomic, copy) NSString *username;

+ (instancetype) senderWithDict:(NSDictionary *)dict;

@end