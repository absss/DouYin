//
//  UIButton+CountDown.m
//  Demo
//
//  Created by hehaichi on 18/5/11.
//  Copyright © 2018年 hehaichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CountDown)
/**
 计数完成之后显示的标题，默认：重新获取
 */
@property (nonatomic, copy) NSString *titleWhenEndCountDown;

/**
 计数格式，默认：@"%d秒"
 */
@property (nonatomic, copy) NSString *countDownFormatter;

/**
 开始计时
 */
- (void)startToCountDown;


@end
