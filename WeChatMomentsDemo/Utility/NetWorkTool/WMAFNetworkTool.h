//
//  WMAFNetworkTool.h
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <Foundation/Foundation.h>

typedef enum {
    WMGetDATATypeBaseURL, // via BaseURL get data
    WMGetDATATypeUserURL, // via UserURL get data
    WMGetDATATypeTweetURL  //via tweetURL get data
} WMGetDATAType;


typedef void(^progressBlock)(NSProgress *downloadProgress);
typedef void(^successBlock)(NSURLSessionDataTask * task, id responseObject);
typedef void(^failureBlock)(NSURLSessionDataTask * task, NSError *error);

typedef void(^GetDataArraySuccessBlock)(NSArray *dataArr);
typedef void(^GetDataFailureBlock)(NSError *error);

typedef void(^GetDataDictSuccessBlock)(NSDictionary *dataDict);
typedef void(^GetDataSuccessBlock)(id obj);

//success
typedef void (^requestSuccessBlock)(NSURLSessionDataTask * task, id responseObject);

//failure block
typedef void (^requestFailureBlock)(NSURLSessionDataTask * task, NSError *error);

//define request renum
typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
} HTTPMethod;

@interface WMAFNetworkTool : AFHTTPSessionManager

+ (instancetype)sharedGetDataTool;

+ (NSURLSessionDataTask *)GetJson:(NSString *)urlStr GetDataType:(WMGetDATAType)type progress:(progressBlock)progress success:(successBlock)success failure: (failureBlock)failure;

@end

