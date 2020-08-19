//
//  SearchResultManager.h
//  GayHub
//
//  Created by 王籽涵 on 2020/7/21.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchResult.h"
#import "SearchRepositoryResult.h"
#import "SearchPeopleResult.h"
#import <AFNetworking.h>
#import <Mantle.h>
#import "Repository.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultManager : NSObject

@property(nonatomic, strong) NSArray *allSearchRepositories;
@property(nonatomic, strong) NSArray *allSearchPersons;
@property(nonatomic, strong) SearchResult *searchResult;

+ (instancetype)sharedManager;

// universial data dealing
- (void)setSearchText:(NSString *)seachText;

// guide cell data set
- (NSArray *)guideCellData;

// deal with history data
- (NSArray *)getHistoryData;
- (void)addHistoryData:(NSString *)data;
- (void)removeHistoryDataAt:(NSInteger)index;
- (void)removeAllHistoryData;

// repository result cell data
- (void)fetchRepositorySearchResultAsyncWithCompleteBlock:(void (^)(NSArray *))completeBlock;

// persons result cell data
- (void)fetchPersonSearchResultAsyncWithCompleteBlock:(void (^)(NSArray *))completeBlock;

// searched result cell data
- (void)fetchSearchedDataAsyncWithCompleteBlock:(void (^)(SearchResult *))completeBlock;

@end

NS_ASSUME_NONNULL_END
