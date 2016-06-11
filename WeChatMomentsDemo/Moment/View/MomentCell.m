//
//  MomentCell.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Masonry.h>
#import <UIImageView+WebCache.h>

#import "MomentCell.h"
#import "WMImageView.h"

#import "WMTweet.h"
#import "WMImage.h"
#import "WMSender.h"
#import "WMComment.h"
#import <YYModel.h>

@interface MomentCell ()

//Content
@property (nonatomic, strong) UITextView *contentTextView;
//Images
@property (nonatomic, strong) WMImageView *imagesView;
//Sender
@property (nonatomic, strong) WMImageView *senderAvatarImageView;
@property (nonatomic, strong) UILabel *senderNickLabel;
@property (nonatomic, strong) UILabel *senderUserNameLabel;
//Comments
@property (nonatomic, strong) UITextView *postContentTextView;
@property (nonatomic, strong) UILabel *postSenderNickLabel;
@property (nonatomic, strong) WMImageView *postAvatarImageView;
@property (nonatomic, strong) UILabel *postSenderUserNameLabel;

@end

static NSString *wmMomentCell = @"wmMomentCell";

@implementation MomentCell

- (void) setWmSender:(WMSender *)wmSender {
    _wmSender = wmSender;
    NSLog(@"_wmSender=%@",[_wmSender yy_modelToJSONObject]);
}

- (void) setWmImage:(WMImage *)wmImage {
    _wmImage = wmImage;
    NSLog(@"_wmImage=%@",[wmImage yy_modelToJSONObject]);
}

- (void)setWmComment:(WMComment *)wmComment {
    _wmComment = wmComment;
    NSLog(@"_wmComment=%@",[wmComment yy_modelToJSONObject]);
}

- (void) setWmTweet:(WMTweet *)wmTweet {
    _wmTweet = wmTweet;
//    NSLog(@"_wmTweet=%@",[wmTweet yy_modelToJSONObject]);
    
    _wmSender = wmTweet.sender; //sender value
    
    _wmTweet.images = wmTweet.images;
    NSLog(@"wmTweet.images=%@",[wmTweet.images yy_modelToJSONObject]);
    _wmTweet.comments = wmTweet.comments;
    NSLog(@"wmTweet.comments=%@",[wmTweet.comments yy_modelToJSONObject]);
    _wmTweet.error = wmTweet.error;
    _wmTweet.unknowError = wmTweet.unknowError;

    self.contentTextView.text = wmTweet.content; //content value

    if (_wmTweet.images.count > 0) {
        _wmImage = _wmTweet.images[0]; //为了测试，仅仅显示第一张图片
    }
    
    NSString *imageUrl = _wmImage.imageurl; //get images from NSArray
    NSLog(@"imageUrl=%@",_wmImage.imageurl);
//    self.imagesView.image = [UIImage imageNamed:imageUrl]; //images
    [self.imagesView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"AlbumAddBtn"]];
    
    [self.senderAvatarImageView sd_setImageWithURL:[NSURL URLWithString:wmTweet.sender.avatar] placeholderImage:[UIImage imageNamed:@"tabbar_me"]]; //sender's avater
    self.senderNickLabel.text = wmTweet.sender.nick;
    self.senderNickLabel.textAlignment = NSTextAlignmentLeft;
    self.senderNickLabel.textColor = [UIColor colorWithRed:65/255 green:65/255 blue:255/255 alpha:1.0];
    self.senderUserNameLabel.text = [NSString stringWithFormat:@"%@",wmTweet.sender.username];
    self.senderUserNameLabel.textAlignment = NSTextAlignmentRight;
    self.senderUserNameLabel.font = [UIFont systemFontOfSize:11];
    self.senderUserNameLabel.textColor = [UIColor colorWithRed:65/255 green:65/255 blue:255/255 alpha:0.5];
    
    WMComment *commentObj = [WMComment alloc];
    if (_wmTweet.comments && _wmTweet.comments.count > 0) {
        commentObj = (WMComment *)_wmTweet.comments[0]; //为了测试，仅仅显示第一个评论
//        commentObj = (WMComment *)_wmTweet.comments[0];
    }

    self.postContentTextView.text = commentObj.content;
    self.postSenderNickLabel.text = [NSString stringWithFormat:@"%@",commentObj.sender.nick?commentObj.sender.nick:@""];
    self.postSenderNickLabel.textColor = [UIColor blueColor];
    self.postSenderNickLabel.textAlignment = NSTextAlignmentRight;
    self.postSenderUserNameLabel.text = commentObj.sender.username;
    self.postSenderUserNameLabel.textAlignment = NSTextAlignmentLeft;
    self.postSenderUserNameLabel.textColor = [UIColor blueColor];
    self.postSenderUserNameLabel.font = [UIFont systemFontOfSize:11];
    
    [self.postAvatarImageView setBackgroundColor:[UIColor clearColor]];
    [self.postAvatarImageView sd_setImageWithURL:[NSURL URLWithString:wmTweet.sender.avatar] placeholderImage:[UIImage imageNamed:@"tabbar_contactsHL"]];
    
}

