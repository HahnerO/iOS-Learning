//
//  RepositoriesManager.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/13.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "RepositoriesManager.h"
#import <Mantle.h>
#import <AFNetworking.h>

@interface RepositoriesManager ()

@property(nonatomic, strong) NSMutableArray *privateRepositories;
@property(nonatomic, strong) NSMutableArray *privateTestArr;

@end

@implementation RepositoriesManager

// multithread-protection
+ (instancetype)sharedManager
{
    static RepositoriesManager *sharedManager = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        sharedManager = [[self alloc] initPrivate];
    });
    return sharedManager;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _privateRepositories = [[NSMutableArray alloc] init];
        _privateTestArr = [NSMutableArray arrayWithArray:@[@"aaa", @"bbb", @"ccc"]];
    }
    return self;
}

#pragma mark - data dealing

- (NSArray *)allRepositories
{
    return [self.privateRepositories copy];
}

/*
 获取个人仓库信息
 1.通过固定api获取数据
 2.mantle模型转化
 3.block中异步通知已经完成刷新
 */

// AFN way fetch in async
- (void)fetchRepositoriesWithCompleteBlock:(void (^)(NSArray *))completeBlock
{
    NSString *urlString = @"https://api.github.com/users/WhatTheNathan/repos?access_token=";

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithArray:@[@"application/json"]]];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //json dealing
        NSError *merror = nil;
        NSArray *allItems = [MTLJSONAdapter modelsOfClass:Repository.class fromJSONArray:(NSArray *)responseObject error:&merror];
        self.privateRepositories = [NSMutableArray arrayWithArray:allItems];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"repos_get" object:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            !completeBlock ?: completeBlock(allItems);
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"faild to get");
        dispatch_async(dispatch_get_main_queue(), ^{
            !completeBlock ?: completeBlock([[NSArray alloc] init]);
        });
    }];
}

// delete one repo
- (void)deleteRepoAtIndex:(NSInteger)index
{
    // range judgement
    if (index >= [self.privateRepositories count]) {
        NSLog(@"Removing index out of range!");
        return;
    }
    NSLog(@"removing repo: %@", [_privateRepositories objectAtIndex:index]);
    [self.privateRepositories removeObjectAtIndex:index];
}

#pragma mark - testArr
- (NSArray *)testArr
{
    return self.privateTestArr;
}

- (void)removeTestArr
{
    [self.privateTestArr removeAllObjects];
}
@end
