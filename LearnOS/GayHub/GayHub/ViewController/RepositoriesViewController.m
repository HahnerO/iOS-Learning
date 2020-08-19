//
//  repositoriesViewController.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/12.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "RepositoriesViewController.h"
#import "RepositoriesManager.h"
#import <MJRefresh/MJRefresh.h>
#import <SDWebImage.h>

@interface RepositoriesViewController ()

@property(nonatomic, strong) NSMutableArray *allRepos;

@end

@implementation RepositoriesViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //customed table cell dealing
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RepositoriesViewCell"];
    self.tableView.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"Repositories";
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];


    // 设置回调（一旦进入刷新状态，就调用target-action，也就是调用self的loadNewData方法）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];

    NSLog(@"RepositoriesVC has loaded its view!");
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - Data Logic

/*
 加载逻辑
 1.单例manager从api加载数据
 2.block异步监测消息
 3.赋值后结束刷新
 */
- (void)loadNewData{
    [[RepositoriesManager sharedManager] fetchRepositoriesWithCompleteBlock:^(NSArray * _Nonnull items) {
        self.allRepos = [NSMutableArray arrayWithArray:items];
        [self.tableView reloadData];
        NSLog(@"Data refreshed!");
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_allRepos count];
}

/*
 cell逻辑
 1.注册回收机制
 2.填充cell（异步加载图片）

 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RepositoriesViewCell"];
    if (cell == nil) {
        //default cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RepositoriesViewCell"];
    }

    Repository *singleRepo = [self.allRepos objectAtIndex:indexPath.row];
    cell.textLabel.text = singleRepo.fullName;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor blackColor];
    [cell.imageView sd_setImageWithURL:singleRepo.owner.avatarUrl placeholderImage:[UIImage imageNamed:@"gayhub_white"]];
    return cell;
}

//重写完成删除模式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view. 重写完成删除细节
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.allRepos removeObjectAtIndex:indexPath.row];
        [[RepositoriesManager sharedManager] deleteRepoAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }
}


@end
