//
//  WMMoment.h
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WMAFNetworkTool.h"

@class WMUser;
@class WMTweet;
@class WMComment;

@interface WMMoment : NSObject

@property (nonatomic, strong) WMUser *wmUser;
@property (nonatomic, strong) WMTweet *wmTweet;
@property (nonatomic, strong) WMComment *wmComment;

+ (void)userInfoWithIndex:(NSInteger)index isCache:(BOOL)cache expertID:(NSString *)ID getDataSuccess:(GetDataArraySuccessBlock)success getDataFailure:(GetDataFailureBlock)failure;

+ (void) tweetWithIndex:(NSInteger)index isCache:(BOOL)cache expertID:(NSString *)ID getDataSuccess:(GetDataArraySuccessBlock)success getDataFailure:(GetDataFailureBlock)failure;

+ (instancetype) momentWithDict:(NSDictionary *)dict;


+ (NSArray *)cacheWithExpertID:(NSString *)ID;
+ (NSArray *)cacheUser;

@end
