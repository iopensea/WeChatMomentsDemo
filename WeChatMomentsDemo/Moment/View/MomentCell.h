//
//  MomentCell.h
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WMUser;

@interface MomentCell : UITableViewCell

@property (nonatomic, strong) WMUser *wmUser;

+ (instancetype)momentCellWithTableView:(UITableView *)tableView;

@end
