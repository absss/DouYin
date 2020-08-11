//
//  DYVideoViewCell.h
//  DouYin
//
//  Created by hehaichi on 2020/8/3.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYVideoView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DYVideoViewCell : UITableViewCell
@property (nonatomic,strong)DYVideoModel *data;
@property (nonatomic,strong,readonly) DYVideoView *videoView;
@end

NS_ASSUME_NONNULL_END
