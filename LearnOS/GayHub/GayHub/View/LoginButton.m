//
//  LoginButton.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/9.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "LoginButton.h"

@interface LoginButton ()

@end

@implementation LoginButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        //set button
        [self setTitle:@"Login" forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:5];

    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
