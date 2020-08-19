//
//  BNRItemStore.h
//  Homepwner
//
//  Created by 王籽涵 on 2020/7/3.
//  Copyright © 2020 王籽涵. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BNRItem;
@interface BNRItemStore : NSObject

@property(nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
- (BOOL)saveChanges;

@end

NS_ASSUME_NONNULL_END
