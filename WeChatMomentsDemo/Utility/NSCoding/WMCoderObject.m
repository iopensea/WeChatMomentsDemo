//
//  WMCoderObject.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WMCoderObject.h"

#import <objc/runtime.h>

@implementation WMCoderObject

// 归档
- (void)encodeWithCoder:(NSCoder*)encoder
{
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char* name = ivar_getName(ivar);
        NSString* strName = [NSString stringWithUTF8String:name];
        //replace "-" to ""
        NSString *strNewName = [strName stringByReplacingOccurrencesOfString:@"-" withString:@""];
        id value = [self valueForKey:strNewName];
        [encoder encodeObject:value forKey:strNewName];
    }
    free(ivars);
}

// 解档
- (id)initWithCoder:(NSCoder*)decoder
{
    if (self = [super init]) {
        unsigned int count;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char* name = ivar_getName(ivar);
            NSString* strName = [NSString stringWithUTF8String:name];
            //replace "-" to ""
            NSString *strNewName = [strName stringByReplacingOccurrencesOfString:@"-" withString:@""];
            id value = [decoder decodeObjectForKey:strNewName];
            [self setValue:value forKey:strName];
        }
        free(ivars);
    }
    return self;
}

@end
