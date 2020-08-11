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
@property(nonatomic, strong) UIImageView * pauseIconView;
@property(nonatomic, assign,readwrite,getter=isPlaying) BOOL playing;
@end
@implementation DYVideoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}


#pragma mark private method
- (void)setup {
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
         self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
         [self.layer addSublayer:self.playerLayer];
         [self addSubview:self.pauseIconView];
         UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction)];
         [self addGestureRecognizer:tapGest];
}

#pragma mark  - setter
- (void)setData:(DYVideoModel *)data {
    _data = data;
    CGFloat width = data.videoViewSize.width;
    CGFloat height = data.videoViewSize.height;
    if (CGRectEqualToRect(_playerLayer.frame, CGRectZero)) {
        _playerLayer.frame = CGRectMake(0, 0, width, height);
    }
    if (CGPointEqualToPoint(_pauseIconView.frame.origin, CGPointZero)) {
        _pauseIconView.frame = CGRectMake(width/2 - kPauseIconWH/2, height/2 - kPauseIconWH/2, kPauseIconWH, kPauseIconWH);
    }
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:data.videoUrl];
    [self.player replaceCurrentItemWithPlayerItem:item];
    
}

#pragma mark - getter
- (AVPlayer *)player {
    if (!_player) {
        _player = [AVPlayer playerWithPlayerItem:nil];
    }
    return _player;
}

- (UIImageView *)pauseIconView {
    if (!_pauseIconView) {
        _pauseIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"apple_music_album_play"]];
        _pauseIconView.hidden = YES;
        _pauseIconView.alpha = 0;
    }
    return _pauseIconView;
}

- (void)clickAction {
    [self setPlaying:!self.isPlaying animation:YES];
}

#pragma mark - public method
- (void)resetTime {
    [self.player seekToTime:kCMTimeZero];
}


- (void)setPlaying:(BOOL)playing animation:(BOOL)animation {
    _playing = playing;
    if (playing) {
        [self.player play];
        if (animation) {
            NSTimeInterval duration = 0.5;
                  [UIView animateWithDuration:duration / 2.0 animations:^{
                      self.pauseIconView.alpha = 0;
                  } completion:^(BOOL finished) {
                      if (finished) {
                          self.pauseIconView.hidden = YES;
                      }
                  }];
        } else {
           self.pauseIconView.hidden = YES;
        }

    } else {
        [self.player pause];
        self.pauseIconView.hidden = NO;
        if (animation) {
             _pauseIconView.transform = CGAffineTransformMakeScale(2.5, 2.5);
            NSTimeInterval duration = 0.5;
            [UIView animateWithDuration:duration / 2.0 animations:^{
                self.pauseIconView.alpha = kPauseIconAlpha;
            }];
            CGFloat damping = 1.0;
            [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:damping initialSpringVelocity:1.0 / damping options:0 animations:^{
                self.pauseIconView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}


@end
