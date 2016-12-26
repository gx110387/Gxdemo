//
//  ViewController.m
//  导航栏变透明
//
//  Created by hua on 16/11/19.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import "NAVIViewController.h"
#define XMGHeadViewMinH 64
#define headViewHIGHT 200
#define headHIGHT 44
#import "UIImage+Image.h"

@interface NAVIViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HeaderHightConsagain;

@property(nonatomic,assign)CGFloat oriOffsetY;
@property (nonatomic, weak) UILabel *label;

@end

@implementation NAVIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpNavigationBar];
    //设置数据源
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self .automaticallyAdjustsScrollViewInsets = NO;
     _oriOffsetY = -(headViewHIGHT+headHIGHT);
    self.tableView.contentInset = UIEdgeInsetsMake(headHIGHT+headViewHIGHT, 0, 0, 0);
   
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 计算下tableView滚动了多少
    
    // 偏移量:tableView内容与可视范围的差值
    
    // 获取当前偏移量y值
    CGFloat curOffsetY = scrollView.contentOffset.y;
    
    // 计算偏移量的差值 == tableView滚动了多少
    // 获取当前滚动偏移量 - 最开始的偏移量(-244)
    CGFloat delta = curOffsetY - _oriOffsetY;
    
    // 计算下头部视图的高度
    CGFloat h = headViewHIGHT - delta;
    if (h < XMGHeadViewMinH) {
        h = XMGHeadViewMinH;
    }
    
    // 修改头部视图高度,有视觉差效果
    _HeaderHightConsagain.constant = h;
    
    // 计算透明度
    CGFloat alpha = delta / (headViewHIGHT - XMGHeadViewMinH);
    
    if (alpha > 1) {
        alpha = 0.99;
    }
    
    // 设置导航条背景图片
    // 根据当前alpha值生成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    // 设置导航条标题颜色
    _label.textColor = [UIColor colorWithWhite:0 alpha:alpha];

   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"setUpIdent";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
-(void)setUpNavigationBar{
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"gaoxing";
    label.textColor = [UIColor colorWithWhite:0 alpha:1];
    [label sizeToFit];
     _label = label;
    self.navigationItem.titleView = label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
