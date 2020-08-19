//
//  SearchViewController.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/19.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "SearchMainViewController.h"

@interface SearchMainViewController () <UISearchControllerDelegate>

@property(nonatomic, strong) NSArray *testArr;

@end

@implementation SearchMainViewController

#pragma mark - init methods

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_testArr arrayByAddingObjectsFromArray:@[@"aaa", @"bbb", @"ccc"]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TestCell"];
    [self.tableView reloadData];
    
//    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//    self.tableView.tableHeaderView = _searchController.searchBar;
//    _searchController.searchBar.barTintColor = [UIColor redColor];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - tableview data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_testArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell"];
    if (cell == nil) {
        //default cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TestViewCell"];
    }
    cell.textLabel.text = _testArr[indexPath.row];
    return cell;
}


@end
