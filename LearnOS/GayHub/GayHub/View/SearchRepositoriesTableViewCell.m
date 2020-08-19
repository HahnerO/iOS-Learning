//
//  SearchRepositoriesTableViewCell.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/17.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "SearchRepositoriesTableViewCell.h"
#import <Masonry.h>
#import <SDWebImage.h>

@interface SearchRepositoriesTableViewCell ()

@property(nonatomic, strong) UIImageView *avatarImageView;
@property(nonatomic, strong) UILabel *accountLabel;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *descriptionLabel;
@property(nonatomic, strong) UILabel *starCountLabel;
@property(nonatomic, strong) UILabel *languageLabel;
@property(nonatomic, strong) UIImageView *starImageView;
@property(nonatomic, strong) UIImageView *languageImageView;

@end

@implementation SearchRepositoriesTableViewCell

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setAvaterUrl:(NSURL *)avatarUrl account:(NSString *)account name:(NSString *)name description:(NSString *)description starsCount:(NSInteger)starsCount language:(nullable NSString *)language
{
    //sets
    [self.avatarImageView sd_setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"gayhub_white"]];
    self.accountLabel.text = account;
    self.nameLabel.text = name;
    self.descriptionLabel.text = description;
    self.starCountLabel.text = [NSString stringWithFormat:@"%ld", (long)starsCount];
    if (language && ![language  isEqual:@""]) {
        self.languageLabel.text = [NSString stringWithFormat:@"%@", language];
        self.languageLabel.hidden = NO;
        self.languageImageView.hidden = NO;
    }else{
        self.languageLabel.text = nil;
        self.languageLabel.hidden = YES;
        self.languageImageView.hidden = YES;
    }
}


- (void)setUI
{
    self.backgroundColor = [UIColor blackColor];

    // inits
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.layer.masksToBounds = YES;
    [self.avatarImageView.layer setCornerRadius:5];

    self.accountLabel = [[UILabel alloc] init];
    self.accountLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightLight];
    self.accountLabel.textColor = [UIColor whiteColor];

    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:25 weight:UIFontWeightBold];

    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.textColor = [UIColor whiteColor];
    self.descriptionLabel.numberOfLines = 0;
    [self.descriptionLabel sizeToFit];

    self.starImageView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"star.fill"]];
    self.starImageView.tintColor = [UIColor orangeColor];

    self.starCountLabel = [[UILabel alloc] init];
    self.starCountLabel.textColor = [UIColor darkGrayColor];
    [self.starCountLabel sizeToFit];

    self.languageImageView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"circle.fill"]];
    self.languageImageView.tintColor = [UIColor blueColor];

    self.languageLabel = [[UILabel alloc] init];
    self.languageLabel.textColor = [UIColor darkGrayColor];
    [self.languageLabel sizeToFit];

    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.languageImageView];
    [self.contentView addSubview:self.languageLabel];
    [self.contentView addSubview:self.accountLabel];
    [self.contentView addSubview: self.nameLabel];
    [self.contentView addSubview:self.descriptionLabel];
    [self.contentView addSubview: self.starImageView];
    [self.contentView addSubview:self.starCountLabel];

    //avatar
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.top.equalTo(self.contentView.mas_top).with.offset(20);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
    }];
    //account
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@(UIScreen.mainScreen.bounds.size.width - 80));
        make.height.equalTo(@25);
        make.left.equalTo(self.avatarImageView.mas_right).with.offset(5);
        make.top.equalTo(self.contentView.mas_top).with.offset(25);
//        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
    }];
    //name
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@(UIScreen.mainScreen.bounds.size.width - 40));
        make.height.equalTo(@30);
        make.top.equalTo(self.avatarImageView.mas_bottom).with.offset(5);
        make.left.equalTo(self.avatarImageView.mas_left);
//        make.right.equalTo(self.accountLabel.mas_right);
    }];
    // repo description
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@(UIScreen.mainScreen.bounds.size.width - 40));
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.avatarImageView.mas_left);
//        make.right.equalTo(self.accountLabel.mas_right);
    }];
    // star image
    [self.starImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.left.equalTo(self.avatarImageView.mas_left);
        make.bottom.equalTo(self.contentView).with.offset(-20);
        make.top.equalTo(self.descriptionLabel.mas_bottom).with.offset(10);

    }];
    // star count label
    [self.starCountLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@20);
        make.top.equalTo(self.starImageView.mas_top).priorityHigh();
        make.left.equalTo(self.starImageView.mas_right).with.offset(5);
        make.bottom.equalTo(self.starImageView.mas_bottom);
    }];
    // language-views set
    [self.languageImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@20);
        make.width.equalTo(@20);
        make.top.equalTo(self.starImageView.mas_top);
        make.bottom.equalTo(self.starImageView.mas_bottom);
        make.left.equalTo(self.starCountLabel.mas_right).with.offset(10);
    }];
    [self.languageLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@20);
        make.left.equalTo(self.languageImageView.mas_right).with.offset(5);
        make.top.equalTo(self.starImageView.mas_top);
        make.bottom.equalTo(self.starImageView.mas_bottom);
    }];

}


@end
