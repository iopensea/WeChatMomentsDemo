//
//  WMtweet.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WMUser.h"
#import "WMtweet.h"
#import "WMImage.h"
#import "WMComment.h"

#import <YYModel.h>

@implementation WMTweet

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{
             @"images" : [WMImage class],
             @"comments" : [WMComment class]
//             ,@"senders" : @"sender"
             };

//    return @{
//             @"images" : [WMImage class],
//             @"sender" : [WMSender class],
//             @"comments" : [WMComment class],
//             @"senders" : @"sender"
//             };
}

+ (instancetype) tweetWithDict:(NSDictionary *)dict {
    
    id obj = [[self alloc]init];
    
    obj = [WMTweet yy_modelWithJSON:dict];

    return obj;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }

- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}

- (NSUInteger)hash {
    return [self yy_modelHash];
}

- (BOOL)isEqual:(id)object {
    return [self yy_modelIsEqual:object];
}

static NSString * userPath = @"user/jsmith/";

static NSString * tweetPath = @"user/jsmith/tweets";


+ (void) userInfoWithIndex:(NSInteger)index isCache:(BOOL)cache expertID:(NSString *)ID getDataSuccess:(GetDataArraySuccessBlock)success getDataFailure:(GetDataFailureBlock)failure {
    
    NSString *userUrl = [NSString stringWithString:userPath];
    
    [WMAFNetworkTool GetJson:userUrl GetDataType:WMGetDATATypeBaseURL progress:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         
                         NSArray *dictArr = @[responseObject];
                         NSLog(@"user responseObject=%@",responseObject);
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

+ (void) tweetWithIndex:(NSInteger)index isCache:(BOOL)cache expertID:(NSString *)ID getDataSuccess:(GetDataSuccessBlock)success getDataFailure:(GetDataFailureBlock)failure {
    
    NSString *userUrl = [NSString stringWithString:tweetPath];
    
    [WMAFNetworkTool GetJson:userUrl GetDataType:WMGetDATATypeBaseURL progress:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         
                         NSArray *dictArr = responseObject;
//                         NSLog(@"[responseObject]=%@",dictArr);
                         NSLog(@"tweet responseObject=%@",responseObject);
                         NSLog(@"dictArr.count=%ld",dictArr.count);
                         NSMutableArray *arrMutableMoment = [NSMutableArray arrayWithCapacity:dictArr.count];
                         
                         for (NSDictionary *dict in dictArr) {
                             WMTweet *tweet = [WMTweet tweetWithDict:dict];
                             [arrMutableMoment addObject:tweet];
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
