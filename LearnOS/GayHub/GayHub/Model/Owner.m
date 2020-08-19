//
//  Owner.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/13.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "Owner.h"

@implementation Owner

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"avatarUrl":@"avatar_url",
        @"account":@"login"
    };
}

+ (NSValueTransformer *)avatarUrlTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}


@end

