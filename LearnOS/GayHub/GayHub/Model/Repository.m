//
//  Repository.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/13.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "Repository.h"
#import "Owner.h"

@implementation Repository

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"fullName":@"full_name",
        @"name":@"name",
        @"repositoryDescription":@"description",
        @"stargazersCount":@"stargazers_count",
        @"language":@"language",
        @"owner":@"owner"
    };
}

+ (NSValueTransformer *)ownerJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:Owner.class];
}


@end
