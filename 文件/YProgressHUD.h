//
//  YProgressHUD.h
//  Libs
//
//  Created by wangyang on 13-12-27.
//  Copyright (c) 2013年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YProgressHUDMaskType)
{
    /**
     *  有一个透明的 MASK ，用户不可以与 UI 交互
     */
    YProgressHUDMaskTypeClear,
    /**
     *  有一个半透明黑色的 MASK ，用户不可以与 UI 交互
     */
    YProgressHUDMaskTypeBlack,
    /**
     *  没有 MASK，用户可以和 UI 交互
     */
    YProgressHUDMaskTypeNone
};

typedef NS_ENUM(NSUInteger, YProgressHUDPosition)
{
    /**
     *  屏幕中间显示
     */
    YProgressHUDPositionCenter,
    /**
     *  屏幕底部显示
     */
    YProgressHUDPositionBottom
};

@protocol YProgressHUDDelegate;

#pragma mark - @interface YProgressHUD
/**
 *  进度条
 */
@interface YProgressHUD : UIView

@property (assign,nonatomic) YProgressHUDMaskType HUDMaskType;
@property (assign,nonatomic) YProgressHUDPosition HUDPosition;

@property (strong,nonatomic) NSString *status;
@property (strong,nonatomic) UIView *statusView;

@property (assign,nonatomic) NSTimeInterval duration;

@property (weak,nonatomic) id<YProgressHUDDelegate> delegate;

/**
 *  显示计数，只有当显示计数为0时，才会 dismiss
 */
@property (assign,nonatomic,readonly) NSInteger shownCount;

+(YProgressHUD*)sharedProgressHUD;
+(void)showToastWithStatus:(NSString*)status duration:(NSTimeInterval)duration;

-(id)initWithStatus:(NSString *)status;

/**
 *  显示 HUD ，并使显示技术加一
 */
-(void)show;

/**
 *  使显示技术减一，如果显示技术为0后，则 dismiss self
 */
-(void)dismiss;

/**
 *  强制 dismiss self.忽略显示计数
 */
-(void)dismissIgnoreShownCount;

@end

#pragma mark - @protocol YProgressHUDDelegate
@protocol YProgressHUDDelegate <NSObject>
@optional
-(void)userDidTappedMask;
@end
