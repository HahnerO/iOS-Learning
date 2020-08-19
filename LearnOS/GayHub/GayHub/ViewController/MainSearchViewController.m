//
//  MainSearchViewController.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/20.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//
#import "MainSearchViewController.h"
#import "RepositoriesManager.h"
#import "SearchResultManager.h"
#import <Masonry.h>
#import "SearchRepositoryViewController.h"
#import "SearchPropleViewController.h"
#import "SearchRepositoriesTableViewCell.h"
#import "SearchPeopleTableViewCell.h"
#import "SearchResult.h"
#import "SearchResultManager.h"
#import "User.h"

/*
 这是一个有4套样式大型VC...
 看不懂一定要直接找我
 */

// showMode define
typedef NS_ENUM(NSInteger, ShowMode) {
    ShowModeInit, // 初始cell类型
    ShowModeHistory, // 历史cell类型
    ShowModeGuide, // 引导cell类型
    ShowModeSearched // 搜索cell类型
};

@interface MainSearchViewController () <UISearchControllerDelegate, UISearchResultsUpdating, UITextFieldDelegate>

@property(nonatomic, strong) UISearchController *searchController;
@property(nonatomic) ShowMode showingMode;
// 持有一个manager，避免代码复用过多
@property(nonatomic, strong) SearchResultManager *dataManager;
// data
@property(nonatomic, strong) NSArray *items;
@property(nonatomic, strong) NSArray *guideCellInfo;
@property(nonatomic, strong) NSMutableArray *historyData;
@property(nonatomic, strong) SearchResult *searchResult;

@end

@implementation MainSearchViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataManager = [SearchResultManager sharedManager];
        _items = [[RepositoriesManager sharedManager] testArr];
        _guideCellInfo = [_dataManager guideCellData];
        _historyData = [NSMutableArray arrayWithArray:[_dataManager getHistoryData]];
        _showingMode = ShowModeInit;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor blackColor];
    // searchcontroller on navibar set
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchBar.barTintColor = [UIColor blackColor];
    self.searchController.searchBar.tintColor = [UIColor whiteColor];
    self.searchController.searchBar.searchTextField.textColor = [UIColor whiteColor];
    self.searchController.searchBar.searchTextField.backgroundColor = [UIColor darkGrayColor];
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.searchTextField.keyboardType = UIReturnKeySearch;
    self.searchController.searchBar.searchTextField.delegate = self;
    self.navigationItem.searchController = self.searchController;

    // navItem set
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationItem.title = @"Explore";
    self.navigationItem.titleView.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    //test cell
    [self.tableView registerClass:[SearchRepositoriesTableViewCell class] forCellReuseIdentifier:@"SearchedRepositoryCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HistoryCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"GuideCell"];
    [self.tableView registerClass:[SearchPeopleTableViewCell class] forCellReuseIdentifier:@"SearchedPeopleCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TestCell"];
}

#pragma mark - Update search result
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *inputStr = searchController.searchBar.text;
    if ([inputStr isEqualToString:@""]){
        if (!self.searchController.isActive) {
            self.showingMode = ShowModeInit;
        } else {
            self.showingMode = ShowModeHistory;
        }
    }
    else {
        self.showingMode = ShowModeGuide;
    }
    [self.tableView reloadData];
}

#pragma mark - keyboard delegate
// 在这里处理searchedMode状态转换和historyData存储逻辑
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //searched Mode
    self.showingMode = ShowModeSearched;
    //history data update
    [self.dataManager addHistoryData:self.searchController.searchBar.text];
    self.historyData = [NSMutableArray arrayWithArray:[self.dataManager getHistoryData]];
    //searched data get
    [self.dataManager setSearchText:self.searchController.searchBar.text];

    [self.dataManager fetchSearchedDataAsyncWithCompleteBlock:^(SearchResult *result) {
        self.searchResult = result;
        NSLog(@"data get!");
        [self.tableView reloadData];
    }];
    return YES;
}

