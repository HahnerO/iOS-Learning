//
//  UserStateManager.h
//  GayHub
//
//  Created by 王籽涵 on 2020/7/8.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserState;

@interface UserStateManager : NSObject

@property(nonatomic, strong) UserState *userState;

+ (instancetype)sharedManager;

- (void)userDidLogin;

@end
