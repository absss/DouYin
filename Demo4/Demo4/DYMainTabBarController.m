//
//  DYMainTabBarController.m
//  DouYin
//
//  Created by hehaichi on 2020/7/31.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "DYMainTabBarController.h"
#import "DYHomeViewController.h"
#import "DYOneCityViewController.h"
#import "DYMsgViewController.h"
#import "DYMeViewController.h"
#import "DYBaseNavigationController.h"

#import "DYTabBar.h"
#import "UIColor+Util.h"

@interface DYMainTabBarController ()

@end

@implementation DYMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DYBaseNavigationController *nav1 = [[DYBaseNavigationController alloc]initWithRootViewController:[DYHomeViewController new]];
    
    DYBaseNavigationController *nav2 = [[DYBaseNavigationController alloc]initWithRootViewController:[DYOneCityViewController new]];
    
    DYBaseNavigationController *nav3 = [[DYBaseNavigationController alloc]initWithRootViewController:[DYMsgViewController new]];
    
    DYBaseNavigationController *nav4 = [[DYBaseNavigationController alloc]initWithRootViewController:[DYMsgViewController new]];
    
    DYBaseNavigationController *nav5 = [[DYBaseNavigationController alloc]initWithRootViewController:[DYMeViewController new]];
    
    self.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
    NSArray * titles = @[@"首页",@"同城",@"拍摄",@"消息",@"我的"];
    self.tabBar.backgroundImage = [DYColor.blackColor0 imageWithSize:CGSizeMake(100 , 100)];
    [self.tabBar removeAllSubViews];
    DYTabBar *tabbar = [[DYTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabbar.titles = titles;
    [self.tabBar addSubview:tabbar];
    tabbar.selectedBlock = ^(NSInteger idx) {
        self.selectedViewController = self.viewControllers[idx];
    };
    
    
}


@end