+ (instancetype) momentCellWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath {
    
    [tableView registerClass:[MomentCell class] forCellReuseIdentifier:wmMomentCell];
    MomentCell *cell = [tableView dequeueReusableCellWithIdentifier:wmMomentCell forIndexPath:indexPath];

    cell.senderAvatarImageView.layer.cornerRadius = 5;
    cell.senderAvatarImageView.layer.masksToBounds = YES;
    
    return cell;
}

+ (instancetype) momentCellWithTableView:(UITableView *)tableView {
    
    [tableView registerClass:[MomentCell class] forCellReuseIdentifier:wmMomentCell];
    MomentCell *cell = [tableView dequeueReusableCellWithIdentifier:wmMomentCell];
    
    if ( nil == cell) {
        cell = [[MomentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wmMomentCell];
    }

    cell.senderAvatarImageView.layer.cornerRadius = 5;
    cell.senderAvatarImageView.layer.masksToBounds = YES;
    
    return cell;
}

#pragma mark - customize cell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

- (void) setup {
    
    self.contentTextView = [[UITextView alloc]init];
    self.contentTextView.backgroundColor = [UIColor clearColor];
    self.imagesView = [[WMImageView alloc]init];
    
    self.senderAvatarImageView = [[WMImageView alloc]init];
    self.senderNickLabel = [[UILabel alloc]init];
    self.senderUserNameLabel = [[UILabel alloc]init];

    self.postContentTextView = [[UITextView alloc]init];
    self.postContentTextView.backgroundColor = [UIColor clearColor];
    self.postSenderNickLabel = [[UILabel alloc]init];
    self.postAvatarImageView = [[WMImageView alloc]init];
    self.postSenderUserNameLabel = [[UILabel alloc]init];
    
    [self.contentView addSubview:self.contentTextView];
    [self.contentView addSubview:self.imagesView];

    [self.contentView addSubview:self.senderAvatarImageView];
    [self.contentView addSubview:self.senderNickLabel];
    [self.contentView addSubview:self.senderUserNameLabel];

    [self.contentView addSubview:self.postContentTextView];
    [self.contentView addSubview:self.postSenderNickLabel];
    [self.contentView addSubview:self.postAvatarImageView];
    [self.contentView addSubview:self.postSenderUserNameLabel];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //sender avatar
    [self.senderAvatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(10);
        make.width.and.height.equalTo(50);
        make.top.equalTo(self.contentView.top).offset(5);
    }];
    
    //sender nick
    [self.senderNickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.senderAvatarImageView.right).offset(5);
        make.top.equalTo(self.senderAvatarImageView.top);
        make.width.equalTo(150);
    }];
    
    [self.senderUserNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.senderNickLabel.top);
        make.left.equalTo(self.senderNickLabel.right).offset(5);
        make.right.equalTo(self.contentView.right).offset(-5);
        make.height.equalTo(20);
    }];
    
    //content
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.senderNickLabel.left).offset(5);
        make.top.equalTo(self.senderNickLabel.bottom).offset(5);
        make.right.equalTo(self.contentView.right).offset(-100);
        make.height.equalTo(70);
    }];
    
    //images
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTextView.top);
        make.left.equalTo(self.contentTextView.right).offset(5);
        make.width.and.height.equalTo(50);
    }];

    //post sender avatar
    [self.postAvatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTextView.bottom).offset(20);
        make.left.equalTo(self.contentView.left).offset(5);
        make.width.and.height.equalTo(50);
    }];
    
    //post sender nick
    [self.postSenderNickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTextView.bottom).offset(5);
        make.left.equalTo(self.contentTextView.left);
    }];
    
    //post sender username
    [self.postSenderUserNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.postSenderNickLabel.top);
        make.left.equalTo(self.postSenderNickLabel.right).offset(5);
    }];

    //post Content
    [self.postContentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.postSenderNickLabel.top);
        make.left.equalTo(self.postSenderNickLabel.left).offset(5);
        make.right.equalTo(self.contentView.right).offset(-70);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
