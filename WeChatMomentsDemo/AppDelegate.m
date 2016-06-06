//
//  AppDelegate.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstPageTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    UINavigationBar *naviBar = [UINavigationBar appearance];
//    UIApplication *shareApp = [UIApplication sharedApplication];
//    shareApp.statusBarStyle = UIStatusBarStyleLightContent;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

     [UINavigationBar appearance].tintColor = [UIColor whiteColor];
     [UINavigationBar appearance].barTintColor = kWMColor(0.1, 0.1, 0.1, 1.0);
     [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[FirstPageTabBarController alloc]init];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
