//
//  WMImage.h
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMImage : NSObject

@property (nonatomic, copy) NSString *url;

+ (instancetype) imageUrlWithDict:(NSDictionary *)dict;

@end