//
//  FirstPageTabBarController.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FirstPageTabBarController.h"
#import "WMNavigationViewController.h"

#import "DiscoverTableViewController.h"

#define keyWeXinTabBar @"keyWeXinTabBar"
#define keyContactTabBar @"keyContactTabBar"
#define keyDiscoverTabBar @"keyDiscoverTabBar"
#define keyPersonalTabBar @"keyPersonalTabBar"
#define keyClassName @"classViewControllerString"
#define keyTitle @"title"
#define keyImageName @"imageName"
#define keySelImageName @"selectedImageName"

@interface FirstPageTabBarController ()

@end

@implementation FirstPageTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *wechatDic = @{keyClassName:@"BaseViewController",keyTitle:@"微信",keyImageName:@"tabbar_wechat",keySelImageName:@"tabbar_wechatHL"};
    NSDictionary *contactDic = @{keyClassName:@"BaseViewController",keyTitle:@"通讯录",keyImageName:@"tabbar_contacts",keySelImageName:@"tabbar_contactsHL"};
    NSDictionary *discoverDic = @{keyClassName:@"DiscoverTableViewController",keyTitle:@"朋友圈",keyImageName:@"tabbar_discover",keySelImageName:@"tabbar_discoverHL"};
    NSDictionary *meDic = @{keyClassName:@"BaseViewController",keyTitle:@"我",keyImageName:@"tabbar_me",keySelImageName:@"tabbar_meHL"};
    
    UIViewController *wechatVC = [NSClassFromString(wechatDic[keyClassName]) new];
    UIViewController *contactVC = [NSClassFromString(contactDic[keyClassName]) new];
    UIViewController *discoverVC = [NSClassFromString(discoverDic[keyClassName]) new];
    UIViewController *meVC = [NSClassFromString(meDic[keyClassName]) new];
    
    [self setUpChildVC:wechatVC title:wechatDic[keyTitle] image:wechatDic[keyImageName] selectedImage:wechatDic[keySelImageName]];
    [self setUpChildVC:contactVC title:contactDic[keyTitle] image:contactDic[keyImageName] selectedImage:contactDic[keySelImageName]];
    [self setUpChildVC:discoverVC title:discoverDic[keyTitle] image:discoverDic[keyImageName] selectedImage:discoverDic[keySelImageName]];
    [self setUpChildVC:meVC title:meDic[keyTitle] image:meDic[keyImageName] selectedImage:meDic[keySelImageName]];
}

- (void)setUpChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    vc.navigationItem.title = title;
    
    UIImage *imageIcon = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImageIcon = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    WMNavigationViewController *naviVc = [[WMNavigationViewController alloc] initWithRootViewController:vc];
    UITabBarItem *item = naviVc.tabBarItem;
    item.title = title;
    item.image = imageIcon;
    item.selectedImage = selectedImageIcon;
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:kWMGreenColor} forState:UIControlStateSelected];
    
    [self addChildViewController:naviVc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
