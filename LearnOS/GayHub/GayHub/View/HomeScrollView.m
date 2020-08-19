//
//  HomeScrollView.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/12.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "HomeScrollView.h"
#import <Masonry.h>

@implementation HomeScrollView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.showsVerticalScrollIndicator = NO;
        HomeContentView *contentView = [[HomeContentView alloc] init];
        _contentView = contentView;
        [self setContentOffset:CGPointMake(0, 50)];
        [self addSubview:_contentView];
//        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@(UIScreen.mainScreen.bounds.size.width));
        make.top.lessThanOrEqualTo(self.contentView.workLabel).with.offset(20).priorityHigh();
        make.bottom.greaterThanOrEqualTo(self.contentView.workView).with.offset(20).priorityHigh();
    }];
}

@end
