//
//  LoginView.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/8.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "LoginView.h"
#import <Masonry.h>
#import "UIImage+HNUtil.h"
#import "UserStateManager.h"

@interface LoginView ()

@property(nonatomic, strong) UIButton *userLoginButton;
@property(nonatomic, strong) UIImageView *loginImageView;
@property(nonatomic, strong) UILabel *bottomLabel;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    self.backgroundColor = [UIColor blackColor];

    // set button
    self.userLoginButton = [[UIButton alloc] init];
    [self.userLoginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.userLoginButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.userLoginButton setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
    [self.userLoginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.userLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.userLoginButton.layer setMasksToBounds:YES];
    [self.userLoginButton.layer setCornerRadius:5];
    [self addSubview:self.userLoginButton];
    //set action
    [self.userLoginButton addTarget:[UserStateManager sharedManager] action:@selector(userDidLogin) forControlEvents:UIControlEventTouchUpInside];

    //set image
    self.loginImageView = [[UIImageView alloc] init];
    self.loginImageView.image = [UIImage imageNamed:@"gayhub_white"];

    [self.loginImageView sizeToFit];
    [self addSubview:_loginImageView];

    //set label
    self.bottomLabel = [[UILabel alloc] init];
    self.bottomLabel.text = @"World's greatest gay's communication";
    self.bottomLabel.textColor = [UIColor grayColor];
    self.bottomLabel.adjustsFontSizeToFitWidth = YES;
    self.bottomLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.bottomLabel];

    // comment: 为什么这里还存在这个方法的调用？
    // re: 我试了一下必须得调用这个方法，否则不会进行layout
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints
{
    [super updateConstraints];

    // constraints made by masonry
    [self.userLoginButton mas_makeConstraints:^(MASConstraintMaker *make){
       make.width.equalTo(@(self.bounds.size.width - 40));
       make.height.equalTo(@50);
       make.centerX.equalTo(self);
       make.centerY.equalTo(self).with.offset(30);
    }];
    [self.loginImageView mas_makeConstraints:^(MASConstraintMaker *make){
       make.width.equalTo(@(120));
       make.height.equalTo(@(120));
       make.centerX.equalTo(self);
       make.bottom.equalTo(self.userLoginButton.mas_top).with.offset(-30);
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make){
       make.width.equalTo(@(self.bounds.size.width - 40));
       make.centerX.equalTo(self);
       make.centerY.equalTo(self.mas_bottom).with.offset(-50);
    }];
}

@end
