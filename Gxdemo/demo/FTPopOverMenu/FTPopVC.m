//
//  FTPopVC.m
//  Gxdemo
//
//  Created by hua on 16/9/19.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import "FTPopVC.h"
#import "FTPopOverMenu.h"
@interface FTPopVC ()

@end

@implementation FTPopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self myButton];
}
-(void)myButton
{
    UIButton * redButton = [UIButton buttonWithType:UIButtonTypeCustom];
    redButton .frame = CGRectMake(100, 100, 100, 50);
    redButton.backgroundColor = [ UIColor redColor];
    
    [self.view addSubview:redButton];
    
    [redButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)clickButton:(UIButton *)sender
{
    NSLog(@"click");
    [FTPopOverMenu showForSender:sender
                        withMenu:@[@"1",@"2",@"3"]
                  imageNameArray:@[@"setting_icon",@"setting_icon",@"setting_icon"]
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           
                       } dismissBlock:^{
                           
                           NSLog(@"user canceled. do nothing.");
                           
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
