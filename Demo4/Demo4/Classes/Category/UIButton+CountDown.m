//
//  UIButton+CountDown.m
//  Demo
//
//  Created by hehaichi on 18/5/11.
//  Copyright © 2018年 hehaichi. All rights reserved.
//

#import "UIButton+CountDown.h"
#import <objc/runtime.h>

#define MAXTIMERCOUNT 60

@interface UIButton ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger remainTime;
@property (nonatomic, strong) NSDate *timerStartDate;
@end

static char timerKey, remainTimeKey, timerStartDateKey,titleWhenEndCountDownKey,countDownFormatterKey;

@implementation UIButton (CountDown)

- (void)startToCountDown {
    self.enabled = NO;
    self.remainTime = MAXTIMERCOUNT;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(start) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self updateTitle];
    self.timerStartDate = [NSDate date];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appDidBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)start {
    self.remainTime--;
    if (self.remainTime == 0) {
        [self stop];
    } else {
        [self updateTitle];
    }
}

- (void)stop {
    self.enabled = YES;
    NSString * title = @"重新获取";
    if(self.titleWhenEndCountDown.length > 0){
        title = self.titleWhenEndCountDown;
    }
    [self setTitle:title forState:UIControlStateNormal];
    [self.timer invalidate];
    self.timer = nil;
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    self.timerStartDate = nil;
}

- (void)updateTitle {
    NSString * formatter = @"%d秒";
    if(self.countDownFormatter.length > 0){
        formatter = self.countDownFormatter;
    }
    [self setTitle:[NSString stringWithFormat:formatter,(int)self.remainTime] forState:UIControlStateDisabled];
}

- (void)appDidBecomeActive {
    if (self.timerStartDate) {
        NSInteger seconds = [[NSDate date] timeIntervalSinceDate:self.timerStartDate];
        self.remainTime = MAXTIMERCOUNT - seconds;
        if (self.remainTime <= 0) {
            [self stop];
        }
    }
}

#pragma mark - Getter & Setter
- (NSTimer *)timer {
    return  objc_getAssociatedObject(self, &timerKey);
}
- (void)setTimer:(NSTimer *)timer {
    objc_setAssociatedObject(self, &timerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)remainTime {
    return  [objc_getAssociatedObject(self, &remainTimeKey)integerValue];
}
- (void)setRemainTime:(NSInteger)remainTime {
    objc_setAssociatedObject(self, &remainTimeKey, @(remainTime), OBJC_ASSOCIATION_ASSIGN);
}

- (NSDate *)timerStartDate {
    return  objc_getAssociatedObject(self, &timerStartDateKey);
}
- (void)setTimerStartDate:(NSDate *)timerStartDate {
    objc_setAssociatedObject(self, &timerStartDateKey, timerStartDate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setTitleWhenEndCountDown:(NSString *)titleWhenEndCountDown{
     objc_setAssociatedObject(self, &titleWhenEndCountDownKey, titleWhenEndCountDown, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)titleWhenEndCountDown{
    return  objc_getAssociatedObject(self, &titleWhenEndCountDownKey);
}

- (void)setCountDownFormatter:(NSString *)countDownFormatter{
      objc_setAssociatedObject(self, &countDownFormatterKey, countDownFormatter, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)countDownFormatter{
     return  objc_getAssociatedObject(self, &countDownFormatterKey);
}
@end
