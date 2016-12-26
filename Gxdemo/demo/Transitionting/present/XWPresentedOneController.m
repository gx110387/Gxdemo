//
//  ViewControllerPresentVC.m
//  iOS自定义转场动画
//
//  Created by hua on 16/11/14.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import "XWPresentedOneController.h"
#import "XWPresentOneTransition.h"
@interface XWPresentedOneController ()<UIViewControllerTransitioningDelegate>

@end

@implementation XWPresentedOneController
- (void)dealloc{
    NSLog(@"销毁了!!!!!");
}
- (instancetype)init
{
    self = [super init];
    if (self) {
          self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   

    // Do any additional setup after loading the view.
    self. view.backgroundColor = [UIColor blueColor];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [XWPresentOneTransition transitionWithTransitionType:XWPresentOneTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [XWPresentOneTransition transitionWithTransitionType:XWPresentOneTransitionTypeDismiss];
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
