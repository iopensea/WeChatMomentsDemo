//
//  MomentCellModel.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MomentCellModel.h"

//MomentSenderModel
//MomentUserInfoModel
//MomentTweetModel
//MomentImageModel
//MomentCellCommentModel
//MomentSenderModel

@interface MomentCellModel()


@end

@implementation MomentCellModel

- (instancetype) initWithUserInfoModel:(MomentUserInfoModel *)model andTweetArr:(NSArray *)tweetArr
{
    if (!self) {
        self = [super init];
    }
    self.userInfoModel = model;
    self.tweet = tweetArr;

    return self;
}

@end


@implementation MomentUserInfoModel

- (instancetype) initWithProfileImageUrl:(NSString *)profileImageUrl andSenderModel:(MomentSenderModel *)senderModel
{
    if (!self) {
        self = [super init];
    }
    self.profileImgUrl = profileImageUrl;
    self.senderModel = senderModel;

    return self;
}


@end

@implementation MomentTweetModel

- (instancetype) initWithContent:(NSString *)content andSenderModel:(MomentSenderModel *)senderModel andImageArr:(NSArray *)imgsArr andCommentsArr:(NSArray *)commentsArr
{
    if (!self) {
        self = [super init];
    }
    
    self.content = content;
    self.senderModel = senderModel;
    self.imagesArr = imgsArr;
    self.commentsArr = commentsArr;

    return self;
}

@end

@implementation MomentImageModel

- (instancetype) initWithImageUrl:(NSString *)imageUrl
{
    if (!self) {
        self = [super init];
    }
    self.imageUrl = imageUrl;
    
    return self;
}

@end

@implementation MomentCellCommentModel

- (instancetype) initWithcontentModel:(NSString *)content andSenderModel:(MomentSenderModel *)senderModel
{
    if (!self) {
        self = [super init];
    }
    self.content = content;
    self.senderModel = senderModel;
    
    return self;
}

@end

@implementation MomentCellContentModel

- (instancetype) initWithContent:(NSString *)content
{
    if (!self) {
        self = [super init];
    }
    self.content = content;

    return self;
}

@end

@implementation MomentSenderModel

- (instancetype) initWithUserName:(NSString *)userName andNick:(NSString *)nick andAvatarUrl:(NSString *)avatarUrl
{
    if (!self) {
        self = [super init];
    }
    self.username = userName;
    self.nick = nick;
    self.avatarUrl = avatarUrl;

    return self;
}

@end