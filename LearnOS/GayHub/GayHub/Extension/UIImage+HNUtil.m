//
//  UIImage+HNUtil.m
//  GayHub
//
//  Created by 王籽涵 on 2020/7/10.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "UIImage+HNUtil.h"

@implementation UIImage (HNUtil)

+ (UIImage *)createImageWithColor: (UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
