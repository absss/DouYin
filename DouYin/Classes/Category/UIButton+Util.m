//
//  UIButton+Util.m
//  CiticsfFinanceApp
//
//  Created by hehaichi on 2019/6/14.
//  Copyright © 2019 CITICSF. All rights reserved.
//

#import "UIButton+Util.h"
#import "UIColor+Util.h"

@implementation UIButton (Util)
- (void)setBackgroundImageWithColor:(UIColor *)color {
    UIImage *bgImg = [color imageWithSize:CGSizeMake(1, 1)];
    [self setBackgroundImage:bgImg forState:UIControlStateNormal];
}
@end
