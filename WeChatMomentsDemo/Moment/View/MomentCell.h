//
//  MomentCell.h
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WMUser;
@class WMTweet;
@class WMComment;
@class WMMoment;
@class WMImage;

@interface MomentCell : UITableViewCell

@property (nonatomic, strong) WMUser *wmUser;
@property (nonatomic, strong) WMImage *wmImage;
@property (nonatomic, strong) WMComment *wmComment;
@property (nonatomic, strong) WMTweet *wmTweet;
@property (nonatomic, strong) WMMoment *wmMoment;

+ (instancetype)momentCellWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath;
+ (instancetype)momentCellWithTableView:(UITableView *)tableView;

@end
