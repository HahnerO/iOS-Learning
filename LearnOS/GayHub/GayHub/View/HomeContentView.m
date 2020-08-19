//
//  HomeContentView.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/10.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "HomeContentView.h"
#import <Masonry.h>
#import "MyWorkView.h"

@interface HomeContentView ()

@end

@implementation HomeContentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }

    [self createSubviews];
    [self setNeedsUpdateConstraints];
    return self;
}


- (void)createSubviews
{

    UILabel *workLabel = [[UILabel alloc] init];
    workLabel.text = @"My Work";
    workLabel.textColor = [UIColor whiteColor];
    workLabel.font = [UIFont boldSystemFontOfSize:20];
    self.workLabel = workLabel;

    MyWorkView *workView = [[MyWorkView alloc] init];
    self.workView = workView;
    [self.workView.layer setMasksToBounds:YES];
    [self.workView.layer setCornerRadius:20];

    [self addSubview:self.workLabel];
    [self addSubview:self.workView];
    self.backgroundColor = [UIColor blackColor];
}

- (void)updateConstraints
{
    [super updateConstraints];
    [self.workLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self).with.offset(20);
        make.centerY.equalTo(self.mas_top).with.offset(20);
        }];
    [self.workView mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@(UIScreen.mainScreen.bounds.size.width - 40));
        make.height.equalTo(@240);
        make.left.equalTo(self).with.offset(20);
        make.top.equalTo(self.workLabel.mas_bottom).with.offset(20);
    }];
    
}

@end
