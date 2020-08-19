//
//  LoginViewController.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/8.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import <Masonry.h>
#import "UserStateManager.h"

@interface LoginViewController ()

@property(nonatomic) LoginView *loginView;

@end

@implementation LoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _loginView = [[LoginView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        self.view = _loginView;
    }

    return self;
}

- (void)viewDidLoad {
    NSLog(@"LoginVC did load.");

    // comment: userLoginButton的点击事件收敛到 loginView 内部
    // reply: 其实这么做我觉得也没错，能够更深一步解藕，但是可能对于一个简单的view来说有点故意为之了
/*
    [_loginView.userLoginButton addTarget:[UserStateManager sharedManager] action:@selector(userDidLogin:) forControlEvents:UIControlEventTouchUpInside];
 */
}


@end
