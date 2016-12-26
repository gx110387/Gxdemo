//
//  AlterShow.m
//  GGSee
//
//  Created by 李志强 on 15/8/21.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "AlertShow.h"

@implementation AlertShow

+(void)alertShowWithContent:(NSString *)content Seconds:(CGFloat)second {
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:content delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:second target:self selector:@selector(cancelAlter:) userInfo:alertView repeats:NO];
    
    [alertView show];
}

+(void)cancelAlter:(NSTimer *)sender
{
    UIAlertView *promptAlert = (UIAlertView*)[sender userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}

@end
