//
//  UIViewController+DYToast.h
//  CiticsfFinanceApp
//
//  Created by hehaichi on 2020/6/9.
//  Copyright © 2020 CITICSF. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface UIViewController (DYToast)
- (void)toastShow:(NSString *)msg;
- (void)toastHidden;
- (void)toastShowSucc:(NSString *)msg;
- (void)toastShowFail:(NSString *)msg;

- (void)toastShow:(NSString *)msg sec:(NSInteger)sec;
- (void)toastHidden:(NSInteger)sec;


@end


