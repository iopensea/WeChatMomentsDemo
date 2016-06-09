//
//  MomentCell.h
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WMTweet;
@class WMImage;
@class WMSender;
@class WMComment;

@interface MomentCell : UITableViewCell

@property (nonatomic, strong) WMSender *wmSender;
@property (nonatomic, strong) WMImage *wmImage;
@property (nonatomic, strong) WMComment *wmComment;
@property (nonatomic, strong) WMTweet *wmTweet;

+ (instancetype)momentCellWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath;
+ (instancetype)momentCellWithTableView:(UITableView *)tableView;

@end
