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

@protocol DYVideoViewDelegate <NSObject>

@optional
/// 将要开始播放
- (BOOL)videoView:(DYVideoView *)videoView shouldStartPlayVideo:(NSURL *)videoURL;
/// 开始播放
- (void)videoView:(DYVideoView *)videoView didStartPlayVideo:(NSURL *)videoURL;
/// 将要暂停
- (BOOL)videoView:(DYVideoView *)videoView shouldPauseVideo:(NSURL *)videoURL;
/// 暂停
- (void)videoView:(DYVideoView *)videoView didPauseVideo:(NSURL *)videoURL;
/// 长按
- (void)videoView:(DYVideoView *)videoView didLongPress:(NSURL *)videoURL;

@end

@interface DYVideoView : UIView
@property (nonatomic,copy) NSURL *videoURL;;
@property(nonatomic, assign,readonly,getter=isPlaying) BOOL playing;
@property (nonatomic,weak) id<DYVideoViewDelegate> delegate;
/// 重置状态，播放时间重置为0等
- (void)resetState;

/// 播放 & 暂停
/// @param playing YES 播放，NO 暂停
/// @param animation 动画
- (void)setPlaying:(BOOL)playing animation:(BOOL)animation;

@end


