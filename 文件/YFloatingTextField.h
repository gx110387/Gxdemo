//
//  YFloatingTextField.h
//  YFloatingTextField
//
//  Created by wangyang on 14-1-3.
//  Copyright (c) 2014年 wangyang. All rights reserved.
//

#import "YTextField.h"

@interface YFloatingTextField : YTextField

/**
 *  悬浮文字的默认颜色
 */
@property (strong,nonatomic) UIColor *floatingDefaultColor;

/**
 *  悬浮文字的高亮颜色
 */
@property (strong,nonatomic) UIColor *floatingHighlightColor;

/**
 *  悬浮文字错误提示时的颜色
 */
@property (strong,nonatomic) UIColor *floatingWarningColor;

/**
 *  显示错误信息
 *
 *  @param message 错误信息
 */
-(void)showFloatingWarningMessage:(NSString *)message;

@end
