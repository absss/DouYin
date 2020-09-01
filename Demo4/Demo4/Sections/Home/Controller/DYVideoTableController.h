//
//  DYVideoTableController.h
//  DouYin
//
//  Created by hehaichi on 2020/8/3.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "DYBaseViewController.h"
typedef NS_ENUM(NSInteger, DYVideoTableVcType) {
    DYHomeSubVCTypeFollow, //关注
    DYHomeSubVCTypeRecommand // 推荐
};

@interface DYVideoTableController : DYBaseViewController
- (instancetype)initWithType:(DYVideoTableVcType)type;
@property (nonatomic, assign, getter=isSelected)BOOL selected;

- (void)pause:(NSInteger)index animation:(BOOL)animation;
- (void)play:(NSInteger)index animation:(BOOL)animation;
@end


