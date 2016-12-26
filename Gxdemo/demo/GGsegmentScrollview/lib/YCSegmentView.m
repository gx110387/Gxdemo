//
//  YCSegmentView.m
//  GGsegmentScrollview
//
//  Created by heyudongfang on 16/4/18.
//  Copyright © 2016年 heyudongfang. All rights reserved.
//

#import "YCSegmentView.h"
#import "YCSegmentItemsContentView.h"
#import "YCSegmentViewUnit.h"
@interface YCSegmentView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, YCSegmentItemsContentViewDelegate>
{
    NSArray *_viewControllers;
    CGFloat  _titleHeight;
}
@property (nonatomic,strong) UICollectionViewFlowLayout *cLayout;
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) YCSegmentItemsContentView *titleView;

@end

@implementation YCSegmentView

-(instancetype)initWithFrame:(CGRect)frame titleHeight:(CGFloat)height viewControllers:(NSArray<UIViewController *> *)viewControlers
{
    if (self = [ super initWithFrame:frame]) {
        _titleHeight = height;
        _viewControllers = viewControlers;
        [self setupAllViews];
    }
    return self;
}

/*
 因为我们想让用户更加方便使用，
 所以希望用户只需要传入视图控制器，
 就可以完成控件的初始化，
 控制器有`title`属性。
 我们就可以直接取到控制器的标题来初始化`itemContent`
 */
-(void)setupAllViews
{
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:_viewControllers.count];
    for (UIViewController *vc in _viewControllers) {
        [titles addObject:vc.title];
    }

    self.titleView = [[YCSegmentItemsContentView alloc] initWithFrame:CGRectZero titles:titles];
    self.titleView.delegate = self;
    [self addSubview:self.titleView];
    
    self.cLayout = [[UICollectionViewFlowLayout alloc] init];
    
    ///设置collectionView 的滚动方式为水平滚动
    self.cLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[ UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.cLayout];
    ///这是collectionView按页滚动
    self.collectionView.pagingEnabled  = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource  = self;
    
    ///注意 这里是collectionView注册cell 下文提到
  [self.collectionView registerClass:[YCSegmentViewUnit class] forCellWithReuseIdentifier:@"YCSegmentViewUnit"];
    
    ///注意 这里为collectionView 添加观察者 观察属性`contentOffset`的变化，来获得页数，控制`itemContent`选择哪一个`item`
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    [self addSubview:self.collectionView];
    
}

-(void)layoutSubviews
{
    self.titleView.frame = CGRectMake(0, 0, self.frame.size.width, _titleHeight);
    self.collectionView.frame = CGRectMake(0, _titleHeight, self.frame.size.width, self.frame.size.height - _titleHeight);
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
     NSLog(@"%s",__func__);
    CGPoint offset = self.collectionView.contentOffset;
    ///这里` + 0.5` 是为了当滚动到页面一半的时候，就已经算作下一页或者上一页
    CGFloat pageFloat = offset.x / self.collectionView.bounds.size.width + 0.5;
    if (pageFloat < 0) {
        pageFloat = 0;
    }
    if (pageFloat > _viewControllers.count) {
        pageFloat = _viewControllers.count;
    }
    NSInteger page = (NSInteger)pageFloat;
    self.titleView.page = page;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _viewControllers.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YCSegmentViewUnit * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YCSegmentViewUnit" forIndexPath:indexPath];
    UIViewController *vc = _viewControllers[indexPath.section];
     NSLog(@"%s:%d",__func__,vc.isViewLoaded);
    if (!vc.isViewLoaded) {
         NSLog(@"进了没%s:%d",__func__,vc.isViewLoaded);
        [vc loadViewIfNeeded];
    }
    
    cell.view = vc.view;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

- (void)didSelectedButtonAtIndex:(NSInteger)index {
    
    NSLog(@"%s:%ld",__func__,index);
    CGFloat width = self.collectionView.bounds.size.width;
    [self.collectionView setContentOffset:(CGPointMake(width * index, 0)) animated:YES];
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    self.titleView.normalColor = normalColor;
}

- (void)setHighlightColor:(UIColor *)highlightColor {
    _highlightColor = highlightColor;
    self.titleView.highlightColor = highlightColor;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.titleView.font = font;
}

- (void)dealloc {
    [self.collectionView removeObserver:self forKeyPath:@"contentOffset"];
}
@end
