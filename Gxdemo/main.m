//
//  main.m
//  Gxdemo
//
//  Created by hua on 16/9/18.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    //UIApplicationMain底层实现:
    // 1.根据principalClassName传递的类名创建UIApplication对象
    // 2.创建UIApplication代理对象,给UIApplication对象设置代理
    // 3.帮你开启主运行事件循环,处理事件.保持程序一直运行
    // 4.加载 info.plist,判断下是否制定mian, 如果指定了,就会加载
}
