//
//  DYTabBar.h
//  DouYin
//
//  Created by hehaichi on 2020/7/31.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DYTabBar;
@protocol DYTabBarDelegate <NSObject>
- (BOOL)tabbar:(DYTabBar *)tabbar shouldSelectItemAtIndex:(NSInteger)index;
- (void)tabbar:(DYTabBar *)tabbar didSelectItemAtIndex:(NSInteger)index;
@required
// NSString or UIButton 子类
- (id)tabbar:(DYTabBar *)tabbar itemForColumnAtIndex:(NSInteger)index;
- (NSInteger)numberOfItemsWithTabbar:(DYTabBar *)tabbar;
@end

@interface DYTabBar : UIView
@property (nonatomic, weak)id<DYTabBarDelegate> delegate;
- (void)reloadData;
@end
