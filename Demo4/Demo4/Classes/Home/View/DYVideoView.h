//
//  DYVideoView.h
//  DouYin
//
//  Created by hehaichi on 2020/8/10.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYVideoModel.h"
#import <AVFoundation/AVFoundation.h>


@interface DYVideoView : UIView
@property (nonatomic,strong) DYVideoModel *data;
@property(nonatomic, assign,readonly,getter=isPlaying) BOOL playing;


/// 将播放时间重置到0
- (void)resetTime;

/// 播放 & 暂停
/// @param playing YES 播放，NO 暂停
/// @param animation 动画
- (void)setPlaying:(BOOL)playing animation:(BOOL)animation;
@end


