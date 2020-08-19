//
//  MyWorkView.h
//  GayHub
//
//  Created by 王籽涵 on 2020/7/10.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JumpDelegate <NSObject>

- (void)jumpToRepoVC:(UIButton *)btn;

@end

@interface MyWorkView : UIView

@property(nonatomic, strong) UIButton *repositoriesButton;
@property(nonatomic, strong) UIButton *issuesButton;
@property(nonatomic, strong) UIButton *pullButton;
@property(nonatomic, strong) UIButton *groupButton;

@property (weak, nonatomic) id<JumpDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
