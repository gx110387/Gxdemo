//
//  XWPresentOneTransition.h
//  iOS自定义转场动画
//
//  Created by hua on 16/11/8.
//  Copyright © 2016年 gaoxing. All rights reserved.
//


#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,XWPresentOneTransitionType){
    XWPresentOneTransitionTypePresent = 0,//管理present动画
    XWPresentOneTransitionTypeDismiss //管理dismiss动画
};
@interface XWPresentOneTransition : NSObject<UIViewControllerAnimatedTransitioning>
//根据定义的枚举初始化的两个方法
+ (instancetype)transitionWithTransitionType:(XWPresentOneTransitionType)type;
- (instancetype)initWithTransitionType:(XWPresentOneTransitionType)type;
@end
