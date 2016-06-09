//
//  MomentHeaderCell.h
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WMUser;

@interface MomentHeaderCell : UITableViewCell

@property (nonatomic, strong) WMUser *wmUser;

+ (instancetype)momentHeaderCellWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath;
+ (instancetype)momentHeaderCellWithTableView:(UITableView *)tableView;

@end
