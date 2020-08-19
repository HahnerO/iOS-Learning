//
//  UserInfo.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/21.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"name":@"name",
        @"bio":@"bio"
    };
}

@end
