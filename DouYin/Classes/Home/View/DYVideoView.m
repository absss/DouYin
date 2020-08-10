//
//  DYVideoView.m
//  DouYin
//
//  Created by hehaichi on 2020/8/10.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "DYVideoView.h"

@interface DYVideoView()
@property(nonatomic, strong,readwrite) AVPlayer * player;
@property(nonatomic, strong) AVPlayerLayer * playerLayer;
@end
@implementation DYVideoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.playerLayer.frame = self.frame;
        [self.layer addSublayer:self.playerLayer];
        
    }
    return self;
}

- (void)setData:(DYVideoModel *)data {
    _data = data;
    _playerLayer.frame = CGRectMake(0, 0, data.videoViewSize.width, data.videoViewSize.height);
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:data.videoUrl];
    [self.player replaceCurrentItemWithPlayerItem:item];
    
}

- (AVPlayer *)player {
    if (!_player) {
        _player = [AVPlayer playerWithPlayerItem:nil];

    }
    return _player;
}
@end
