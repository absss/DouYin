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

@interface DYMainTabBarController ()<DYTabBarDelegate>
{
    NSArray *_tabbarItems;
}
@end

@implementation DYMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DYBaseNavigationController *nav1 = [[DYBaseNavigationController alloc]initWithRootViewController:[DYHomeViewController new]];
    
    DYBaseNavigationController *nav2 = [[DYBaseNavigationController alloc]initWithRootViewController:[DYOneCityViewController new]];
    
    DYBaseNavigationController *nav3 = [[DYBaseNavigationController alloc]initWithRootViewController:[DYMsgViewController new]];
    
    DYBaseNavigationController *nav4 = [[DYBaseNavigationController alloc]initWithRootViewController:[DYMsgViewController new]];
    
    DYBaseNavigationController *nav5 = [[DYBaseNavigationController alloc]initWithRootViewController:[DYMeViewController new]];
    
    UIButton * centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [centerButton setImage:[UIImage imageNamed:@"btn_home_add_common"] forState:UIControlStateNormal];
    
    self.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
    _tabbarItems = @[@"首页",@"同城",centerButton,@"消息",@"我的"];
    self.tabBar.backgroundImage = [DYColor.blackColor0 imageWithSize:CGSizeMake(100 , 100)];
    [self.tabBar removeAllSubViews];
    DYTabBar *tabbar = [[DYTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabbar.delegate = self;
    [tabbar reloadData];
    [self.tabBar addSubview:tabbar];
    
    
}

- (void)tabbar:(DYTabBar *)tabbar didSelectItemAtIndex:(NSInteger)index {
    self.selectedViewController = self.viewControllers[index];
}

// NSString or UIButton 子类
- (id)tabbar:(DYTabBar *)tabbar itemForColumnAtIndex:(NSInteger)index {
    return _tabbarItems[index];
}

- (NSInteger)numberOfItemsWithTabbar:(DYTabBar *)tabbar {
    return _tabbarItems.count;
}
#pragma mark
@end
