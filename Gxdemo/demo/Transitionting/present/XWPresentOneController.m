//
//  ViewController.m
//  iOS自定义转场动画
//
//  Created by hua on 16/11/8.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import "XWPresentOneController.h"
#import "XWPresentedOneController.h"
@interface XWPresentOneController ()

@end

@implementation XWPresentOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"gaoxing";
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self present];
}
- (void)present{
    XWPresentedOneController *presentedVC = [XWPresentedOneController new];
  
    [self presentViewController:presentedVC animated:YES completion:nil];
}
@end
