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
@property(nonatomic, strong,readonly) AVPlayer * player;
@end


