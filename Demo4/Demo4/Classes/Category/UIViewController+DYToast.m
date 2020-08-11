//
//  UIViewController+DYToast.m
//  CiticsfFinanceApp
//
//  Created by hehaichi on 2020/6/9.
//  Copyright © 2020 CITICSF. All rights reserved.
//

#import "UIViewController+DYToast.h"
#import "NSString+Util.h"

@implementation UIViewController (DYToast)

- (UILabel *)getToastLabel {
    UILabel *toastLabel = [UILabel new];
    toastLabel = [UILabel new];
    toastLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    toastLabel.textColor = UIColor.whiteColor;
    toastLabel.numberOfLines = 0;
    toastLabel.layer.masksToBounds = YES;
    toastLabel.layer.cornerRadius = 5;
    toastLabel.textAlignment = NSTextAlignmentCenter;
    toastLabel.tag = 99887;
    return toastLabel;
}

- (void)toastShow:(NSString *)msg {
    return [self toastShow:msg sec:3];
}

- (void)toastShowSucc:(NSString *)msg {
    return [self toastShow:msg];
}

- (void)toastShowFail:(NSString *)msg {
    return [self toastShow:msg];
}

- (void)toastHidden {
    return [self toastHidden:0];
}

- (void)toastShow:(NSString *)msg sec:(NSInteger)sec {
    UILabel *label = [self.view viewWithTag:99887];
    if (label) {
        return;
    }
    UILabel *toast = [self getToastLabel];
    toast.alpha = 0;
    toast.text = msg;
    CGFloat H = 35;
    CGFloat maxW = CGRectGetWidth(self.view.frame) - 20;
    CGFloat w =  [msg widthWithFixedHeight:20 font:toast.font]+20;
    CGFloat h =  [msg heightWithFixedWidth:maxW font:toast.font];
    if (w > maxW) {
        toast.frame = CGRectMake(0, 0, maxW, h);
   
    } else {
        toast.frame = CGRectMake(0, 0, w, H);
    }
    toast.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2);
    [self.view addSubview:toast];
    
    [UIView animateWithDuration:0.5 animations:^{
        toast.alpha = 1;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [toast removeFromSuperview];
    });
}

- (void)toastHidden:(NSInteger)sec {
    if (![self.view viewWithTag:99887]) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIView * v = [self.view viewWithTag:99887];
        [v removeFromSuperview];
    });
}
@end
