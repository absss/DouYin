//
//  NSString+Util.h
//  CiticsfFinanceApp
//
//  Created by hehaichi on 2019/8/12.
//  Copyright © 2019 CITICSF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Util)
///求文字高度
- (CGFloat)heightWithFixedWidth:(CGFloat)fixedwidth font:(UIFont *)font;

 ///求文字宽度
- (CGFloat)widthWithFixedHeight:(CGFloat)fixedheight font:(UIFont *)font;

/// 转dictionary
- (NSDictionary *)jsonStringToDictionionary;

/// 转为字符串
+ (NSString *)objectToString:(id)object;

/// 拨打电话
- (void)callSelf;

///是否为电话号码
- (BOOL)isPhoneNumber;
/**
 电话号码部分隐藏处理
 12345678912 -> 123****8912
 
 @return 返回结果
 */
-(NSString *)safePhoneNumber;

/// 简单验证身份证
- (BOOL)validateIDCard;
@end

