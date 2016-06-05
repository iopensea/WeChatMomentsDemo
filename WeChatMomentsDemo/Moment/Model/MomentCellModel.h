//
//  MomentCellModel.h
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MomentCellFavoriteModel, MomentCellCommentModel;

@interface MomentCellModel : NSObject

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *contentMessages;
@property (nonatomic, strong) NSArray *picNameArray;

@property (nonatomic, assign, getter = isLiked) BOOL liked;

@property (nonatomic, strong) NSArray<MomentCellFavoriteModel *> *favoritesArray;
@property (nonatomic, strong) NSArray<MomentCellCommentModel *> *commentsArray;

@property (nonatomic, assign) BOOL isOpening;

@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;

@end
