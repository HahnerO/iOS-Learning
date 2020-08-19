//
//  SearchRepositoryResult.h
//  GayHub
//
//  Created by 王籽涵 on 2020/7/23.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Repository.h"
#import <Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchRepositoryResult : MTLModel<MTLJSONSerializing>

@property(nonatomic, strong) NSNumber *totalCount;
@property(nonatomic, strong) NSArray *items;

@end

NS_ASSUME_NONNULL_END
