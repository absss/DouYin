//
//  DYVideoView.m
//  DouYin
//
//  Created by hehaichi on 2020/8/10.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "DYVideoView.h"

#define kPauseIconAlpha 0.3
#define kPauseIconWH 100
@interface DYVideoView()
@property(nonatomic, strong,readwrite) AVPlayer * player;
@property(nonatomic, strong) AVPlayerLayer * playerLayer;
@property(nonatomic, strong) UIImageView * playIconView;// 播放
@property(nonatomic, assign,readwrite,getter=isPlaying) BOOL playing;
@end
@implementation DYVideoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark private method
- (void)setup {
    [self.layer addSublayer:self.playerLayer];
    [self addSubview:self.playIconView];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord
              withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker
                      error:nil];
   
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction)];
    singleTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleClick:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    
    UILongPressGestureRecognizer * longPressGest = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress)];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [self addGestureRecognizer:longPressGest];
}

- (void)clickAction {
    if (self.isPlaying) {
      [self setPlaying:NO animation:YES]; // 暂停播放
    } else {
        if (self.playIconView.alpha > 0) {
            [self setPlaying:YES animation:YES]; //没有播放且显示暂停播放按钮,则继续播放
        }
    }
}

- (void)longPress {
    
    if ([self.delegate respondsToSelector:@selector(videoView:didLongPress:)]) {
        [self.delegate videoView:self didLongPress:self.videoURL];
    }
}

- (void)doubleClick:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self];
    [self showRedStar:point animationCompletion:nil];
}

/// 显示红心
- (void)showRedStar:(CGPoint)center animationCompletion:(dispatch_block_t)completion {
   UIImageView * redStarView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_home_like_after"]];
    redStarView.layer.anchorPoint = CGPointMake(0.5, 1);
    redStarView.frame = CGRectMake(0, 0, 100, 100);
    redStarView.center = center;
    [self addSubview:redStarView];
    
    int radom1 = arc4random()%20;
    double rotate = radom1/100.0;
    if (arc4random()%2  == 0) {
        rotate = -rotate;
    }
    NSLog(@"rotate:%f",rotate);
    CGAffineTransform transform1 = CGAffineTransformMakeScale(2, 2);
    transform1 = CGAffineTransformRotate(transform1,-M_PI*rotate);
    
    CGAffineTransform transform2 = CGAffineTransformMakeScale(1, 1);
    transform2 = CGAffineTransformRotate(transform2,-M_PI*rotate);
    
    CGAffineTransform transform3 = CGAffineTransformMakeScale(3, 3);
    transform3 = CGAffineTransformRotate(transform3,-M_PI*rotate);
    
    redStarView.transform = transform1;
    redStarView.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:20 options:0 animations:^{
        redStarView.transform = transform2;
        redStarView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.7 delay:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
                redStarView.alpha = 0;
                               redStarView.transform = transform3;
            } completion:^(BOOL finished) {
                if (finished) {
                    [redStarView removeFromSuperview];
                    if (completion) {
                        completion();
                    }
                }
            }];
        }
    }];
}

#pragma mark - public method
- (void)resetState {
    [self.player seekToTime:kCMTimeZero];
    self.playIconView.alpha = NO;
}

- (void)setPlaying:(BOOL)playing animation:(BOOL)animation {
    if (playing) {
        BOOL shouldPlay = YES;
        if ([self.delegate respondsToSelector:@selector(videoView:shouldStartPlayVideo:)]) {
            shouldPlay = [self.delegate videoView:self shouldStartPlayVideo:self.videoURL];
        }
        if (shouldPlay) {
            _playing = playing;
            [self.player play];
            if (animation) {
                NSTimeInterval duration = 0.2;
                [UIView animateWithDuration:duration animations:^{
                          self.playIconView.alpha = 0;
                      } completion:^(BOOL finished) {
                          if (finished && [self.delegate respondsToSelector:@selector(videoView:didStartPlayVideo:)]) {
                              [self.delegate videoView:self didStartPlayVideo:self.videoURL];
                          }
                      }];
            } else {
                self.playIconView.alpha = 0;
                if ([self.delegate respondsToSelector:@selector(videoView:didStartPlayVideo:)]) {
                    [self.delegate videoView:self didStartPlayVideo:self.videoURL];
                }
            }
        }

    } else {
        BOOL shouldPause = YES;
        if ([self.delegate respondsToSelector:@selector(videoView:shouldPauseVideo:)]) {
            shouldPause = [self.delegate videoView:self shouldPauseVideo:self.videoURL];
        }
        if (shouldPause) {
            _playing = playing;
            [self.player pause];
            if (animation) {
                 _playIconView.transform = CGAffineTransformMakeScale(2.5, 2.5);
                CGFloat damping = 1.0;
                [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:damping initialSpringVelocity:1.0 / damping options:0 animations:^{
                    self.playIconView.transform = CGAffineTransformIdentity;
                    self.playIconView.alpha = kPauseIconAlpha;
                } completion:^(BOOL finished) {
                    if (finished && [self.delegate respondsToSelector:@selector(videoView:didPauseVideo:)]) {
                        [self.delegate videoView:self didPauseVideo:self.videoURL];
                    }
                }];
            } else {
                self.playIconView.alpha = kPauseIconAlpha;
                if ([self.delegate respondsToSelector:@selector(videoView:didPauseVideo:)]) {
                    [self.delegate videoView:self didPauseVideo:self.videoURL];
                }
            }
            
        }
    }
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if (CGRectEqualToRect(frame, CGRectZero)) {
        return;
    }
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);
    self.playIconView.frame = CGRectMake(width/2 - kPauseIconWH/2, height/2 - kPauseIconWH/2, kPauseIconWH, kPauseIconWH);
    self.playerLayer.frame = CGRectMake(0, 0, width, height);
}

- (void)setVideoURL:(NSURL *)videoURL {
    _videoURL = videoURL;
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:videoURL];
    [self.player replaceCurrentItemWithPlayerItem:item];
}

#pragma mark - getter
- (AVPlayerLayer *)playerLayer {
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _playerLayer;;
}

- (AVPlayer *)player {
    if (!_player) {
        _player = [AVPlayer playerWithPlayerItem:nil];
    }
    return _player;
}

- (UIImageView *)playIconView {
    if (!_playIconView) {
        _playIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"apple_music_album_play"]];
        _playIconView.alpha = 0;
    }
    return _playIconView;
}
@end
