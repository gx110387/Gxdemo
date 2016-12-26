//
//  ActionSheetVC.m
//  Gxdemo
//
//  Created by hua on 16/12/26.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import "ActionSheetVC.h"
#import "PopActionSheet.h"
#import "ACActionSheet.h"
#import "UIAlertController+Blocks.h"
#import "AlertShow.h"
@interface ActionSheetVC ()<PopActionSheetDelegate>

@end

@implementation ActionSheetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)PopActionSheetAction:(id)sender {
    PopActionSheet *sheet = [PopActionSheet popSheetWithTitle:nil buttonTitles:@[@"拍照", @"从相册选择"] redButtonIndex:-1 delegate:self];
    [sheet show];

}
- (IBAction)ACActionSheetAction:(id)sender {
    ACActionSheet *actionSheet = [[ACActionSheet alloc] initWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"小视频",@"拍照",@"从手机相册选择"] actionSheetBlock:^(NSInteger buttonIndex) {
        NSLog(@"ACActionSheet block - %ld",buttonIndex);
    }];
    [actionSheet show];

}
-(void)actionSheet:(PopActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex{
    
}
- (IBAction)AlertShowAction:(id)sender {
    [AlertShow alertShowWithContent:@"提示" Seconds:3];
    //是吧
    }
- (IBAction)UIAlertControllerAction:(id)sender {
    [UIAlertController showAlertInViewController:self  withTitle:@"title" message:@"message" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"queding"] tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        if (buttonIndex == controller.cancelButtonIndex) {
          }else if (buttonIndex >= controller.firstOtherButtonIndex) {
              
            if (((long)buttonIndex - controller.firstOtherButtonIndex)== 0) {
               
            }
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
