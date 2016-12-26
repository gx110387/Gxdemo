//
//  AppDelegate+LaunchImge.m
//  Gxdemo
//
//  Created by hua on 16/9/19.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import "AppDelegate+LaunchImge.h"
#import "LBLaunchImageAdView.h"
@implementation AppDelegate (LaunchImge)
-(void)setupLaunch{
    
    LBLaunchImageAdView * adView = [[LBLaunchImageAdView alloc]initWithWindow:self.window adType:LogoAdType];
    adView.localAdImgName = @"qidong.gif";
    
    //各种回调
    adView.clickBlock = ^(NSInteger tag){
        switch (tag) {
            case 1100:{
                NSLog(@"点击广告回调");
                
            }
                break;
            case 1101:
                NSLog(@"点击跳过回调");
                break;
            case 1102:
                NSLog(@"倒计时完成后的回调");
                break;
            default:
                break;
        }
        
    };
    
}
@end
