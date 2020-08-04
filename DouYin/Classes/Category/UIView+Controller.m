//
//  UIView+Responder.m
//  CiticsfFinanceApp
//
//  Created by hehaichi on 2019/8/22.
//  Copyright © 2019 CITICSF. All rights reserved.
//

#import "UIView+Controller.h"

@implementation UIView (Controller)

- (UIViewController * )viewController {
    UIResponder * next = [self nextResponder];
    while (next!=nil) {
        if([next isKindOfClass:[UIViewController class]]){
            return (UIViewController * )next;
        }
        next = [next nextResponder];
    }
    return nil;
}
//获取导航控制器
- (UINavigationController * )navigationController {
    UIResponder * next = [self nextResponder];
    while (next!=nil) {
        if([next isKindOfClass:[UINavigationController class]]){
            return (UINavigationController * )next;
        }
        next = [next nextResponder];
    }
    return nil;
}

//获取标签控制器
- (UITabBarController * )tabBarController {
    UIResponder * next = [self nextResponder];
    while (next!=nil) {
        if([next isKindOfClass:[UITabBarController class]]){
            return (UITabBarController * )next;
        }
        next = [next nextResponder];
    }
    return nil;
}

//获取主窗口
- (UIWindow * )rootWindow {
    UIResponder * next = [self nextResponder];
    while (next!=nil) {
        if([next isKindOfClass:[UIWindow class]]){
            return (UIWindow * )next;
        }
        next = [next nextResponder];
    }
    return nil;
}


@end
