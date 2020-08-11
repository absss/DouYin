//
//  DYVideoTableController.h
//  DouYin
//
//  Created by hehaichi on 2020/8/3.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "DYBaseViewController.h"
typedef NS_ENUM(NSInteger, DYVideoTableVcType) {
    DYHomeSubVCTypeFollow,
    DYHomeSubVCTypeRecommand
};

@interface DYVideoTableController : DYBaseViewController
- (instancetype)initWithType:(DYVideoTableVcType)type;
@end


