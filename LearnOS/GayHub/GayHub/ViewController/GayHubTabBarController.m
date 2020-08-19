//
//  GayHubTabBarController.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/9.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "GayHubTabBarController.h"
#import "HomeViewController.h"
#import "NotificationNavigationController.h"
#import "SearchNavigationController.h"

@interface GayHubTabBarController ()

@end

@implementation GayHubTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        // comment: 全部调的系统方法的话，不需要自己单独开发一个类吧
        // re: 增加仪式感？
        //set home-tab-item
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        homeVC.tabBarItem.title = @"Home";
        homeVC.tabBarItem.image = [UIImage systemImageNamed:@"house"];
        homeVC.tabBarItem.selectedImage = [UIImage systemImageNamed:@"house.fill"];
        [self addChildViewController:homeVC];

        //set notification-tab-item
        NotificationNavigationController *notificationNavVC = [[NotificationNavigationController alloc] init];
        notificationNavVC.tabBarItem.title = @"Notifications";
        notificationNavVC.tabBarItem.image = [UIImage systemImageNamed:@"bell"];
        notificationNavVC.tabBarItem.selectedImage = [UIImage systemImageNamed:@"bell.fill"];
        [self addChildViewController:notificationNavVC];

        //set search-tab-item
        SearchNavigationController *searchNavVC = [[SearchNavigationController alloc] init];
        searchNavVC.tabBarItem.title = @"Search";
        searchNavVC.tabBarItem.image = [UIImage systemImageNamed:@"magnifyingglass.circle"];
        searchNavVC.tabBarItem.selectedImage = [UIImage systemImageNamed:@"magnifyingglass.circle.fill"];
        [self addChildViewController:searchNavVC];

        self.tabBar.barStyle = UIBarStyleBlack;
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
