//
//  person.h
//  Gxdemo
//
//  Created by hua on 16/9/18.
//  Copyright © 2016年 gaoxing. All rights reserved.
//
/*  苹果单例实现
 *  1,不能外加调用 alloc, 一旦调用就崩溃掉,其实就是抛异常
 *  只要是外界调用的 allo就崩溃
 *  第一次调用 alloc 就不崩溃,其他都崩溃
 *  2,提供一个方法给外接获取单例
 *  3,内部创建一次单例,什么时候创建,程序启动的时候创建
 *  什么是单例,整个应用程序只有一份内存,并不会分配很多内存
 */


#import <Foundation/Foundation.h>

@interface Person : NSObject

+(instancetype)sharePerson;

@end
