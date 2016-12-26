//
//  AppDelegate.m
//  Gxdemo
//
//  Created by hua on 16/9/18.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "AppDelegate+LaunchImge.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nc;
   [self setupLaunch];
    return YES;
}

// 但我们应用程序即将逝去焦点的时候调用
- (void)applicationWillResignActive:(UIApplication *)application {
 }

// 但我们应用程序完全进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
 }

// 但我们应用程序 即将进入前台的时候调用
- (void)applicationWillEnterForeground:(UIApplication *)application {
 }

// 当我们应用程序完全获取焦点的时候调用
// 只有当一个应用程序完成获取到焦点,才能与用户交互
- (void)applicationDidBecomeActive:(UIApplication *)application {
 }

//当我们应用程序即将关闭的时候调用
- (void)applicationWillTerminate:(UIApplication *)application {
 }


@end
