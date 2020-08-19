//
//  User.h
//  GayHub
//
//  Created by 王籽涵 on 2020/7/21.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface User : MTLModel<MTLJSONSerializing>

@property(nonatomic, strong) NSURL *avatarUrl;
@property(nonatomic, strong) NSURL *infoUrl;
@property(nonatomic, strong) NSString *account;
// info属性并不通过mantle初始化，而是在获得infourl时加载并存储进user
@property(nonatomic, strong) UserInfo *info;

@end

NS_ASSUME_NONNULL_END
