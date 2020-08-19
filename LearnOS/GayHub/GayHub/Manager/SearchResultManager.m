//
//  SearchResultManager.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/21.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "SearchResultManager.h"

@interface SearchResultManager ()

@property(nonatomic, strong) NSArray *privateSearchRepositoryResult;
@property(nonatomic, strong) NSArray *privateSearchPeopleResult;
@property(nonatomic, strong) NSMutableArray *privateHistoryData;
@property(nonatomic, strong) NSString *privateSearchText;
@property(nonatomic, strong) SearchResult *privateSearchResult;


@end


@implementation SearchResultManager

+ (instancetype)sharedManager
{
    static SearchResultManager *sharedManager = nil;
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
        _privateHistoryData = [NSMutableArray arrayWithObject:@"gay"];
        _privateSearchText = @"";
        _privateSearchResult = [[SearchResult alloc] init];
    }
    return self;
}

// universial set
- (void)setSearchText:(NSString *)seachText
{
    // comment: 这把属性直接暴露到外面就好了，重写一个setter干啥呢
    // re: 为了防止外部读取
    self.privateSearchText = seachText;
}

// guide data
- (NSArray *)guideCellData
{
    return @[
        @"book",
        @"Repositorys with ",
        @"person",
        @"People with ",
        @"arrow.right",
        @"Jump to "
    ];
}

#pragma mark - history data
- (NSArray *)getHistoryData
{
    return [self.privateHistoryData copy];
}

- (void)addHistoryData:(NSString *)data
{
    if ([self.privateHistoryData containsObject:data]) {
        [self.privateHistoryData removeObject:data];
    }
    [self.privateHistoryData insertObject:data atIndex:0];
}

- (void)removeHistoryDataAt:(NSInteger)index
{
    if (index < 0 || index >= [_privateHistoryData count]) {
        NSLog(@"index out of range!");
    }
    [self.privateHistoryData removeObjectAtIndex:index];
}

- (void)removeAllHistoryData
{
    [self.privateHistoryData removeAllObjects];
}

#pragma mark - repository search result

- (NSArray *)allSearchRepositories
{
    // comment: 同理，没必要单独写一个getter
    // re: 为了防止随意改写
    return [self.privateSearchRepositoryResult copy];
}

- (void)fetchRepositorySearchResultAsyncWithCompleteBlock:(void (^)(NSArray *))completeBlock
{
    NSString *prefix = @"https://api.github.com/search/repositories?q=";
    NSString *urlString = [prefix stringByAppendingString:_privateSearchText];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithArray:@[@"application/json"]]];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //json dealing
        NSError *merror = nil;
        SearchRepositoryResult *result = [MTLJSONAdapter modelOfClass:SearchRepositoryResult.class fromJSONDictionary:(NSDictionary *)responseObject error:&merror];
        if (result.totalCount == 0) {
            // TODO logy
        }
        self.privateSearchRepositoryResult = [result.items copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            !completeBlock ?: completeBlock(result.items);
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"faild to get");
        dispatch_async(dispatch_get_main_queue(), ^{
            !completeBlock ?: completeBlock([[NSArray alloc] init]);
        });
    }];
}

#pragma mark - people search result

- (NSArray *)allSearchPersons
{
    return [self.privateSearchPeopleResult copy];
}


- (void)fetchPersonSearchResultAsyncWithCompleteBlock:(void (^)(NSArray *))completeBlock
{
    NSString *prefix = @"https://api.github.com/search/users?q=";
    NSString *urlString = [prefix stringByAppendingString:self.privateSearchText];
    NSLog(@"%@", urlString);

    __weak typeof(self) weakSelf = self;

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithArray:@[@"application/json"]]];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // json dealing
        NSError *merror = nil;
        SearchPeopleResult *result = [MTLJSONAdapter modelOfClass:SearchPeopleResult.class fromJSONDictionary:(NSDictionary *)responseObject error:&merror];
        if (result.totalCount == 0) {
            NSLog(@"no data for it");
        }
//        self.privateSearchPeopleResult = [NSArray arrayWithArray:result.items];
        self.privateSearchPeopleResult = result.items;
//        NSLog(@"%@", result.items);
        // 防止循环引用
        [weakSelf completeUserInfoSyncForDetailWithFinishBlock:^(NSString *message){
            dispatch_async(dispatch_get_main_queue(), ^{
                !completeBlock ?: completeBlock([self.privateSearchPeopleResult copy]);
            });
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"faild to get");
        dispatch_async(dispatch_get_main_queue(), ^{
            !completeBlock ?: completeBlock([[NSArray alloc] init]);
        });
    }];
}

