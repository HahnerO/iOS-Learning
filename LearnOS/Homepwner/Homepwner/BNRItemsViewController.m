//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by 王籽涵 on 2020/7/3.
//  Copyright © 2020 王籽涵. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController () {

}


//headerview属性，用xib来实现headerview
@property(nonatomic, strong) IBOutlet UIView *headerView;


@end

@implementation BNRItemsViewController


// === 初始化方法 ===

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        [[BNRItemStore sharedStore] createItem];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:style];
}

// === headerView ===

- (UIView *)headerView {
    //纯代码添加header
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 60)];
    header.backgroundColor = [UIColor clearColor];
    header.userInteractionEnabled = YES;
    [header setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    //添加按钮
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [editButton addTarget:self action:@selector(Edit:) forControlEvents:UIControlEventTouchUpInside];
    [editButton setTitle:@"Edit" forState:UIControlStateNormal];
    [editButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    editButton.frame = CGRectMake(20, 20, 50, 30);
    [header addSubview:editButton];
    //再添加一个
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitle:@"Add" forState:UIControlStateNormal];
    [addButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    addButton.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width - 70, 20, 50, 30);

    [header addSubview:addButton];

    

    //设置headerView
    _headerView = header;
    
    return _headerView;
}

// === VC的 button target-action ===

- (IBAction)Edit:(UIButton *)sender {

    [self.tableView setEditing:!self.tableView.isEditing animated:YES];

    if (self.isEditing && [sender.currentTitle isEqualToString:@"Done"]) {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    } else if ([sender.currentTitle isEqualToString:@"Edit"]){
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}

- (IBAction)add:(UIButton *)sender {
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}


// === 视图加载相关方法 ===

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    //添加header
//    UIView *header = [self headerView];
//    [self.tableView setTableHeaderView:header];
    
//    [self.tableView setSectionHeaderHeight:80];
    
    UINavigationItem *navItem = self.navigationItem;
    navItem.title = @"Homepwner";
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    navItem.rightBarButtonItem = bbi;
    navItem.leftBarButtonItem = self.editButtonItem;
    
    NSLog(@"BNRItemsViewController has loaded its view!");
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1
                                      reuseIdentifier: @"UITableViewCell"];
    }
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = [items objectAtIndex:indexPath.row];
    cell.textLabel.text = [item description];

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:item];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[BNRItemStore sharedStore] moveItemAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}


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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BNRDetailViewController *detaiViewController = [[BNRDetailViewController alloc] init];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectedItem = items[indexPath.row];
    
    detaiViewController.item = selectedItem;
    [self.navigationController pushViewController:detaiViewController animated:YES];
}

@end
