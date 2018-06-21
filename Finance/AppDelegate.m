//
//  AppDelegate.m
//  Finance
//
//  Created by wenpeifang on 2018/6/4.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "AppDelegate.h"
#import "FILoginViewController.h"
#import "UIImage+Color.h"
#import "FIBaseNavigationViewController.h"
#import "FIHomeViewController.h"
#import <WRNavigationBar/WRNavigationBar.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
        
    [WRNavigationBar wr_widely];
    // 设置导航栏默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:[UIColor whiteColor]];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor blackColor]];
    // 设置导航栏标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor blackColor]];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:NO];

    [self loginRootViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)loginRootViewController{
    FILoginViewController * login = [[FILoginViewController alloc]init];
    self.window.rootViewController = [[FIBaseNavigationViewController alloc]initWithRootViewController:login];
}

-(void)homeRootViewController{
    FIHomeViewController * login = [[FIHomeViewController alloc]init];
    self.window.rootViewController = [[FIBaseNavigationViewController alloc]initWithRootViewController:login];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
