//
//  MomentCell.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Masonry.h>

#import "MomentCell.h"
#import "MomentCellModel.h"

@implementation MomentCell {
    
}

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

- (void)setup {

    self.userName = [[UILabel alloc]init];
    self.iconImageView = [[UIImageView alloc]init];
  
    [self.contentView addSubview:self.userName];
    [self.contentView addSubview:self.iconImageView];
}

- (void)setModel:(MomentCellModel *)model {
    _model = model;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    NSLog(@"avatar=%@",_model.userInfoModel.senderModel.avatarUrl);
    self.userName.text = _model.userInfoModel.senderModel.username;
    self.iconImageView.image = [UIImage imageNamed:_model.userInfoModel.senderModel.avatarUrl];

    //layout
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(10);
        make.centerY.equalTo(self.contentView.centerY);
        make.width.and.height.equalTo(30);
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.right).offset(10);
        make.centerY.equalTo(self.contentView.centerY);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
