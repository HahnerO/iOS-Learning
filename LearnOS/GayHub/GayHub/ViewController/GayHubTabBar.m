//
//  GayHubTabBar.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/9.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "GayHubTabBar.h"
#import "HomeViewController.h"

@interface GayHubTabBar ()

@end

@implementation GayHubTabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        //set home-tab-item
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        homeVC.tabBarItem.title = @"Home";
        homeVC.tabBarItem.image = [UIImage systemImageNamed:@"house"];
        homeVC.tabBarItem.selectedImage = [UIImage systemImageNamed:@"house.fill"];
        [self ]



    }

    return self;
}



@end
