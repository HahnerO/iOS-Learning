//
//  SearchPeopleResult.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/23.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "SearchPeopleResult.h"
#import "User.h"

@implementation SearchPeopleResult

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"totalCount":@"total_count",
        @"items":@"items"
    };
}

+ (NSValueTransformer *)itemsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:User.class];
}

@end
