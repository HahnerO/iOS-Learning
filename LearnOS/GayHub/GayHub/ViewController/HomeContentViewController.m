//
//  HomeContentViewController.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/10.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "HomeContentViewController.h"
#import "RepositoriesViewController.h"
#import "MyWorkView.h"

@interface HomeContentViewController () <JumpDelegate>

@property(nonatomic, strong) RepositoriesViewController *reposVC;

@end

@implementation HomeContentViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _homeView = [[HomeScrollView alloc] init];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.homeView.contentView.workView.delegate = self;

    self.navigationItem.title = @"Home";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.prefersLargeTitles = YES;
//    self.navigationController.hidesBarsOnSwipe = YES;

    // bar items
    UIBarButtonItem *avatarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"person.circle"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = avatarButton;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"plus.circle"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = addButton;
    [self.navigationController reloadInputViews];

    self.homeView.delaysContentTouches = NO;
    self.homeView.userInteractionEnabled = YES;

    self.view = _homeView;

    // Do any additional setup after loading the view.
}

- (void)jumpToRepoVC:(nonnull UIButton *)btn {
    NSLog(@"captured!");
    // comment: 这个地方为什么单独作为属性持有呢
    // reply: 防止二次加载，退出repoTableVC后再点击就可以直接免加载从上次的位置开始；
    if (!self.reposVC) {
        NSLog(@"get reposVC in first time");
        self.reposVC = [[RepositoriesViewController alloc] init];
    }
    [self.navigationController pushViewController:self.reposVC animated:YES];
}

@end
