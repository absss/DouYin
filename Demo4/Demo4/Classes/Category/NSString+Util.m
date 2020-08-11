//
//  NSString+Util.m
//  CiticsfFinanceApp
//
//  Created by hehaichi on 2019/8/12.
//  Copyright © 2019 CITICSF. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)

- (CGFloat)heightWithFixedWidth:(CGFloat)fixedWidth font:(UIFont *)font {
    CGRect rect = [self boundingRectWithSize:CGSizeMake(fixedWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return  CGRectGetHeight(rect);
}

- (CGFloat)widthWithFixedHeight:(CGFloat)fixedHeight font:(UIFont *)font {
    CGRect rect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, fixedHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return CGRectGetWidth(rect);
}


- (NSDictionary *)jsonStringToDictionionary {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        return nil;
    }
    return dic;
}

+ (NSString *)objectToString:(id)object {
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

// 拨打电话
- (void)callSelf {
    if (self.length == 0) {
        return;
    }
    NSString *str=[[NSString alloc] initWithFormat:@"telprompt://%@",self];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

//验证手机号码
- (BOOL)isPhoneNumber {
    if (self.length == 0) {
        return NO;
    }
    //首先验证是不是手机号码
    NSString *regex = @"^(0|86|17951)?(1[0-9][0-9])[0-9]{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
   
}

// 返回隐藏中间四位的手机号
-(NSString *)safePhoneNumber{
    if (![self isPhoneNumber]) {
        return self;
    }
    return [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}

- (BOOL)validateIDCard {//idNumber为传入的身份证号
    NSString *idNumberRegex = @"^(\\d{17})(\\d|[xX])$";//正则判断idNumber是17位数字加1位数字校验码或大小写xX
    NSPredicate *idNumberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",idNumberRegex];
    if(![idNumberPredicate evaluateWithObject:self]){
        NSLog(@"你输入的身份证长度或格式错误");
        return NO;
    } else {
        return YES;
    }
}
@end
