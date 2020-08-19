//
//  UserStateManager.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/8.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "UserStateManager.h"
#import "UserState.h"
#import <UIKit/UIKit.h>

@interface UserStateManager ()

@property(nonatomic, strong) UserState *privateUserState;

@end

@implementation UserStateManager

// multithread-protection
+ (instancetype)sharedManager
{
    static UserStateManager *sharedManager = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        sharedManager = [[self alloc] initPrivate];
    });

    return sharedManager;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _privateUserState = [[UserState alloc] init];
    }
    return self;
}

- (UserState *)userState
{
    return self.privateUserState;
}

- (void)userDidLogin
{
    NSLog(@"User Did Login!");
    self.privateUserState.didLogin = YES;
}

@end
