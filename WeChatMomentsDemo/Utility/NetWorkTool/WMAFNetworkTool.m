//
//  WMAFNetworkTool.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WMAFNetworkTool.h"

static NSString const * baseURL = @"http://thoughtworks-ios.herokuapp.com/";
static NSString const * userURL = @"http://thoughtworks-ios.herokuapp.com/user/jsmith/";
static NSString const * tweetURL = @"http://thoughtworks-ios.herokuapp.com/user/jsmith/tweets/";

@implementation WMAFNetworkTool

static id _instance;

#pragma mark - shared AFHTTPSessionManager method
+ (instancetype)sharedGetDataTool{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

#pragma mark - get Json
+ (NSURLSessionDataTask *)GetJson:(NSString *)urlStr progress:(progressBlock)progress success:(successBlock)success failure: (failureBlock)failure{
    
    WMAFNetworkTool *tool = [self sharedGetDataTool];
    
//    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //设置json解析的可以接收的服务器返回类型(Content-Type)
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    NSSet *set = [NSSet setWithArray:@[@"text/html", @"application/json",@"*/*"]];
    response.acceptableContentTypes = set;
    tool.responseSerializer = response;
    
    return [tool GET:urlStr parameters:nil progress:progress success:success failure:failure];
    
}

+ (NSURLSessionDataTask *)GetJson:(NSString *)urlStr GetDataType:(WMGetDATAType)type progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure{
    
    //判断字符串是否合法
    if([urlStr characterAtIndex:0] == '/') urlStr = [urlStr substringFromIndex:1];
    
    if (type == WMGetDATATypeBaseURL) {
        
        urlStr = [NSString stringWithFormat:@"%@%@",baseURL ,urlStr];
    } else if (type == WMGetDATATypeUserURL){
        
        urlStr = [NSString stringWithFormat:@"%@%@", userURL, urlStr];
    } else if (type == WMGetDATATypeTweetURL){
        
        urlStr = [NSString stringWithFormat:@"%@%@", tweetURL, urlStr];
    }
    
    return [self GetJson:urlStr progress:progress success:success failure:failure];
}


//// 设置请求路径
//NSURL *url = [NSURL URLWithString:userURL];
//// 创建请求对象
//NSURLRequest *reuqest = [[NSURLRequest alloc] initWithURL:url];
//
//// 用NSURLConnection发送异步GET请求
//[NSURLConnection sendAsynchronousRequest:reuqest queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError)
// {
//     // 解析JSON
//     NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//     NSLog(@"%@", dict);
// }];

//NSArray *modelArray = [模型类名 objectArrayWithKeyValuesArray:字段数组];

@end