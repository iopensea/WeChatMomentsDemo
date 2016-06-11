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
@property (nonatomic, strong) UITextField *contentTextView;
//Images
@property (nonatomic, strong) WMImageView *imagesView;
//Sender
@property (nonatomic, strong) WMImageView *senderAvatarImageView;
@property (nonatomic, strong) UILabel *senderNickLabel;
//Comments
@property (nonatomic, strong) UITextField *postContentTextView;
@property (nonatomic, strong) UILabel *postSenderNickLabel;
@property (nonatomic, strong) WMImageView *postAvatarImageView;

@end

static NSString *wmMomentCell = @"wmMomentCell";

@implementation MomentCell

- (void) setWmSender:(WMSender *)wmSender {
    _wmSender = wmSender;
    NSLog(@"_wmSender=%@",[_wmSender yy_modelToJSONObject]);
    
    [self.senderAvatarImageView sd_setImageWithURL:[NSURL URLWithString:_wmSender.avatar]];
    self.senderNickLabel.text = _wmSender.nick;
    self.senderNickLabel.textAlignment = NSTextAlignmentLeft;

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
    NSLog(@"_wmTweet=%@",[wmTweet yy_modelToJSONObject]);
    
    _wmSender = wmTweet.sender; //sender value
    
    _wmTweet.images = wmTweet.images;
    _wmTweet.comments = wmTweet.comments;
    _wmTweet.error = wmTweet.error;
    _wmTweet.unknowError = wmTweet.unknowError;

    //set
    self.contentTextView.text = wmTweet.content; //content value

    if (_wmTweet.images.count > 0) {
        _wmImage = _wmTweet.images[0]; //为了测试，仅仅显示第一张图片
    }
    
    NSString *imageUrl = _wmImage.url; //get images from NSArray
//    NSLog(@"imageUrl=%@",imageUrl);
    self.imagesView.image = [UIImage imageNamed:imageUrl]; //images
//    NSLog(@"wmTweet.sender.avatar=%@",wmTweet.sender.avatar);
//    [self.senderAvatarImageView sd_setImageWithURL:[NSURL URLWithString:wmTweet.sender.avatar] placeholderImage:[UIImage imageNamed:@"tabbar_me"]]; //sender's avater
    self.senderNickLabel.text = wmTweet.sender.nick;
    
    WMComment *commentObj = [WMComment alloc];
    if (_wmTweet.comments.count > 0) {
        commentObj = (WMComment *)_wmTweet.comments[0]; //为了测试，仅仅显示第一个评论
    }

    self.postContentTextView.text = commentObj.content;
    self.postSenderNickLabel.text = commentObj.sender.nick;
    self.postSenderNickLabel.textAlignment = NSTextAlignmentRight;
//    NSLog(@"commentObj.sender.avatar=%@",commentObj.sender.avatar);
    
    [self.postAvatarImageView sd_setImageWithURL:[NSURL URLWithString:wmTweet.sender.avatar] placeholderImage:[UIImage imageNamed:@"tabbar_contacts"]];
    
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
    
    self.contentTextView = [[UITextField alloc]init];
    self.imagesView = [[WMImageView alloc]init];
//    self.imagesView.backgroundColor = [UIColor whiteColor];
    
    self.senderAvatarImageView = [[WMImageView alloc]init];
//    self.senderAvatarImageView.backgroundColor = [UIColor whiteColor];
    self.senderNickLabel = [[UILabel alloc]init];

    self.postContentTextView = [[UITextField alloc]init];
    self.postSenderNickLabel = [[UILabel alloc]init];
    self.postAvatarImageView = [[WMImageView alloc]init];
//    self.postAvatarImageView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.contentTextView];
    [self.contentView addSubview:self.imagesView];

    [self.contentView addSubview:self.senderAvatarImageView];
    [self.contentView addSubview:self.senderNickLabel];

    [self.contentView addSubview:self.postContentTextView];
    [self.contentView addSubview:self.postSenderNickLabel];
    [self.contentView addSubview:self.postAvatarImageView];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.senderAvatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(10);
        make.width.and.height.equalTo(50);
        make.top.equalTo(self.contentView.top).offset(20);
    }];
    
    [self.senderNickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.senderAvatarImageView.right).offset(20);
        make.top.equalTo(self.senderAvatarImageView.top);
        make.right.equalTo(self.contentView.right).offset(-20);
    }];
    
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.senderNickLabel.left).offset(0);
        make.top.equalTo(self.senderNickLabel.bottom).offset(20);
        make.right.equalTo(self.contentView.right).offset(-10);
        make.height.equalTo(50);
    }];
    
    if (self.imagesView) {
        [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.top).offset(10);
            make.left.equalTo(self.postSenderNickLabel.left);
            make.width.and.height.equalTo(50);
        }];
    } else {
        [self.imagesView removeFromSuperview];
    }
    
    if (self.postAvatarImageView) {
        [self.postAvatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.bottom).offset(-10);
            make.right.equalTo(self.contentView.right).offset(-10);
            make.width.and.height.equalTo(50);
        }];
    } else {
        [self.postAvatarImageView removeFromSuperview];
    }
    
    if (self.postAvatarImageView) {
        [self.postSenderNickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.postAvatarImageView.top);
            make.right.equalTo(self.postAvatarImageView.left).offset(-10);
            make.left.equalTo(self.contentView.left).offset(10);
        }];
    } else {
        [self.postSenderNickLabel removeFromSuperview];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
