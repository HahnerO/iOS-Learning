//
//  HNDrawViewController.m
//  TouchTracker
//
//  Created by 王籽涵 on 2020/7/6.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "HNDrawViewController.h"
#import "HNDrawView.h"

@interface HNDrawViewController ()

@end

@implementation HNDrawViewController

- (void)loadView {
    self.view = [[HNDrawView alloc] initWithFrame:CGRectZero];
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
