//
//  WMTweet.h
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMAFNetworkTool.h"

@class WMSender;

@interface WMTweet : NSObject

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSArray *images;

@property (nonatomic, copy) WMSender *sender;

@property (nonatomic, copy) NSArray *comments;

@property (nonatomic, copy) NSString *error;

@property (nonatomic, copy) NSString *unknowError;

+ (instancetype) tweetWithDict:(NSDictionary *)dict;

+ (void) userInfoWithIndex:(NSInteger)index isCache:(BOOL)cache expertID:(NSString *)ID getDataSuccess:(GetDataArraySuccessBlock)success getDataFailure:(GetDataFailureBlock)failure;

+ (void) tweetWithIndex:(NSInteger)index isCache:(BOOL)cache expertID:(NSString *)ID getDataSuccess:(GetDataSuccessBlock)success getDataFailure:(GetDataFailureBlock)failure;

+ (NSArray *)cacheWithExpertID:(NSString *)ID;
+ (NSArray *)cacheUser;

@end
