//
//  UIView+Controller.h
//  CiticsfFinanceApp
//
//  Created by hehaichi on 2019/8/22.
//  Copyright © 2019 CITICSF. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Controller)
/// 获取控制器
- (UIViewController * )viewController;
- (UINavigationController * )navigationController;
- (UITabBarController * )tabBarController;
- (UIWindow * )rootWindow;
@end

