//
//  WMUser.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WMUser.h"
#import <YYModel.h>

@implementation WMUser

+ (instancetype)userWithDict:(NSDictionary *)dict {
    
    NSLog(@"dict=%@",dict);
    
    [WMUser modelCustomPropertyMapper];
    
    id obj = [[self alloc]init];
    
    obj = [WMUser yy_modelWithJSON:dict];
    
    return obj;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"profileimage" : @"profile-image"};
}

- (void)encodeWithCoder:(NSCoder *)aCoder{ [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }

@end
