//
//  SearchPropleViewController.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/22.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "SearchPropleViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "SearchResultManager.h"
#import "SearchPeopleTableViewCell.h"
#import "User.h"

@interface SearchPropleViewController ()

@property(nonatomic, strong) NSArray *allPersons;

@end

@implementation SearchPropleViewController

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
        [self.tableView registerClass:[SearchPeopleTableViewCell class] forCellReuseIdentifier:@"SearchedPeopleCell"];
        self.tableView.backgroundColor = [UIColor blackColor];
        self.navigationItem.title = @"Users";
        self.navigationController.navigationBar.prefersLargeTitles = NO;
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
        self.tableView.rowHeight = UITableViewAutomaticDimension;


        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        // 马上进入刷新状态
        [self.tableView.mj_header beginRefreshing];

        NSLog(@"Search People VC has loaded its view!");
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
    [[SearchResultManager sharedManager] fetchPersonSearchResultAsyncWithCompleteBlock:^(NSArray *items) {
        self.allPersons = [NSMutableArray arrayWithArray: items];
        [self.tableView reloadData];
        NSLog(@"Data refreshed!");
        [self.tableView.mj_header endRefreshing];
    }];

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_allPersons count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *searchedPeopleCellId = @"SearchedPeopleCell";
    SearchPeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchedPeopleCellId];
    User *singleUser = _allPersons[indexPath.row];
    cell = [[SearchPeopleTableViewCell alloc] init];
    [cell setAvaterUrl:singleUser.avatarUrl
               account:singleUser.account
                  name:singleUser.info.name
           description:singleUser.info.bio
     ];
    return cell;
}

@end
