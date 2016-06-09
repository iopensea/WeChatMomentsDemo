//
//  MomentViewController.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Masonry.h>
#import "YiRefreshFooter.h"

#import "MomentViewController.h"
#import "MomentCell.h"
#import "MomentHeaderCell.h"
#import "WMTweet.h"

#define kScreenWitdh [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kCellHeight 180.0
#define kNavigationBarHeight 64.0f

@interface MomentViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;

//UserInfo
@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, assign) NSInteger userInfoIndex;

//Tweet
@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, assign) NSInteger tweetIndex;

//refreshFooter
@property (nonatomic, strong) YiRefreshFooter *refreshFooter;

//debug code
@property (nonatomic,strong) NSMutableArray * dataMutableArr;
@property (nonatomic,strong) UIImage *images;
@property(nonatomic,strong) UIImageView * refreshView;

@end


static NSString *UserOfexpertID = @"User";
static NSString *TweetOfexpertID = @"Tweet";

@implementation MomentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.userInfoIndex = 0;
    [self loadUserInfoDataWithCache:YES];
    
    WeakSelf(self);
    //下拉刷新
    YiRefreshFooter *refresh = [[YiRefreshFooter alloc] init];
    refresh.scrollView = self.tableView;
    [refresh footer];
    refresh.beginRefreshingBlock = ^(){
        [weakSelf loadUserInfoDataWithCache:NO];
    };
    _refreshFooter = refresh;

}

- (void)loadUserInfoDataWithCache:(BOOL)cache{
    
    WeakSelf(self);
    
    [WMTweet userInfoWithIndex:self.userInfoIndex isCache:cache expertID:UserOfexpertID getDataSuccess:^(NSArray *dataArr) {
        if (dataArr.count == 0) {
            NSLog(@"没有更多数据");
            return ;
        }
        
        if(weakSelf.userInfoIndex == 0) [weakSelf.users removeAllObjects];
        
        [weakSelf.users addObjectsFromArray:dataArr];
        [weakSelf.tableView reloadData];
        
        //每次刷新5条数据
        if(dataArr.count > 0) weakSelf.userInfoIndex += 5;
        
    } getDataFailure:^(NSError *error) {
        NSLog(@"%@",error);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.refreshFooter endRefreshing];
        });
    }];
    
    [WMTweet tweetWithIndex:self.tweetIndex isCache:cache expertID:TweetOfexpertID getDataSuccess:^(NSArray *dataArr) {
        if (dataArr.count == 0) {
            NSLog(@"没有更多数据");
            return ;
        }
        
        if(weakSelf.tweetIndex == 0) [weakSelf.tweets removeAllObjects];
        
        [weakSelf.tweets addObjectsFromArray:dataArr];
        [weakSelf.tableView reloadData];
        
        //每次刷新5条数据
        if(dataArr.count > 0) weakSelf.tweetIndex += 5;
    } getDataFailure:^(NSError *error) {
        NSLog(@"%@",error);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.refreshFooter endRefreshing];
        });
    }];

}

- (void)initTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.users.count;
    } else {
        return self.users.count;;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellHeight = 0.0;
    
    if (indexPath.section == 0) {
        cellHeight = kCellHeight;
    } else {
        cellHeight = kCellHeight * 3;
    }
    
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    if (indexPath.section == 0) {

        //测试代码
        //debug - header cell layout
        MomentHeaderCell *cell = [MomentHeaderCell momentHeaderCellWithTableView:tableView forIndexPath:indexPath];
        cell.wmUser = self.users[indexPath.row];
        return cell;
    } else {
        //测试代码
        //debug - header cell layout
        MomentCell *cell = [MomentCell momentCellWithTableView:tableView forIndexPath:indexPath];
        cell.wmUser = self.users[indexPath.row];
        return cell;
    }
}

- (NSMutableArray *)users{
    
    if (!_users) {
        _users = [NSMutableArray arrayWithArray:[WMTweet cacheWithExpertID:UserOfexpertID]]? :[NSMutableArray array];
    }
    return _users;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - test method for debug

#pragma mark - image cache

/**
 * imageCachePath: @"imageCache"
 *
 * imageUrl: for example @"http://thoughtworks-ios.herokuapp.com/user/jsmith/tweets"
 *
 * imageName:
 *
 **/

//- (void) cacheImageFromUrl:(NSString *)url toPath:(NSString *)imageCachePath andImageName:(NSString *)image {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSLog(@"the paths:%@",paths);
//    NSString * diskCachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageCachePath];
//    NSLog(@"diskCachePath:%@",diskCachePath);
//
//    //if imageCache not existing, create the diskCachePath
//    if (![[NSFileManager defaultManager] fileExistsAtPath:diskCachePath]) {
//        NSError *error=nil;
//        [[NSFileManager defaultManager] createDirectoryAtPath:diskCachePath withIntermediateDirectories:YES attributes:nil error:&error];
//    }
//
//    NSURL *avatarUrl1 = [NSURL URLWithString:url];
////    UIImage *avatar1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:avatarUrl1]];
//
//    NSData *imagedata = [NSData dataWithContentsOfURL:avatarUrl1];
//    NSString *localPath = [NSString stringWithFormat:@"%@/%@",diskCachePath,image];
//    NSLog(@"localPath:%@",localPath);
//
//    @autoreleasepool {
//        if (imagedata) {
//            if (![[NSFileManager defaultManager] fileExistsAtPath:localPath]) {
//                [[NSFileManager defaultManager] createFileAtPath:localPath contents:imagedata attributes:nil];
//            }
//
//            UIImage *imgs = [[UIImage alloc] initWithData:imagedata];
//            self.images = imgs;
//            [self.tableView reloadData];
//        }
//    }
//}
//
//- (void) asynLoadingImageFromPath:(NSString *)imageCachePath andImageName:(NSString *)image{
//    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//
//    NSString *path = [NSString stringWithFormat:@"/%@/%@",imageCachePath,image];
//    NSString *localPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:path];
//
//    //if imageCache exists，load image from imageCachePath: localPath
//    if ([[NSFileManager defaultManager] fileExistsAtPath:localPath]) {
//        NSData *data = [NSData dataWithContentsOfFile:localPath];
//
//        self.images = [UIImage imageWithData:data];
//        [self.tableView reloadData];
//    }
//    else{
//        //if imageCache not existing, request code
//    }
//}

@end
