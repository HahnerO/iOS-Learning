//
//  SearchRepositoriesTableViewCell.h
//  GayHub
//
//  Created by 王籽涵 on 2020/7/17.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchRepositoriesTableViewCell : UITableViewCell

- (void)setAvaterUrl:(NSURL *)avatarUrl account:(NSString *)account name:(NSString *)name description:(NSString *)description starsCount:(NSInteger)starsCount language:(nullable NSString *)language;

@end

NS_ASSUME_NONNULL_END