// 补全用户信息
- (void)completeUserInfoSyncForDetailWithFinishBlock:(void (^)(NSString *))finishBlock
{
    // 创建组
    dispatch_group_t group = dispatch_group_create();

    NSString *tokenSuffix = @"?access_token=4a0c17022a30f864e67311cb66c0c45116fe45bb";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    // 补全people
    for (User *singleUser in self.privateSearchPeopleResult) {
        dispatch_group_enter(group);
        singleUser.info = [[UserInfo alloc] init];
        NSString *urlStr = [singleUser.infoUrl absoluteString];
        urlStr = [urlStr stringByAppendingString:tokenSuffix];
        // 请求部分
        [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           //json dealing
           NSError *merror = nil;
           UserInfo *singleInfo = [MTLJSONAdapter modelOfClass:UserInfo.class fromJSONDictionary:(NSDictionary *)responseObject error:&merror];
           singleUser.info = singleInfo;
            dispatch_group_leave(group);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"faild to get in deep");
            dispatch_group_leave(group);
        }];
    }

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        !finishBlock ?: finishBlock(@"complete done");
    });
}

#pragma mark - search data

- (SearchResult *)searchResult
{
    return self.privateSearchResult;
}

- (void)fetchSearchedDataAsyncWithCompleteBlock:(void (^)(SearchResult *))completeBlock
{
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [self getRepositorySearchResultAsyncWithLimit];
    }];

    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [self getPersonSearchResultAsyncWithLimit];
    }];

    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        [self completeUserInfoSync];
    }];

    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            !completeBlock ?: completeBlock(self.privateSearchResult);
        });
    }];

    [op3 addDependency:op2];
    [op4 addDependency:op1];
    [op4 addDependency:op3];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperations:@[op1, op2, op3, op4] waitUntilFinished:NO];

}

- (void)getPersonSearchResultAsyncWithLimit
{
    // 创建信号量保证网络请求和方法同步结束
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    NSString *userPrefix = @"https://api.github.com/search/users?q=";
    NSString *suffix = @"&page=1&per_page=3";
    NSString *userUrlString = [userPrefix stringByAppendingString:_privateSearchText];
    userUrlString = [userUrlString stringByAppendingString:suffix];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:userUrlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // json dealing
        NSError *merror = nil;
        SearchPeopleResult *people = [MTLJSONAdapter modelOfClass:SearchPeopleResult.class fromJSONDictionary:(NSDictionary *)responseObject error:&merror];
        self.privateSearchResult.peopleResult = people;
        NSLog(@"users get!");
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"faild to get in people");
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)getRepositorySearchResultAsyncWithLimit
{
    // 创建信号量保证网络请求和方法同步结束
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    NSString *repoPrefix = @"https://api.github.com/search/repositories?q=";
    NSString *suffix = @"&page=1&per_page=3";
    NSString *repoUrlString = [repoPrefix stringByAppendingString:_privateSearchText];
    repoUrlString = [repoUrlString stringByAppendingString:suffix];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithArray:@[@"application/json"]]];

    // repo
    [manager GET:repoUrlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *merror = nil;
        SearchRepositoryResult *repos = [MTLJSONAdapter modelOfClass:SearchRepositoryResult.class fromJSONDictionary:(NSDictionary *)responseObject error:&merror];
        self.privateSearchResult.repoResult = repos;
        NSLog(@"repos get!");
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"faild in get repos");
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

// 补全用户信息
- (void)completeUserInfoSync
{
    // 创建信号量保证网络请求和方法同步结束
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    // 创建组
    dispatch_group_t group = dispatch_group_create();

    NSString *tokenSuffix = @"?access_token=4a0c17022a30f864e67311cb66c0c45116fe45bb";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    // 补全people
    for (User *singleUser in self.privateSearchResult.peopleResult.items) {
        dispatch_group_enter(group);
        singleUser.info = [[UserInfo alloc] init];
        NSString *urlStr = [singleUser.infoUrl absoluteString];
        urlStr = [urlStr stringByAppendingString:tokenSuffix];
        NSLog(@"%@", urlStr);
        // 请求部分
        [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           //json dealing
           NSError *merror = nil;
           UserInfo *singleInfo = [MTLJSONAdapter modelOfClass:UserInfo.class fromJSONDictionary:(NSDictionary *)responseObject error:&merror];
           singleUser.info = singleInfo;
            dispatch_group_leave(group);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"faild to get in deep");
            dispatch_group_leave(group);
        }];
    }

    dispatch_group_notify(group, dispatch_get_global_queue(5, 0), ^{
        dispatch_semaphore_signal(semaphore);
    });

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

@end
