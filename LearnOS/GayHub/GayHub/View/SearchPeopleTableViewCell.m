//
//  SearchPeopleTableViewCell.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/17.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "SearchPeopleTableViewCell.h"
#import <Masonry.h>
#import <SDWebImage.h>

@interface SearchPeopleTableViewCell ()

@property(nonatomic, strong) UIImageView *avatarImageView;
@property(nonatomic, strong) UILabel *accountLabel;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation SearchPeopleTableViewCell

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setAvaterUrl:(NSURL *)avatarUrl account:(NSString *)account name:(NSString *)name description:(NSString *)description 
{
    //sets
    [self.avatarImageView sd_setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"gayhub_white"]];
    self.avatarImageView.layer.masksToBounds = YES;
    [self.avatarImageView.layer setCornerRadius:5];
    self.accountLabel.text = account;
    // comment: 判断string，应该是 name && name.length > 0
    // re: 这里是因为我知道json解析出来不存在即为nil，所以直接判断是不是空
    if (name && name.length > 0) {
        self.nameLabel.text = [NSString stringWithString:name];
        self.nameLabel.hidden = NO;
    }else{
        self.nameLabel.hidden = YES;
    }
    if (description && description.length > 0) {
        self.descriptionLabel.text = [NSString stringWithString:description];
        self.descriptionLabel.hidden = NO;
    }else{
        self.descriptionLabel.hidden = YES;
    }
}


- (void)setUI
{
    self.backgroundColor = [UIColor blackColor];

    // inits
    self.avatarImageView = [[UIImageView alloc] init];

    self.accountLabel = [[UILabel alloc] init];
    self.accountLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightLight];
    self.accountLabel.textColor = [UIColor darkGrayColor];

    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];

    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.textColor = [UIColor whiteColor];
    self.descriptionLabel.numberOfLines = 0;
    [self.descriptionLabel sizeToFit];

    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.accountLabel];
    [self.contentView addSubview: self.nameLabel];
    [self.contentView addSubview:self.descriptionLabel];

    //avatar
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@50);
        make.height.equalTo(@50);
        make.top.equalTo(self.contentView.mas_top).with.offset(20);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).mas_offset(-10);
    }];
    //name
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@(UIScreen.mainScreen.bounds.size.width - 95));
        make.top.equalTo(self.avatarImageView);
        make.left.equalTo(self.avatarImageView.mas_right).mas_offset(10);
    }];
    //account
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@(UIScreen.mainScreen.bounds.size.width - 95));
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom);
    }];
    // person description
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@(UIScreen.mainScreen.bounds.size.width - 95));
        make.top.equalTo(self.accountLabel.mas_bottom);
        make.left.equalTo(self.nameLabel);
        make.bottom.equalTo(self.contentView).mas_offset(-10);
    }];

}


@end
