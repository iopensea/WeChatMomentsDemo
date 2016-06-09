//
//  WMComment.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/9.
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

@end
