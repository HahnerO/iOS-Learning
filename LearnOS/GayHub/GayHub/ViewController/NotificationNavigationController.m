//
//  NotificationNavigationController.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/10.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "NotificationNavigationController.h"

@interface NotificationNavigationController ()

@end

@implementation NotificationNavigationController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIViewController *tempVC = [[UIViewController alloc] init];
        [tempVC setView:[[UIView alloc] init]];
        tempVC.navigationItem.title = @"Inbox";
        self.navigationBar.barStyle = UIBarStyleBlack;
//        self.hidesBarsOnSwipe = YES;
        self.hidesBarsOnTap = YES;
        [self addChildViewController:tempVC];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

@end
