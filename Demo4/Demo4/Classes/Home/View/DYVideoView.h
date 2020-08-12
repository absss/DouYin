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

@class DYVideoView;
@class DYVideoModel;

@protocol DYVideoViewDelegate <NSObject>

@optional
/// 将要开始播放
- (BOOL)videoView:(DYVideoView *)videoView shouldStartPlayVideo:(DYVideoModel *)model;
/// 开始播放
- (void)videoView:(DYVideoView *)videoView didStartPlayVideo:(DYVideoModel *)model;
/// 将要暂停
- (BOOL)videoView:(DYVideoView *)videoView shouldPauseVideo:(DYVideoModel *)model;
/// 暂停
- (void)videoView:(DYVideoView *)videoView didPauseVideo:(DYVideoModel *)model;
/// 长按
- (void)videoView:(DYVideoView *)videoView didLongPress:(DYVideoModel *)model;

@end

@interface DYVideoView : UIView
@property (nonatomic,strong) DYVideoModel *data;
@property(nonatomic, assign,readonly,getter=isPlaying) BOOL playing;
@property (nonatomic,weak) id<DYVideoViewDelegate> delegate;
/// 重置状态，播放时间重置为0等
- (void)resetState;

/// 播放 & 暂停
/// @param playing YES 播放，NO 暂停
/// @param animation 动画
- (void)setPlaying:(BOOL)playing animation:(BOOL)animation;

@end


