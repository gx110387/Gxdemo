//
//  GGsegmentScrollviewVC.m
//  Gxdemo
//
//  Created by hua on 16/11/14.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import "GGsegmentScrollviewVC.h"
#import "YCSegmentView.h"
#import "HomeViewController.h"
#import "RankViewController.h"
#import "MasterViewController.h"
#import "ChoicenessViewController.h"

@interface GGsegmentScrollviewVC ()

@end

@implementation GGsegmentScrollviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    HomeViewController *vc1 = [[HomeViewController alloc] init];
    vc1.title = @"首页";
    
    RankViewController *vc2 = [[RankViewController alloc] init];
    vc2.title = @"榜单";
    
    MasterViewController *vc3 = [[MasterViewController alloc] init];
    vc3.title = @"达人";
    
    ChoicenessViewController *vc4 = [[ChoicenessViewController alloc] init];
    vc4.title = @"每周精选";
    
    
    YCSegmentView *view = [[YCSegmentView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height) titleHeight:44 viewControllers:@[vc1, vc2, vc3, vc4]];
    view.highlightColor = [UIColor orangeColor];
    [self.view addSubview:view];

  
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
