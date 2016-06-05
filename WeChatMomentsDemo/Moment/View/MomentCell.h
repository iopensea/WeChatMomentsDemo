//
//  MomentCell.h
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MomentCellDelegate <NSObject>

@end

@class MomentCellModel;

@interface MomentCell : UITableViewCell

@property (nonatomic, weak) id<MomentCellDelegate> delegate;
@property (nonatomic, strong) MomentCellModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) UIImageView *iconImageView; //user avatar
@property (nonatomic, strong) UILabel *userName; //user name

- (instancetype) initWithFrame:(CGRect)frame;
- (id) initWithCoder:(NSCoder *)aDecoder;
- (void)layoutSubviews;
- (void)awakeFromNib;

- (void)setModel:(MomentCellModel *)model;

@end
