//
//  Repository.h
//  GayHub
//
//  Created by 王籽涵 on 2020/7/13.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
#import "Owner.h"

NS_ASSUME_NONNULL_BEGIN

@interface Repository : MTLModel<MTLJSONSerializing>

@property(nonatomic, strong) NSString *fullName;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *repositoryDescription;
@property(nonatomic, strong) NSNumber *stargazersCount;
@property(nonatomic, strong) NSString *language;
@property(nonatomic, strong) Owner *owner;

@end

NS_ASSUME_NONNULL_END
