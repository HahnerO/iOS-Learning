//
//  HomeViewController.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/9.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "HomeViewController.h"
#import "MyWorkView.h"

@interface HomeViewController () <JumpDelegate>

@property(nonatomic, strong) HomeContentViewController *homeVC;
@property(nonatomic, strong) RepositoriesViewController *reposVC;

@end

@implementation HomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        HomeContentViewController *homeContentVC = [[HomeContentViewController alloc] init];
        _homeVC = homeContentVC;
    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //mywork-view button代理
    _homeVC.homeView.contentView.workView.delegate = self;

//    // navi set
//    self.navigationItem.title = @"Home";
//    self.navigationBar.barStyle = UIBarStyleBlack;
//    self.navigationBar.prefersLargeTitles = YES;
//    self.hidesBarsOnSwipe = YES;
//
//    // bar items
//    UIBarButtonItem *avatarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"person.circle"] style:UIBarButtonItemStylePlain target:self action:nil];
//    self.navigationItem.leftBarButtonItem = avatarButton;
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"plus.circle"] style:UIBarButtonItemStylePlain target:self action:nil];
//    self.navigationItem.rightBarButtonItem = addButton;

    [self addChildViewController:_homeVC];

    NSLog(@"HomeViewController has loaded its view");

    // Do any additional setup after loading the view.
}




- (void)jumpToRepoVC:(nonnull UIButton *)btn {
    NSLog(@"captured!");
    // comment: 这个地方为什么单独作为属性持有呢
    // reply: 防止二次加载，推出repoTableVC后再点击就可以直接免加载从上次的位置开始；
    //          不过这里确实有点问题，因为外部没有用到的属性应该放进内部
    if (!_reposVC) {
        NSLog(@"get reposVC in first time");
        _reposVC = [[RepositoriesViewController alloc] init];
    }
    [self pushViewController:_reposVC animated:YES];
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
