//
//  MomentViewController.m
//  WeChatMomentsDemo
//
//  Created by apple on 16/6/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MomentViewController.h"
#import "MomentCell.h"
#import "MomentCellModel.h"

#define kScreenWitdh [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kCellHeight 70.0f
#define kNavigationBarHeight 64.0f

#define vLabelTitles @[@"1- one",@"2- two",@"3- three",@"4- four",@"5- five"]
#define vDetailLabelTitles @[@"One",@"two",@"three",@"four",@"five"]

@interface MomentViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataMutableArr;
@property (nonatomic,strong) UIImage *images;

//刷新控件
@property(nonatomic,strong)UIImageView * refreshView;
@property(nonatomic,assign)BOOL isRefrsh;
@property(nonatomic,assign)BOOL isRevolve;

//test
@property (nonatomic, strong) NSMutableArray *labelTextArray;
@property (nonatomic, strong) NSMutableArray *detailLabelTextArray;

@end

@implementation MomentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];

}

- (void)loadData {
    _isRevolve = NO;
    _isRefrsh = NO;
    _dataMutableArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 100; i++)
    {
        [_dataMutableArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    [self initTableView];
}

- (void)initTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"count=%ld",_dataMutableArr.count);
    return _dataMutableArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *kMomentCellReuseId = @"MomentTableViewCell";
    
    [tableView registerClass:[MomentCell class] forCellReuseIdentifier:kMomentCellReuseId];
    MomentCell *cell = [tableView dequeueReusableCellWithIdentifier:kMomentCellReuseId forIndexPath:indexPath];

    //debug - load model
    MomentCellModel *model = [[MomentCellModel alloc]init];
    MomentSenderModel *sender = [[MomentSenderModel alloc]initWithUserName:@"sender" andNick:@"nick" andAvatarUrl:@"tabbar_contactsHL"];
    MomentImageModel *img = [[MomentImageModel alloc]initWithImageUrl:@"tabbar_discover"];
    MomentCellCommentModel *comment = [[MomentCellCommentModel alloc]initWithcontentModel:@"comment" andSenderModel:sender];
    MomentTweetModel *tweetModel = [[MomentTweetModel alloc]initWithContent:@"tweet" andSenderModel:sender andImageArr:@[img] andCommentsArr:@[comment]];

//    UIImage *image = [UIImage imageNamed:@"tabbar_discover"];
    
    model.userInfoModel = [[MomentUserInfoModel alloc]init];
    model.userInfoModel.profileImgUrl = @"tabbar_contacts";
    model.userInfoModel.senderModel = [[MomentSenderModel alloc]initWithUserName:@"UserName" andNick:@"Nick" andAvatarUrl:@"tabbar_me"];
    model.tweet = @[tweetModel];
    [cell setModel:model];
    

    
    return cell;
}

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

@end
