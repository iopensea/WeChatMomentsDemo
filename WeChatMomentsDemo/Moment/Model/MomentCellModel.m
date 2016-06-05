//
//  MomentCellModel.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MomentCellModel.h"

const CGFloat contentLabelFontSize = 15;
CGFloat maxContentLabelHeight = 0;

@implementation MomentCellModel {
    CGFloat _lastContentWidth;
}

@synthesize contentMessages = _contentMessages;

- (void)setcontentMessages:(NSString *)contentMessages
{
    _contentMessages = contentMessages;
}

- (NSString *)contentMessages
{
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGRect textRect = [_contentMessages boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:contentLabelFontSize]} context:nil];
        if (textRect.size.height > maxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }
    }
    
    return _contentMessages;
}

- (void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}




@end
