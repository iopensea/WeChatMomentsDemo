//
//  WMImageView.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WMImageView.h"

@implementation WMImageView

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1.0];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (self.image.size.width < self.bounds.size.width && self.image.size.height < self.bounds.size.height) {
        
        self.contentMode = UIViewContentModeCenter;
    } else if (self.image.size.width >= self.bounds.size.width || self.image.size.height >= self.bounds.size.height){
        
        self.contentMode = UIViewContentModeScaleToFill;
    }
}

@end
