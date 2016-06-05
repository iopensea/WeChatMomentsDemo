//
//  MomentCellModel.h
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MomentSenderModel;
@class MomentUserInfoModel;
@class MomentTweetModel;
@class MomentImageModel;
@class MomentCellCommentModel;
@class MomentSenderModel;
@class MomentCellContentModel;

@interface MomentCellModel : NSObject

/**  **/

@property (nonatomic,strong) MomentUserInfoModel *userInfoModel;
@property (nonatomic,strong) NSArray *tweet;

- (instancetype) initWithUserInfoModel:(MomentUserInfoModel *)model andTweetArr:(NSArray *)tweetArr;

@end

//Request Tweet Model
@interface MomentTweetModel : NSObject

@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSArray *imagesArr;
@property (nonatomic,strong) MomentSenderModel *senderModel;
@property (nonatomic,copy) NSArray *commentsArr;

- (instancetype) initWithContent:(NSString *)content andSenderModel:(MomentSenderModel *)senderModel andImageArr:(NSArray *)imgArr andCommentsArr:(NSArray *)commentsArr;

@end

//Request User Info Model
@interface MomentUserInfoModel : NSObject
@property (nonatomic,copy) NSString *profileImgUrl;
@property (nonatomic,strong) MomentSenderModel *senderModel;

- (instancetype) initWithProfileImageUrl:(NSString *)profileImageUrl andSenderModel:(MomentSenderModel *)sender;

@end

//Content
@interface MomentCellContentModel : NSObject

@property (nonatomic,copy) NSString *content;

- (instancetype) initWithContent:(NSString *)content;

@end

//Image
@interface MomentImageModel : NSObject

@property (nonatomic,copy) NSString *imageUrl;

- (instancetype) initWithImageUrl:(NSString *)imageUrl;

@end

//Request Sender Model
@interface MomentSenderModel : NSObject

@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *nick;
@property (nonatomic,copy) NSString *avatarUrl;

- (instancetype) initWithUserName:(NSString *)userName andNick:(NSString *)nick andAvatarUrl:(NSString *)avatar;

@end

//Request Comments Model
@interface MomentCellCommentModel : NSObject

@property (nonatomic,copy) NSString *content;
@property (nonatomic,strong) MomentSenderModel *senderModel;

- (instancetype) initWithcontentModel:(NSString *)cotent andSenderModel:(MomentSenderModel *)senderModel;

@end

