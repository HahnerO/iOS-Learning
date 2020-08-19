//
//  BNRItem.m
//  Homepwner
//
//  Created by 王籽涵 on 2020/7/3.
//  Copyright © 2020 王籽涵. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

// === Coding ====
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.itemName forKey:@"itemName"];
    [coder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [coder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [coder encodeInt:self.valueInDollars forKey:@"valueInDollars"];
    [coder encodeObject:self.itemKey forKey:@"itemKey"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _itemName = [coder decodeObjectForKey:@"itemName"];
        _serialNumber = [coder decodeObjectForKey:@"serialNumber"];
        _dateCreated = [coder decodeObjectForKey:@"dateCreated"];
        _itemKey = [coder decodeObjectForKey:@"itemKey"];
        _valueInDollars = [coder decodeIntForKey:@"valueInDollars"];
    }
    return self;
}

// ===
+ (instancetype)randomItem {
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    NSArray *randomNouLisst = @[@"Bear", @"Spork", @"Mac"];
    
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNouLisst count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                            [randomAdjectiveList objectAtIndex:adjectiveIndex],
                            [randomNouLisst objectAtIndex:nounIndex]];
    int randomValue = arc4random() % 100;
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10];
    BNRItem *newItem = [[self alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    return newItem;
}

- (NSString *)description {
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
                                   self.itemName,
                                   self.serialNumber,
                                   self.valueInDollars,
                                   self.dateCreated];
    return descriptionString;
}

- (instancetype)init {
    return [self initWithItemName:@"Item"];
}

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNUmber {
    self = [super init];
    if (self) {
        _itemName = name;
        _serialNumber = sNUmber;
        _valueInDollars = value;
        _dateCreated = [[NSDate alloc] init];
    }
    return self;
}

- (instancetype)initWithItemName:(NSString *)name {
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}

@end
