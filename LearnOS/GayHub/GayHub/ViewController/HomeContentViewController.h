//
//  HomeContentViewController.h
//  GayHub
//
//  Created by 王籽涵 on 2020/7/10.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeScrollView.h"


// comment: 为什么要实现 UIScrollViewDelegate 这个协议
// reply: 我一开始以为不实现就不能滚动...
@interface HomeContentViewController : UIViewController

@property(nonatomic, strong) HomeScrollView *homeView;

@end
