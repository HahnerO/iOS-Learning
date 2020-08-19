//
//  SceneDelegate.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/8.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "SceneDelegate.h"
#import "ViewController/LoginViewController.h"
#import <ReactiveObjC.h>
#import "LoginViewController.h"
#import "UserStateManager.h"
#import "RepositoriesManager.h"
#import "UserState.h"
#import "MainSearchViewController.h"
#import "HomeContentViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // get window
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    //get login manager
    UserStateManager *loginManager = [UserStateManager sharedManager];

#pragma new-logic
    LoginViewController *loginVC = [[LoginViewController alloc] init];

    // root-change logy
    self.window.rootViewController = loginVC;

    // comment: 这里直接用RAC
    // new-RAC-logic
    [[RACObserve(loginManager, userState.didLogin)
     filter:^BOOL(id  _Nullable value) {
        return [value boolValue];
    }]
     subscribeNext:^(id  _Nullable x) {
        [self setAndChangeRootVCWithTab];
    }];

    // old-RAC-logic
//    [[loginManager rac_signalForSelector:@selector(userDidLogin:)] subscribeNext:^(id x){
//        if (loginManager.userState) {
//            self.window.rootViewController = tabVC;
//        }
//    }];

    [self.window makeKeyAndVisible];
}

- (void)setAndChangeRootVCWithTab
{
    UITabBarController *gayhubTabVC = [[UITabBarController alloc] init];
    UINavigationController *homeNavC = [[UINavigationController alloc] initWithRootViewController:[[HomeContentViewController alloc] init]];
    UINavigationController *notificationNavC = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]];
    UINavigationController *searchNavC = [[UINavigationController alloc] initWithRootViewController:[[MainSearchViewController alloc] init]];
    // tabbar item set
    homeNavC.tabBarItem.title = @"Home";
    homeNavC.tabBarItem.image = [UIImage systemImageNamed:@"house"];
    homeNavC.tabBarItem.selectedImage = [UIImage systemImageNamed:@"house.fill"];
    notificationNavC.tabBarItem.title = @"Notifications";
    notificationNavC.tabBarItem.image = [UIImage systemImageNamed:@"bell"];
    notificationNavC.tabBarItem.selectedImage = [UIImage systemImageNamed:@"bell.fill"];
    searchNavC.tabBarItem.title = @"Search";
    searchNavC.tabBarItem.image = [UIImage systemImageNamed:@"magnifyingglass.circle"];
    searchNavC.tabBarItem.selectedImage = [UIImage systemImageNamed:@"magnifyingglass.circle.fill"];
    // fill VCs into tab
    gayhubTabVC.tabBar.barStyle = UIBarStyleBlack;
    gayhubTabVC.viewControllers = @[homeNavC, notificationNavC, searchNavC];
    self.window.rootViewController = gayhubTabVC;
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
