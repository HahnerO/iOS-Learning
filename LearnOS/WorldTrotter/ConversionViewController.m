//
//  ConversionViewController.m
//  WorldTrotter
//
//  Created by 王籽涵 on 2020/7/1.
//  Copyright © 2020 王籽涵. All rights reserved.
//

#import "ConversionViewController.h"

@interface ConversionViewController ()

@end

@implementation ConversionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
    [aLabel setBackgroundColor:UIColor.blackColor];
    [self.view addSubview:aLabel];
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
