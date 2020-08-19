//
//  Owner.h
//  GayHub
//
//  Created by 王籽涵 on 2020/7/13.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface Owner : MTLModel<MTLJSONSerializing>

@property(nonatomic, strong) NSURL *avatarUrl;
@property(nonatomic, strong) NSString *account;

@end

NS_ASSUME_NONNULL_END
