//
//  UIColor+Util.m
//  CiticsfFinanceApp
//
//  Created by SongXie on 15/4/9.
//  Copyright (c) 2015年 CITIC Futures Co., Ltd. All rights reserved.
//

#import "UIColor+Util.h"
#import "AppDelegate.h"

@implementation UIColor (Util)
//通过颜色来生成一个纯色图片
- (UIImage *)imageWithSize:(CGSize)size {
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return nil;
    }
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
