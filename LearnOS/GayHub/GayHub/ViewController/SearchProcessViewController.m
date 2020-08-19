//
//  SearchProcessViewController.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/21.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "SearchProcessViewController.h"
#import "RepositoriesManager.h"


// showMode define
typedef NS_ENUM(NSInteger, ShowMode) {
    ShowModeHistory,
    ShowModeGuide,
    ShowModeSearched
};

@interface SearchProcessViewController ()

@property(nonatomic) ShowMode showingMode;
@property(nonatomic, strong) NSArray *items;

@end

@implementation SearchProcessViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _items = [[RepositoriesManager sharedManager] testArr];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor blackColor];

//    UITableView *temp = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width,  UIScreen.mainScreen.bounds.size.height)];
//    temp.backgroundColor = [UIColor whiteColor];

//    if (_showingMode == ShowModeHistory) {
//    } else {
//    }


    // test data
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TestCell"];
    [self.tableView reloadData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//- (void)refreshView
//{
//
//}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    if (_showingMode == ShowModeHistory) {
//        return 1;
//    }else if (_showingMode == ShowModeGuide){
//        return 2;
//    }else {
//        return 2;
//    }
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (_showingMode == ShowModeHistory) {
//        return 1;
//    }
    return [_items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell" forIndexPath:indexPath];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TestCell"];
    }

    cell.textLabel.text = [_items objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor  blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - search result
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
//    [[RepositoriesManager sharedManager] removeTestArr];
    NSString *inputStr = searchController.searchBar.text;
    if ([inputStr isEqualToString:@""]) {
        _showingMode = ShowModeHistory;
        [self viewDidLoad];
    } else{
        _showingMode = ShowModeGuide;
        [self viewDidLoad];
    }

    [self.tableView reloadData];
}

@end
