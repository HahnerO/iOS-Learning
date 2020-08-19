//
//  UserInfo.h
//  GayHub
//
//  Created by 王籽涵 on 2020/7/21.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : MTLModel<MTLJSONSerializing>

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *bio;

@end

NS_ASSUME_NONNULL_END
