//
//  DYVideoModel.h
//  DouYin
//
//  Created by hehaichi on 2020/8/10.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYVideoModel : UIView
@property(nonatomic, strong) NSURL *videoUrl;
@property(nonatomic, assign) CGSize videoViewSize;
@end

NS_ASSUME_NONNULL_END
