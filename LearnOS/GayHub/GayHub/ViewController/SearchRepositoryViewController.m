//
//  SearchRepositoryViewController.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/22.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "SearchRepositoryViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "SearchResultManager.h"
#import "SearchRepositoriesTableViewCell.h"
#import "Repository.h"

@interface SearchRepositoryViewController ()

@property(nonatomic, strong) NSArray *allRepos;

@end

@implementation SearchRepositoryViewController

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
    [self.tableView registerClass:[SearchRepositoriesTableViewCell class] forCellReuseIdentifier:@"SearchedRepositoryCell"];
    self.tableView.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"Repositories";
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
//    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;


    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];

    NSLog(@"Search Repository VC has loaded its view!");
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.prefersLargeTitles = YES;
}

#pragma mark - Data Logic

/*
 加载逻辑
 1.单例manager从api加载数据
 2.block异步监测消息
 3.赋值后结束刷新
 */
- (void)loadNewData{
    [[SearchResultManager sharedManager] fetchRepositorySearchResultAsyncWithCompleteBlock:^(NSArray *items) {
        self.allRepos = [NSMutableArray arrayWithArray:items];
        [self.tableView reloadData];
        NSLog(@"Data refreshed!");
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_allRepos count];
//    return 1;
}

/*
 cell逻辑
 1.注册回收机制
 2.填充cell（异步加载图片）

 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    NSString *searchedRepositoryCellId = @"SearchedRepositoryCell";
    SearchRepositoriesTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:searchedRepositoryCellId];
    Repository *singleRepo = _allRepos[indexPath.row];
    cell = [[SearchRepositoriesTableViewCell alloc] init];
    [cell setAvaterUrl:singleRepo.owner.avatarUrl
               account:singleRepo.owner.account
                  name:singleRepo.name
           description:singleRepo.repositoryDescription
            starsCount:[singleRepo.stargazersCount integerValue]
              language:singleRepo.language
     ];


    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

@end
