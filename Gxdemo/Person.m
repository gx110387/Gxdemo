//
//  person.m
//  Gxdemo
//
//  Created by hua on 16/9/18.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import "Person.h"

@implementation Person

static Person *_instance = nil;
+(void)load{
    NSLog(@"%s",__func__);
   _instance = [[self alloc] init] ;
    
}

+(instancetype)sharePerson{
    return _instance;
}

+(instancetype)alloc{
    if (_instance) {
        //表示已经分配好了,就不允许外接再分配内存
        //抛异常,告诉外界不运用分配
        //创建异常类,
        // name :异常的名称
        // reson :异常的原因
        // userInfo: 异常信息
     NSException *excep =    [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"There can only be one Person instance" userInfo:nil];
        [excep raise];
    }
//    super ->NSObject 才知道怎么分配内存
    // 调用系统默认的做法,当重写一个方法的时候,如果不想要覆盖原来的实现,就调用 super
    return [super alloc];
}
@end
