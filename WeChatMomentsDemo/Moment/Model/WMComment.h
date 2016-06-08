//
//  WMComment.h
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 apple. All rights reserved.
//

@interface WMComment : NSObject

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *avater;

+ (instancetype) commentWithDict:(NSDictionary *)dict;

@end