#pragma mark - history data change
- (void)deleteAllHitoryData
{
    [self.dataManager removeAllHistoryData];
    self.historyData = [NSMutableArray arrayWithArray:[self.dataManager getHistoryData]];
    [self.tableView reloadData];
}


#pragma mark - Table view data source
// section number
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.showingMode == ShowModeHistory) {
        return 1;
    } else if (self.showingMode == ShowModeGuide){
        return 1;
    } else if (self.showingMode == ShowModeSearched) {
        return 2;
    } else{
        return 1;
    }
}

// row number
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.isActive) {
        // 历史搜索
        if (self.showingMode == ShowModeHistory) {
            return [_historyData count];
        }
        // guide搜索
        else if (self.showingMode == ShowModeGuide) {
            return 3;
        }
        // 已搜索 - 按下搜索按钮为标志
        else if (self.showingMode == ShowModeSearched) {
            if (section == 0) {
                if ([self.searchResult.repoResult.totalCount intValue] <= 3) {
                    return [self.searchResult.repoResult.totalCount intValue];
                }
            }
            else if (section == 1) {
                if ([self.searchResult.peopleResult.totalCount intValue] <= 3) {
                    return [self.searchResult.peopleResult.totalCount intValue];
                }
            }
            return 4;
        }
    }
    return [self.items count];
}

// cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // cell identifiers
    NSString *historyCellId = @"HistoryCell";
    NSString *guideCellId = @"GuideCell";
    NSString *searchedRepositoryCellId = @"SearchedRepositoryCell";
    NSString *searchedPeopleCellId = @"SearchedPeopleCell";
    // history cell
    if (self.showingMode == ShowModeHistory) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:historyCellId forIndexPath:indexPath];
        if (cell == nil) {
           cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:historyCellId];
        }
        cell.textLabel.text = [_historyData objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor  blackColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        UIImageView *rightArrow = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"arrow.up.left"]];
        [cell addSubview:rightArrow];
        [rightArrow mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(cell);
            make.right.equalTo(cell).with.offset(-20);
        }];
        return cell;
    }
    // guide cell
    else if (self.showingMode == ShowModeGuide){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:guideCellId forIndexPath:indexPath];

        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:guideCellId];
        }

        NSString *guideStr = _guideCellInfo[indexPath.row * 2 + 1];
        cell.textLabel.text = [guideStr stringByAppendingFormat:@"\"%@\"", self.searchController.searchBar.text];

        cell.backgroundColor = [UIColor  darkGrayColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        [cell.imageView setImage:[UIImage systemImageNamed:_guideCellInfo[indexPath.row * 2]]];

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    // searched cell
    else if (self.showingMode == ShowModeSearched) {
        if (indexPath.row < 3) {
            if (indexPath.section == 0)
            {
                SearchRepositoriesTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:searchedRepositoryCellId];
                Repository *singleRepo = self.searchResult.repoResult.items[indexPath.row];
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
            else if (indexPath.section == 1)
            {
                SearchPeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchedPeopleCellId];
                User *singleUser = self.searchResult.peopleResult.items[indexPath.row];
                cell = [[SearchPeopleTableViewCell alloc] init];
                [cell setAvaterUrl:singleUser.avatarUrl
                           account:singleUser.account
                              name:singleUser.info.name
                       description:singleUser.info.bio
                 ];
                return cell;
            }
        }
        else {
            if (indexPath.section == 0) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell"];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TestCell"];
                }
                NSString *prefix = @"See ";
                NSString *suffix = @" more repositories";
                NSString *count = [NSString stringWithFormat:@"%d", [self.searchResult.repoResult.totalCount intValue]];
                NSString *moreText = [prefix stringByAppendingString:count];
                moreText = [moreText stringByAppendingString:suffix];
                cell.textLabel.text = moreText;
                cell.backgroundColor = [UIColor  blackColor];
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return cell;
            }
            else if (indexPath.section == 1)
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell" forIndexPath:indexPath];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TestCell"];
                }
                NSString *prefix = @"See ";
                NSString *suffix = @" more people";
                NSString *count = [NSString stringWithFormat:@"%d", [self.searchResult.peopleResult.totalCount intValue]];
                NSString *moreText = [prefix stringByAppendingString:count];
                moreText = [moreText stringByAppendingString:suffix];
                cell.textLabel.text = moreText;
                cell.backgroundColor = [UIColor  blackColor];
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return cell;
            }
        }
    }
    //默认cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell" forIndexPath:indexPath];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TestCell"];
    }

    cell.textLabel.text = [_items objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor  blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

// section header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = tableView.frame;

    if (self.showingMode == ShowModeHistory) {
        // set header view and subitems
        UIButton *addButton = [[UIButton alloc] init];
        [addButton setTitle:@"Clear" forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [addButton addTarget:self action:@selector(deleteAllHitoryData) forControlEvents:UIControlEventTouchUpInside];
        UILabel *title = [[UILabel alloc] init];
        title.text = @"Recent searches";
        title.textColor = [UIColor whiteColor];
        UIView *headerView = [[UIView alloc] init];
        [headerView addSubview:title];
        [headerView addSubview:addButton];
        // make constraints
        [title mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(headerView).with.offset(20);
            make.height.equalTo(@30);
            make.width.equalTo(@130);
        }];
        [addButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(headerView).with.offset(-20);
            make.top.equalTo(headerView).with.offset(10);
            make.height.equalTo(@30);
            make.width.equalTo(@50);
        }];
        [headerView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(title).with.offset(-10);
            make.bottom.equalTo(title).with.offset(10);
            make.width.equalTo(@(frame.size.width));
        }];

        return headerView;
    }
    else if (self.showingMode == ShowModeSearched) {
        if (section == 0) {
            UITableViewHeaderFooterView *headerView = [[UITableViewHeaderFooterView alloc] init];
            headerView.textLabel.textColor = [UIColor whiteColor];
            headerView.textLabel.text = @"Repositories";
            headerView.backgroundColor = [UIColor blackColor];
            headerView.tintColor = [UIColor darkGrayColor];
            return headerView;
        }
        else if (section == 1) {
            UITableViewHeaderFooterView *headerView = [[UITableViewHeaderFooterView alloc] init];
            headerView.textLabel.textColor = [UIColor whiteColor];
            headerView.textLabel.text = @"People";
            headerView.backgroundColor = [UIColor blackColor];
            headerView.tintColor = [UIColor darkGrayColor];
            return headerView;
        }
        else return [[UIView alloc] init];
    }
    else return [[UIView alloc] init];
}


