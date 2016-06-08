//
//  WMtweet.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WMtweet.h"
#import <YYModel.h>

@implementation WMTweet

+ (instancetype) tweetWithDict:(NSDictionary *)dict {
    
    id obj = [[self alloc]init];
    
    obj = [WMTweet yy_modelWithJSON:dict];

    return obj;
}

@end

