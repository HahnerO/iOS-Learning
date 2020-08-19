//
//  User.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/21.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "User.h"

@implementation User

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"avatarUrl":@"avatar_url",
        @"infoUrl":@"url",
        @"account":@"login",
    };
}

+ (NSValueTransformer *)avatarUrlTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)inforUrlTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
