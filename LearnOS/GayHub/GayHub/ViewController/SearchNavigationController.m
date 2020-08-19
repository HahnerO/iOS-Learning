//
//  SearchNavigationController.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/10.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "SearchNavigationController.h"
#import "MainSearchViewController.h"

@interface SearchNavigationController ()

@property(nonatomic, strong) UIViewController *mainSearchVC;

@end

@implementation SearchNavigationController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mainSearchVC = [[MainSearchViewController alloc] init];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self addChildViewController:_mainSearchVC];
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