// table header view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.showingMode == ShowModeHistory) {
        return 50;
    }
    else if (self.showingMode == ShowModeSearched) {
        return 50;
    }
    return 0;
}

// edit style
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.showingMode != ShowModeHistory) {
        return NO;
    }
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_historyData removeObjectAtIndex:indexPath.row];
        [_dataManager removeHistoryDataAt:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// 重写cell跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 点击history的cell
    if (self.showingMode == ShowModeHistory) {
        self.searchController.searchBar.searchTextField.text = [_historyData objectAtIndex:indexPath.row];
        self.showingMode = ShowModeGuide;
        [self.tableView reloadData];
    }
    // 点击guide的cell
    else if (self.showingMode == ShowModeGuide) {
        if (indexPath.row == 0){
            [[SearchResultManager sharedManager] setSearchText:self.searchController.searchBar.text];
            [self.navigationController pushViewController:[[SearchRepositoryViewController alloc] init] animated:YES];
        } else if (indexPath.row == 1){
            [[SearchResultManager sharedManager] setSearchText:self.searchController.searchBar.text];
            [self.navigationController pushViewController:[[SearchPropleViewController alloc] init] animated:YES];
        }
    }
    // 点击searched的more
    else if (self.showingMode == ShowModeSearched) {
        if (indexPath.section == 0 && indexPath.row == 3) {
            [self.navigationController pushViewController:[[SearchRepositoryViewController alloc] init] animated:YES];
        }
        else if (indexPath.section == 1 && indexPath.row == 3) {
            [self.navigationController pushViewController:[[SearchPropleViewController alloc] init] animated:YES];
        }
    }
}

@end
