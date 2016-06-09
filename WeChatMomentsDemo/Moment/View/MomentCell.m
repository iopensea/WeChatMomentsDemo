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


@interface MomentCell ()

//Content
@property (nonatomic, strong) UITextView *contentTextView;
//Images
@property (nonatomic, strong) WMImageView *imagesView;
//Sender
@property (nonatomic, strong) WMImageView *senderAvatarImageView;
@property (nonatomic, strong) UILabel *senderNickLabel;
//Comments
@property (nonatomic, strong) UITextView *postContentTextView;
@property (nonatomic, strong) WMImageView *postSenderNickLabel;
@property (nonatomic, strong) WMImageView *postAvatarImageView;

@end

static NSString *wmMomentCell = @"wmMomentCell";

@implementation MomentCell

- (void) setWmSender:(WMSender *)wmSender {
    _wmSender = wmSender;
    
    [self.senderAvatarImageView sd_setImageWithURL:[NSURL URLWithString:_wmSender.avatar]];
    self.senderNickLabel.text = _wmSender.nick;
    self.senderNickLabel.textAlignment = NSTextAlignmentRight;

}

- (void) setWmImage:(WMImage *)wmImage {
    _wmImage = wmImage;
}

- (void)setWmComment:(WMComment *)wmComment {
    _wmComment = wmComment;
}

- (void) setWmTweet:(WMTweet *)wmTweet {
    _wmTweet = wmTweet;
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
    
    self.senderNickLabel = [[UILabel alloc]init];
    self.senderAvatarImageView = [[WMImageView alloc]init];
    
    [self.contentView addSubview:self.senderNickLabel];
    [self.contentView addSubview:self.senderAvatarImageView];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.senderAvatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.right).offset(-10);
        make.width.and.height.equalTo(50);
        make.bottom.equalTo(self.contentView.bottom).offset(-10);
    }];
    
    [self.senderNickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(10);
        make.right.equalTo(self.senderAvatarImageView.left).offset(-10);
        make.top.equalTo(self.senderAvatarImageView.top);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
