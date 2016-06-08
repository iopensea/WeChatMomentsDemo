//
//  MomentHeaderCell.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/6.
//  Copyright © 2016年 apple. All rights reserved.
//
#import <Masonry.h>
#import <UIImageView+WebCache.h>

#import "MomentHeaderCell.h"
#import "WMUser.h"
#import "WMImageView.h"

@interface MomentHeaderCell ()

@property (nonatomic, strong) WMImageView *profileImageView;
@property (nonatomic, strong) WMImageView *avatarImageView;

@property (nonatomic, strong) UILabel *nickLabel;

@end

static NSString *wmMomentHeaderCell = @"wmMomentHeaderCell";

@implementation MomentHeaderCell

- (void) setWmUser:(WMUser *)user {
    _wmUser = user;
    
    self.profileImageView.contentMode = UIViewContentModeCenter;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:_wmUser.profileimage] placeholderImage:[UIImage imageNamed:@"tabbar_me"]];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_wmUser.avatar]];
    
    self.nickLabel.text = _wmUser.nick;
    self.nickLabel.textAlignment = NSTextAlignmentRight;

}

+ (instancetype) momentHeaderCellWithTableView:(UITableView *)tableView {
    [tableView registerClass:[MomentHeaderCell class] forCellReuseIdentifier:wmMomentHeaderCell];
    
    MomentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:wmMomentHeaderCell];
    
    if (!cell) {
        cell = [[MomentHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wmMomentHeaderCell];
    }
    
    cell.avatarImageView.layer.cornerRadius = 5;
    cell.avatarImageView.layer.masksToBounds = YES;
    
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
    
    self.nickLabel = [[UILabel alloc]init];
    self.avatarImageView = [[WMImageView alloc]init];
    self.profileImageView = [[WMImageView alloc]init];
    
    [self.contentView addSubview:self.nickLabel];
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.profileImageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.profileImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left);
        make.right.equalTo(self.contentView.right);
        make.top.equalTo(self.contentView.top);
        make.bottom.equalTo(self.contentView.bottom);
        
    }];

    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.right).offset(-10);
        make.width.and.height.equalTo(50);
    }];
    
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(10);
        make.right.equalTo(self.avatarImageView.left).offset(-10);
        make.top.equalTo(self.avatarImageView.top);

    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
