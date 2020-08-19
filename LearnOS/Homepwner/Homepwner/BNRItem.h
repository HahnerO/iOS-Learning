//
//  BNRItem.h
//  Homepwner
//
//  Created by 王籽涵 on 2020/7/3.
//  Copyright © 2020 王籽涵. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRItem : NSObject <NSCoding>

@property(nonatomic, copy) NSString *itemName;
@property(nonatomic, copy) NSString *serialNumber;
@property(nonatomic) int valueInDollars;
@property(nonatomic, readonly, strong) NSDate *dateCreated;
@property(nonatomic) NSUUID *itemKey;

+ (instancetype)randomItem;

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNUmber;
- (instancetype)initWithItemName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
