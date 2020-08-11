//
//  DYTabBar.h
//  DouYin
//
//  Created by hehaichi on 2020/7/31.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DYTabBarDelegate <NSObject>
@end

@interface DYTabBar : UIView
@property (nonatomic, copy)void(^selectedBlock)(NSInteger idx);
@property (nonatomic, strong)NSArray *titles;
@end
