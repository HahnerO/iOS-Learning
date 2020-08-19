//
//  HomeContentView.h
//  GayHub
//
//  Created by 王籽涵 on 2020/7/10.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyWorkView;

NS_ASSUME_NONNULL_BEGIN

@interface HomeContentView : UIView

@property(nonatomic, strong) UILabel *workLabel;
@property(nonatomic, strong) MyWorkView *workView;

@end

NS_ASSUME_NONNULL_END
