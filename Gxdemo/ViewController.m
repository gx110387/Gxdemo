//
//  ViewController.m
//  Gxdemo
//
//  Created by hua on 16/9/18.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import "ViewController.h"
#import "PopCodeVC.h"
#import "FTPopVC.h"
#import "WJTouchVC.h"
#import "BBTestTipViewController.h"
#import "PopActionSheet.h"
#import "LLNoDataView.h"
#import "SuPhotoPickerVC.h"
#import "YZPullDownMenuVC.h"
#import "PPCounter.h"
#import "RootViewController.h"
#import "GGsegmentScrollviewVC.h"
#import "NAVIViewController.h"
#import "ActionSheetVC.h"
#define KSCREEN_WIDTH               [[UIScreen mainScreen] bounds].size.width
#define KSCREEN_HEIGHT              [[UIScreen mainScreen] bounds].size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource, LLNoDataViewTouchDelegate ,PopActionSheetDelegate>
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ViewController{
    NSMutableArray *dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"dfd");
    //    [self  myButton];
    
    dataArr = [[NSMutableArray alloc] initWithObjects:@"弹出框小箭头版",@"图片验证码",@"指纹验证" ,@"TipView",@"LLNoDataView",@"PopActionSheet",@"防QQSuPhotoPicker",@"YZPullDownMenuVC",@"数字/金额增减动效控件,支持UILabel、UIButton显示",@"自定义转场动画",@"GGsegmentScrollviewVC",@"NAVIViewController",@"弹框",nil];
    [self createTableView];
}
-(void)createTableView{
    _tableView = [[ UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT ) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"setUpIdent";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    }
   
    if ([dataArr[indexPath.row] isEqualToString:@"数字/金额增减动效控件,支持UILabel、UIButton显示"])  {
        cell.textLabel.counterAnimationType = 1;
        
        [cell.textLabel  pp_fromNumber:0 toNumber:2016101 duration:1.5f formatBlock:^NSString *(CGFloat number) {
            NSNumberFormatter *formatter = [NSNumberFormatter new];
            formatter.numberStyle = NSNumberFormatterDecimalStyle;
            formatter.positiveFormat = @"###,##0.00";
            NSNumber *amountNumber = [NSNumber numberWithFloat:number];
            return [NSString stringWithFormat:@"数字/金额增减动效控件 ¥%@",[formatter stringFromNumber:amountNumber]];
        }];
        
        
    }else{
         cell.textLabel.text = dataArr[indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([dataArr[indexPath.row]isEqualToString:@"弹出框小箭头版"])
    {
        [self.navigationController pushViewController:[[FTPopVC alloc]init] animated:YES];
    }else if ([dataArr[indexPath.row] isEqualToString:@"图片验证码"])
    {
        [self.navigationController pushViewController:[[PopCodeVC alloc]init] animated:YES];
    }
    else if ([dataArr[indexPath.row] isEqualToString:@"指纹验证"])
    {
        [self.navigationController pushViewController:[[WJTouchVC alloc]init] animated:YES];
    }else if ([dataArr[indexPath.row] isEqualToString:@"TipView"])
    {
        
         [self.navigationController pushViewController:[[BBTestTipViewController alloc]init] animated:YES];
    }
    else if ([dataArr[indexPath.row] isEqualToString:@"PopActionSheet"])
    {
        
        PopActionSheet *sheet = [PopActionSheet popSheetWithTitle:nil
                                                     buttonTitles:@[@"拍照", @"从相册选择"]
                                                   redButtonIndex:-1
                                                         delegate:self];
         [sheet show];
    }
    else if ([dataArr[indexPath.row] isEqualToString:@"LLNoDataView"])
    {
        LLNoDataView *dataView = [[LLNoDataView alloc] initReloadBtnWithFrame:self.tableView.bounds LLNoDataViewType:LLNoInternet description:@"" reloadBtnTitle:@"重新加载"];
        dataView.delegate = self;
        self.tableView.tableHeaderView = dataView;
        
        //实例一次，再次修改提示文本信息
        dataView.tipLabel.text = @"没有搜索到\"LLNoDataView\"的数据";
    }else if ([dataArr[indexPath.row] isEqualToString:@"防QQSuPhotoPicker"])
    {
        [self.navigationController pushViewController:[[SuPhotoPickerVC alloc]init] animated:YES];
  
    }else if ([dataArr[indexPath.row] isEqualToString:@"YZPullDownMenuVC"])
    {
        [self.navigationController pushViewController:[[YZPullDownMenuVC alloc]init] animated:YES];
        
    }else if ([dataArr[indexPath.row] isEqualToString:@"数字/金额增减动效控件,支持UILabel、UIButton显示"]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.counterAnimationType = 1;
        
        [cell.textLabel  pp_fromNumber:0 toNumber:2016101 duration:1.5f formatBlock:^NSString *(CGFloat number) {
            NSNumberFormatter *formatter = [NSNumberFormatter new];
            formatter.numberStyle = NSNumberFormatterDecimalStyle;
            formatter.positiveFormat = @"###,##0.00";
            NSNumber *amountNumber = [NSNumber numberWithFloat:number];
            return [NSString stringWithFormat:@"数字/金额增减动效控件 ¥%@",[formatter stringFromNumber:amountNumber]];
        }];
        
    }else if ([dataArr[indexPath.row] isEqualToString:@"自定义转场动画"]) {
        [self.navigationController pushViewController:[[ RootViewController alloc]init] animated:YES];
        
    }else if ([dataArr[indexPath.row] isEqualToString:@"GGsegmentScrollviewVC"]) {
        [self.navigationController pushViewController:[[ GGsegmentScrollviewVC alloc]init] animated:YES];
        
    }else if ([dataArr[indexPath.row] isEqualToString:@"NAVIViewController"]) {
        [self.navigationController pushViewController:[[ NAVIViewController alloc]init] animated:YES];
        
    }else if ([dataArr[indexPath.row] isEqualToString:@"弹框"]){
       [self.navigationController pushViewController:[[ ActionSheetVC alloc]init] animated:YES];
    }
    
    
    
    
}

- (void)didTouchLLNoDataView{
    
    [self.tableView reloadData];
    self.tableView.tableHeaderView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
