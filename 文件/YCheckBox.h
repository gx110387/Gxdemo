//
//  YCheckBox.h
//  ztesoftLibs
//
//  Created by wangyang on 13-11-9.
//  Copyright (c) 2013年 ztesoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCheckBoxDelegate;

/**
 *  多选框
 */
@interface YCheckBox : UIButton

/**
 *  是否选中
 */
@property (assign,nonatomic) BOOL checked;

/**
 *  代理
 */
@property (weak,nonatomic) id<YCheckBoxDelegate> delegate;

@end

@protocol YCheckBoxDelegate <NSObject>

-(void)checkBox:(YCheckBox*)checkBox checked:(BOOL)isChecked;

@end
