//
//  AppDelegate.m
//  DouYin
//
//  Created by hehaichi on 2020/7/31.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "AppDelegate.h"
#import "DYMainTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [DYMainTabBarController new];
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
