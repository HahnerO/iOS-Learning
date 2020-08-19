//
//  MyWorkView.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/10.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "MyWorkView.h"
#import <Masonry.h>
#import "UIImage+HNUtil.h"
#import "RepositoriesViewController.h"

@interface MyWorkView ()

@property(nonatomic, strong) UIImageView *issuesImage;
@property(nonatomic, strong) UIImageView *repositoriesImage;
@property(nonatomic, strong) UIImageView *pullImage;
@property(nonatomic, strong) UIImageView *groupImage;

@end

@implementation MyWorkView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.userInteractionEnabled = YES;
        [self createSubviews];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

# pragma draw buttons
//实际上这里可以写一个函数出来进行代码复用，但是我改的到这个版本的时候已经太复杂了，就以后重构的时候做
- (void)createSubviews{
    //issuse button
    UIButton *issuesButton = [[UIButton alloc] init];
    [issuesButton setBackgroundImage:[UIImage createImageWithColor:[UIColor darkGrayColor]] forState:UIControlStateNormal];
    [issuesButton setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
    [issuesButton setTitle:@"Issues" forState:UIControlStateNormal];
    issuesButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    issuesButton.contentEdgeInsets = UIEdgeInsetsMake(0, 90, 0, 0);
    issuesButton.tintColor = [UIColor whiteColor];
    UIImageView *issuesImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"issues"]];
    UIImageView *rightArrow1 = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"chevron.right"]];
    rightArrow1.tintColor = [UIColor grayColor];
    [issuesButton addSubview:rightArrow1];
    [rightArrow1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(issuesButton);
        make.right.equalTo(issuesButton.mas_right).with.offset(-20);
    }];

    //pull button
    UIButton *pullButton = [[UIButton alloc] init];
    [pullButton setBackgroundImage:[UIImage createImageWithColor:[UIColor darkGrayColor]] forState:UIControlStateNormal];
    [pullButton setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
    [pullButton setTitle:@"Pull Requests" forState:UIControlStateNormal];
    pullButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    pullButton.contentEdgeInsets = UIEdgeInsetsMake(0, 90, 0, 0);
    pullButton.tintColor = [UIColor whiteColor];
    UIImageView *pullImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"branch"]];
    UIImageView *rightArrow2 = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"chevron.right"]];
    rightArrow2.tintColor = [UIColor grayColor];
    [pullButton addSubview:rightArrow2];
    [rightArrow2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(pullButton);
        make.right.equalTo(pullButton.mas_right).with.offset(-20);
    }];

    //repositories button
    UIButton *repositoriesButton = [[UIButton alloc] init];
    [repositoriesButton setBackgroundImage:[UIImage createImageWithColor:[UIColor darkGrayColor]] forState:UIControlStateNormal];
    [repositoriesButton setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
    [repositoriesButton setTitle:@"Repositories" forState:UIControlStateNormal];
    repositoriesButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    repositoriesButton.contentEdgeInsets = UIEdgeInsetsMake(0, 90, 0, 0);
    repositoriesButton.tintColor = [UIColor whiteColor];
    UIImageView *repositoriesImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"repositories"]];
    UIImageView *rightArrow3 = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"chevron.right"]];
    rightArrow3.tintColor = [UIColor grayColor];
    [repositoriesButton addSubview:rightArrow3];
    [rightArrow3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(repositoriesButton);
        make.right.equalTo(repositoriesButton.mas_right).with.offset(-20);
    }];
    //action add ======
    [repositoriesButton addTarget:self action:@selector(jumpToRepoView:) forControlEvents:UIControlEventTouchUpInside];

    //group button
    UIButton *groupButton = [[UIButton alloc] init];
    [groupButton setBackgroundImage:[UIImage createImageWithColor:[UIColor darkGrayColor]] forState:UIControlStateNormal];
    [groupButton setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
    [groupButton setTitle:@"Groups" forState:UIControlStateNormal];
    groupButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    groupButton.contentEdgeInsets = UIEdgeInsetsMake(0, 90, 0, 0);
    groupButton.tintColor = [UIColor whiteColor];
    UIImageView *groupImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"group"]];
    UIImageView *rightArrow4 = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"chevron.right"]];
    rightArrow4.tintColor = [UIColor grayColor];
    [groupButton addSubview:rightArrow4];
    [rightArrow4 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(groupButton);
        // comment: 用trailing代替right
        // re: 更改报错
        make.right.equalTo(groupButton.mas_right).with.offset(-20);
    }];

    //buttons sets
    self.issuesImage = issuesImage;
    [issuesButton addSubview: self.issuesImage];
    self.pullImage = pullImage;
    [pullButton addSubview:pullImage];
    self.repositoriesImage = repositoriesImage;
    [repositoriesButton addSubview:self.repositoriesImage];
    self.groupImage = groupImage;
    [groupButton addSubview:groupImage];

    //add button
    self.pullButton = pullButton;
    self.issuesButton = issuesButton;
    self.repositoriesButton = repositoriesButton;
    self.groupButton = groupButton;
    [self addSubview:self.repositoriesButton];
    [self addSubview:self.pullButton];
    [self addSubview:self.issuesButton];
    [self addSubview:self.groupButton];

}

