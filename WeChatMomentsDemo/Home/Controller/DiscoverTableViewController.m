//
//  DiscoverTableViewController.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DiscoverTableViewController.h"
#import "MomentTableViewController.h"

#import <Masonry.h>

@interface DiscoverTableViewController () <UINavigationControllerDelegate>

@end

@implementation DiscoverTableViewController 

- (instancetype) initWithStyle:(UITableViewStyle)style {
    
    if (self = [super initWithStyle:style]) {
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.tableFooterView = [UIView new];
    self.navigationController.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    static NSString *kDiscoverCellReuseId = @"DiscoverCell";
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kDiscoverCellReuseId];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDiscoverCellReuseId forIndexPath:indexPath];

    switch (section) {
        case 0:
        {
            if (row == 0) {
                NSString *titleText = @"朋友圈";
                
                UIView *backgroudView = [[UIView alloc]init];
                backgroudView.backgroundColor = [UIColor whiteColor];
                
                [cell.contentView addSubview:backgroudView];
                [backgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.contentView.top).offset(10);
                    make.bottom.equalTo(cell.contentView.bottom).offset(-10);
                    make.centerX.equalTo(cell.contentView.centerX);
                    make.left.and.right.equalTo(cell.contentView);
                }];
                
                UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height-2)];
                title.text = titleText;
                [cell.contentView addSubview:title];
                
                UIImageView *leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
                leftImage.image = [UIImage imageNamed:@"AlbumMomentIcon"];
                [cell.contentView addSubview:leftImage];
                
                [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(backgroudView.left);
                    make.centerY.equalTo(backgroudView.centerY);
                    make.width.and.height.equalTo(leftImage.bounds.size.width);
                    
                }];
                
                [title mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(backgroudView.left).offset(leftImage.frame.size.width + 10);
                    make.centerY.equalTo(backgroudView.centerY);
                }];
            }
            break;
        }

        default:
            break;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    switch (indexPath.row)
    {
        case 0:
        {
            //MomentTableViewController
            MomentTableViewController *momentVc = [[MomentTableViewController alloc]init];
            [self.navigationController pushViewController:momentVc animated:YES];
        }
            break;
            
        default:
            return;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat heightOfRow;
    switch (indexPath.section) {
        case 0:
            heightOfRow = 50.0;
            break;
        default:
            heightOfRow = 0;
            break;
    }
    return heightOfRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
