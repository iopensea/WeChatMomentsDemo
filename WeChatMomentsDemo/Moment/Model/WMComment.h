//
//  WMComment.h
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WMSender;

@interface WMComment : NSObject

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) WMSender *sender;

+ (instancetype) commentWithDict:(NSDictionary *)dict;

@end