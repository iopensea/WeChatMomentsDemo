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
#import "WMMoment.h"

#define kScreenWitdh [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kCellHeight 180.0
#define kNavigationBarHeight 64.0f

#define vLabelTitles @[@"1- one",@"2- two",@"3- three",@"4- four",@"5- five"]
#define vDetailLabelTitles @[@"One",@"two",@"three",@"four",@"five"]

@interface MomentViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataMutableArr;
@property (nonatomic,strong) UIImage *images;

@property(nonatomic,strong) UIImageView * refreshView;

//
@property (nonatomic, strong) NSMutableArray *topics;
@property (nonatomic, assign) NSInteger topicIndex;
@property (nonatomic, strong) YiRefreshFooter *refreshFooter;

//test
@property (nonatomic, strong) NSMutableArray *labelTextArray;
@property (nonatomic, strong) NSMutableArray *detailLabelTextArray;

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
    
    self.topicIndex = 0;
    [self loadDataWithCache:YES];
    
    WeakSelf(self);
    YiRefreshFooter *refresh = [[YiRefreshFooter alloc] init];
    refresh.scrollView = self.tableView;
    [refresh footer];
    refresh.beginRefreshingBlock = ^(){
        [weakSelf loadDataWithCache:NO];
    };
    _refreshFooter = refresh;
    
    //load data - debug, should load url data from Jason
//    [self loadData];

}

- (void)loadDataWithCache:(BOOL)cache{
    
    WeakSelf(self);
    
    [WMMoment userInfoWithIndex:self.topicIndex isCache:cache expertID:UserOfexpertID getDataSuccess:^(NSArray *dataArr) {
        if (dataArr.count == 0) {
            NSLog(@"没有更多数据");
            return ;
        }
        
        if(weakSelf.topicIndex == 0) [weakSelf.topics removeAllObjects];
        
        [weakSelf.topics addObjectsFromArray:dataArr];
        
        [weakSelf.tableView reloadData];
        
        if(dataArr.count>0) weakSelf.topicIndex += 10;
    } getDataFailure:^(NSError *error) {
        NSLog(@"%@",error);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.refreshFooter endRefreshing];
        });
    }];
}

- (void)initTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellHeight = 0.0;
    
    if (indexPath.section == 0) {
        cellHeight = kCellHeight;
    } else {
        cellHeight = kCellHeight * 2;
    }
    
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    if (indexPath.section == 0) {

        //测试代码
        //debug - header cell layout
        MomentHeaderCell *cell = [MomentHeaderCell momentHeaderCellWithTableView:tableView];
        cell.wmUser = self.topics[indexPath.row];
        return cell;
    } else {
        //测试代码
        //debug - header cell layout
        MomentCell *cell = [MomentCell momentCellWithTableView:tableView];
        cell.wmUser = self.topics[indexPath.row];
        return cell;
    }
}

- (NSMutableArray *)topics{
    
    if (!_topics) {
        _topics = [NSMutableArray arrayWithArray:[WMMoment cacheWithExpertID:UserOfexpertID]]? :[NSMutableArray array];
    }
    return _topics;
}



#pragma mark - image cache

/**
 * imageCachePath: @"imageCache"
 *
 * imageUrl: for example @"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRJm8UXZ0mYtjv1a48RKkFkdyd4kOWLJB0o_l7GuTS8-q8VF64w"
 *
 * imageName:
 *
 **/

- (void) cacheImageFromUrl:(NSString *)url toPath:(NSString *)imageCachePath andImageName:(NSString *)image {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSLog(@"the paths:%@",paths);
    NSString * diskCachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageCachePath];
    NSLog(@"diskCachePath:%@",diskCachePath);
    
    //if imageCache not existing, create the diskCachePath
    if (![[NSFileManager defaultManager] fileExistsAtPath:diskCachePath]) {
        NSError *error=nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:diskCachePath withIntermediateDirectories:YES attributes:nil error:&error];
    }

    NSURL *avatarUrl1 = [NSURL URLWithString:url];
    UIImage *avatar1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:avatarUrl1]];
    
    NSData *imagedata = [NSData dataWithContentsOfURL:avatarUrl1];
    NSString *localPath = [NSString stringWithFormat:@"%@/%@",diskCachePath,image];
    NSLog(@"localPath:%@",localPath);
    
    @autoreleasepool {
        if (imagedata) {
            if (![[NSFileManager defaultManager] fileExistsAtPath:localPath]) {
                [[NSFileManager defaultManager] createFileAtPath:localPath contents:imagedata attributes:nil];
            }
            
            UIImage *imgs = [[UIImage alloc] initWithData:imagedata];
            self.images = imgs;
            [self.tableView reloadData];
        }
    }
}

- (void) asynLoadingImageFromPath:(NSString *)imageCachePath andImageName:(NSString *)image{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString *path = [NSString stringWithFormat:@"/%@/%@",imageCachePath,image];
    NSString *localPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:path];
    
    //if imageCache exists，load image from imageCachePath: localPath
    if ([[NSFileManager defaultManager] fileExistsAtPath:localPath]) {
        NSData *data = [NSData dataWithContentsOfFile:localPath];
        
        self.images = [UIImage imageWithData:data];
        [self.tableView reloadData];
    }
    else{
        //if imageCache not existing, request code
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - test for debug
//test - for debug
- (void)loadData {
    _dataMutableArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 100; i++) {
        [_dataMutableArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
}

@end