- (void)updateConstraints
{
    [super updateConstraints];
    [self.issuesButton mas_makeConstraints: ^(MASConstraintMaker *make){
        make.height.equalTo(@60);
        make.width.equalTo(@(UIScreen.mainScreen.bounds.size.width - 40));
        make.top.equalTo(self.issuesButton.superview.mas_top);
    }];
    [self.issuesImage mas_makeConstraints: ^(MASConstraintMaker *make){
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
        make.centerY.equalTo(self.issuesButton);
        make.left.equalTo(self.issuesButton).with.offset(20);
     }];
    [self.pullButton mas_makeConstraints: ^(MASConstraintMaker *make){
        make.height.equalTo(@60);
        make.width.equalTo(@(UIScreen.mainScreen.bounds.size.width - 40));
        make.top.equalTo(self.issuesButton.mas_bottom).with.offset(0.5);
    }];
    [self.pullImage mas_makeConstraints: ^(MASConstraintMaker *make){
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
        make.centerY.equalTo(self.pullButton);
        make.left.equalTo(self.pullButton).with.offset(20);
     }];
    [self.repositoriesButton mas_makeConstraints: ^(MASConstraintMaker *make){
        make.height.equalTo(@60);
        make.width.equalTo(@(UIScreen.mainScreen.bounds.size.width - 40));
        make.top.equalTo(self.pullButton.mas_bottom).with.offset(0.5);
    }];
    [self.repositoriesImage mas_makeConstraints: ^(MASConstraintMaker *make){
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
        make.centerY.equalTo(self.repositoriesButton);
        make.left.equalTo(self.repositoriesButton).with.offset(20);
     }];
    [self.groupButton mas_makeConstraints: ^(MASConstraintMaker *make){
        make.height.equalTo(@60);
        make.width.equalTo(@(UIScreen.mainScreen.bounds.size.width - 40));
        make.top.equalTo(self.repositoriesButton.mas_bottom).with.offset(0.5);
    }];
    [self.groupImage mas_makeConstraints: ^(MASConstraintMaker *make){
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
        make.centerY.equalTo(self.groupButton);
        make.left.equalTo(self.groupButton).with.offset(20);
     }];
}

- (void)jumpToRepoView:(UIButton *)btn
{
    NSLog(@"clicked repositories button");
    if ( [self.delegate respondsToSelector:@selector(jumpToRepoVC:)] )
    {
        [self.delegate jumpToRepoVC: btn];
    }
    else
    {
        NSLog(@"BtnClick: haven't found in delegate.");
    }
}

@end
