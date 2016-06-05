//
//  WMNavigationViewController.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WMNavigationViewController.h"

@interface WMNavigationViewController ()

@end

@implementation WMNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set background color or image here
    [self.navigationBar setBackgroundColor:[UIColor cyanColor]];

    self.interactivePopGestureRecognizer.delegate = nil;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (void)more {
    [self popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
