//
//  SearchResult.h
//  GayHub
//
//  Created by 王籽涵 on 2020/7/27.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchPeopleResult.h"
#import "SearchRepositoryResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchResult : NSObject

@property(nonatomic, strong) SearchRepositoryResult *repoResult;
@property(nonatomic, strong) SearchPeopleResult *peopleResult;

@end

NS_ASSUME_NONNULL_END
