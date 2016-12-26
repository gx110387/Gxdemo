//
//  SuPhotoPickerVC.m
//  Gxdemo
//
//  Created by hua on 16/10/19.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import "SuPhotoPickerVC.h"
#import "SuPhotoPicker.h"
#import "SuPhotoHeader.h"
@interface SuPhotoPickerVC ()

@end

@implementation SuPhotoPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
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
    __weak typeof(self) weakSelf = self;
    SuPhotoPicker * picker = [[SuPhotoPicker alloc]init];
    //    picker.selectedCount = 12;
    //    picker.preViewCount = 2;
    [picker showInSender:self handle:^(NSArray<UIImage *> *photos) {
        [weakSelf showSelectedPhotos:photos];
    }];

}


- (void)showSelectedPhotos:(NSArray *)imgs {
    for (int i = 0; i < imgs.count; i ++) {
        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(50 * i, 200, 50, 50)];
        iv.image = imgs[i];
        [self.view addSubview:iv];
    }
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
