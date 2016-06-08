//
//  WMMoment.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WMMoment.h"
#import "WMUser.h"
#import "WMTweet.h"
#import <YYModel.h>

@implementation WMMoment

static NSString * userPath = @"user/jsmith/";

static NSString * tweetPath = @"user/jsmith/tweets";


+ (void) userInfoWithIndex:(NSInteger)index isCache:(BOOL)cache expertID:(NSString *)ID getDataSuccess:(GetDataArraySuccessBlock)success getDataFailure:(GetDataFailureBlock)failure {
    
    NSString *userUrl = [NSString stringWithString:userPath];
    
    [WMAFNetworkTool GetJson:userUrl GetDataType:WMGetDATATypeBaseURL progress:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         
                         NSArray *dictArr = @[responseObject];
                         
                         NSLog(@"responseObject=%@",responseObject);
                         
                         NSMutableArray *arrMutableUser = [NSMutableArray arrayWithCapacity:dictArr.count];
                         
                         for (NSDictionary *dict in dictArr) {
                             
                             WMUser *user = [WMUser userWithDict:dict];
                             [arrMutableUser addObject:user];
                         }
                         
                         if(cache && arrMutableUser.count > 0){
                             
                             NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
                             filePath  = [filePath stringByAppendingFormat:@"/%@.data",ID];
                             [NSKeyedArchiver archiveRootObject:arrMutableUser toFile:filePath];
                         }
                         
                         success(arrMutableUser.copy);
                     }
     
                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                         failure(error);
                     }];
}

+ (void) tweetWithIndex:(NSInteger)index isCache:(BOOL)cache expertID:(NSString *)ID getDataSuccess:(GetDataArraySuccessBlock)success getDataFailure:(GetDataFailureBlock)failure {
    
    NSString *userUrl = [NSString stringWithString:tweetPath];
    
    [WMAFNetworkTool GetJson:userUrl GetDataType:WMGetDATATypeBaseURL progress:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {

                         NSArray *dictArr = responseObject[@"data"];
                         
                         NSMutableArray *arrMutableMoment = [NSMutableArray arrayWithCapacity:dictArr.count];
                         
                         for (NSDictionary *dict in dictArr) {
                             
                             WMMoment *moment = [WMMoment momentWithDict:dict];
                             [arrMutableMoment addObject:moment];
                         }
                         
                         if(cache && arrMutableMoment.count>0){
                             
                             NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
                             filePath  = [filePath stringByAppendingFormat:@"/%@.data",ID];
                             [NSKeyedArchiver archiveRootObject:arrMutableMoment toFile:filePath];
                             
                         }
                         
                         success(arrMutableMoment.copy);
                     }
     
                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                         failure(error);
                     }];
    
}

+ (instancetype)momentWithDict:(NSDictionary *)dict {
    
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

+ (NSArray *)cacheWithExpertID:(NSString *)ID{
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    filePath  = [filePath stringByAppendingFormat:@"/%@.data",ID];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

+ (NSArray *)cacheUser{
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    filePath  = [filePath stringByAppendingPathComponent:@"User.data"];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

@end
