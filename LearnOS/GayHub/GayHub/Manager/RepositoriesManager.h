//
//  RepositoriesManager.h
//  GayHub
//
//  Created by 王籽涵 on 2020/7/13.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Repository.h"

NS_ASSUME_NONNULL_BEGIN

@interface RepositoriesManager : NSObject

@property(nonatomic, strong, readonly) NSArray *allRepositories;

+ (instancetype)sharedManager;

- (void)fetchRepositoriesWithCompleteBlock:(void (^)(NSArray * _Nonnull))completeBlock;
- (void)deleteRepoAtIndex:(NSInteger)index;

// test
- (NSArray *)testArr;
- (void)removeTestArr;

@end

NS_ASSUME_NONNULL_END
