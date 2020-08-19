//
//  HNLine.h
//  TouchTracker
//
//  Created by 王籽涵 on 2020/7/6.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HNLine : NSObject

@property(nonatomic) CGPoint begin;
@property(nonatomic) CGPoint end;

//check out leaks
@property(nonatomic, strong) NSMutableArray *containArray;

@end

NS_ASSUME_NONNULL_END
