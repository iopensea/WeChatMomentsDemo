//
//  WMComment.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WMComment.h"
#import <YYModel.h>

@implementation WMComment

+ (instancetype) commentWithDict:(NSDictionary *)dict {
    
    id obj = [[self alloc]init];
    
    obj = [WMComment yy_modelWithJSON:dict];
    
    return obj;
}

@end
