//
//  WMtweet.h
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 apple. All rights reserved.
//

@interface WMTweet : NSObject

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSArray *images;

@property (nonatomic, copy) NSString *sender;

@property (nonatomic, copy) NSArray *comments;

@property (nonatomic, copy) NSString *error;

@property (nonatomic, copy) NSString *unknowError;

+ (instancetype) tweetWithDict:(NSDictionary *)dict;

@end
