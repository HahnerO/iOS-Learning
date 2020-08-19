//
//  HomeScrollView.h
//  GayHub
//
//  Created by 王籽涵 on 2020/7/12.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeScrollView : UIScrollView

@property(nonatomic, strong) HomeContentView* contentView;


@end

NS_ASSUME_NONNULL_END
