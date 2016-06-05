//
//  HomeViewController.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WeakSelf(self);
    weakSelf.view.backgroundColor = [UIColor lightGrayColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
