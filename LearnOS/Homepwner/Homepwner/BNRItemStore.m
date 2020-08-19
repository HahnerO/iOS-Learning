//
//  BNRItemStore.m
//  Homepwner
//
//  Created by 王籽涵 on 2020/7/3.
//  Copyright © 2020 王籽涵. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore()
@property(nonatomic) NSMutableArray *privateItems;
@end

@implementation BNRItemStore

//这是个单例
+ (instancetype)sharedStore {
    static BNRItemStore *sharedStore = nil;
    if (!sharedStore) {
        
        sharedStore = [[self alloc] initPrivate];
    }
//    NSLog(@"Single Store has been created!");
    return sharedStore;
}

// === 数据操作方啊 ===

// 获得所有item
- (NSArray *)allItems {
    return self.privateItems;
}

//添加item
- (BNRItem *)createItem {
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
//    NSLog(@"%lu", (unsigned long)[[self allItems] count]);
    return item;
}

//删除指定item
- (void)removeItem:(BNRItem *)item {
    [self.privateItems removeObjectIdenticalTo:item];
    return;
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    
    BNRItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
}


//=== local storage

- (NSString *)itemArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *ducumentDirectory = [documentDirectories firstObject];
    return [ducumentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges {
    NSString *path = [self itemArchivePath];
    return[NSKeyedArchiver archivedDataWithRootObject:self.privateItems requiringSecureCoding:YES error:<#(NSError *__autoreleasing  _Nullable * _Nullable)#>];
    
}



// =====下面是初始化方法======

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                        reason:@"Use +[BNRItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}



@end
