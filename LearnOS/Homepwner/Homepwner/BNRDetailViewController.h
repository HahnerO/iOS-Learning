//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by 王籽涵 on 2020/7/6.
//  Copyright © 2020 王籽涵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNRItem;

NS_ASSUME_NONNULL_BEGIN

@interface BNRDetailViewController : UIViewController

@property(nonatomic, strong) BNRItem *item;

//- (instancetype)initForNewItem:(BOOL)isNew;

@end

NS_ASSUME_NONNULL_END
