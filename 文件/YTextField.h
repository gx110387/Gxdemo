//
//  YTextField.h
//  Libs
//
//  Created by wangyang on 14-1-2.
//  Copyright (c) 2014年 wangyang. All rights reserved.
//
//  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//  注意 : 只有当 YTextField 的 superview （ 包括 superview 的 superview ）为 UIScrollView 时，才会自动滚动，防止键盘挡住
//  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#import <UIKit/UIKit.h>

#pragma mark - protocol
@protocol YTextFieldEditingEvent <NSObject>
/**
 *  子类可以实现以下两个方法来获取相应事件
 */
@optional
-(void)textFieldBeginEditing:(NSNotification *)notification;
-(void)textFieldEndEditing:(NSNotification *)notification;
@end

#pragma mark - class
@interface YTextField : UITextField<YTextFieldEditingEvent>
{
    void (^_autoValidateCompletionBlockWithSuccess)(void);
    void (^_autoValidateCompletionBlockWithFailure)(NSString *failureInfo);
}

/**
 *  是否需要工具条,默认YES
 */
@property (assign,nonatomic) BOOL isNeedToolBar;

/**
 *  验证输入的正则表达式,key:正则表达式,value:验证失败的提示信息。可放入多对键值对
 */
@property (strong,nonatomic) NSDictionary *validateRegExpDic;

/**
 *  是否当 self 失去焦点的时候立即进行有效性验证
 */
@property (assign,nonatomic) BOOL isAutoValidate;

/**
 *  输入有效性验证，错误信息。只有当输入无效的时候才有值
 */
@property (strong,nonatomic,readonly) NSString *invalidInfo;

/**
 *  进行验证
 *
 *  @return 是否通过验证
 */
-(BOOL)validateInput;

/**
 *  当 isAutoValidate 设置为 YES 时，可以设置以下 Block 来响应输入有效性检测
 *
 *  @param successBlock 验证成功回调 block
 *  @param failure      验证失败回调 block
 */
-(void)setAutoValidateCompletionBlockWithSuccess:(void(^)(void))successBlock
                                         failure:(void(^)(NSString *failureInfo))failure;

@end
