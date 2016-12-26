//
//  PopCodeVC.m
//  Gxdemo
//
//  Created by hua on 16/9/19.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import "PopCodeVC.h"
#import "PooCodeView.h"

@interface PopCodeVC (){
    PooCodeView *_pooCodeView;
}

@end

@implementation PopCodeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _pooCodeView = [[PooCodeView alloc] initWithFrame:CGRectMake(50, 100, 82, 32)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    
    [_pooCodeView addGestureRecognizer:tap];
    [self.view addSubview:_pooCodeView];
    
}

- (void)tapClick:(UITapGestureRecognizer*)tap{
    [_pooCodeView changeCode];
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
