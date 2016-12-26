//
//  YImageBannerView.m
//  ires
//
//  Created by zhengch on 15/8/10.
//  Copyright (c) 2015年 ZTESoft. All rights reserved.
//

#import "YImageBannerView.h"
#import "YHTTPServiceUseBlock.h"

@implementation YImageBannerView
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    BOOL _isAutoPlay;
}
@synthesize isAutoPlay = _isAutoPlay;

#pragma mark - init
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self YLV_Initialization];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self YLV_Initialization];
    }
    return self;
}

- (id)init
{
    self=[super init];
    if (self)
    {
        [self YLV_Initialization];
    }
    
    return self;
}

- (void)YLV_Initialization
{
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(AutoPlay) userInfo:nil repeats:YES];
    //初始化 view
    self.backgroundColor=[UIColor clearColor];
    self.multipleTouchEnabled = true;
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_scrollView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[mainScrollView]-0-|" options:0 metrics:nil views:@{@"mainScrollView":_scrollView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[mainScrollView]-0-|" options:0 metrics:nil views:@{@"mainScrollView":_scrollView}]];
    
    //page
    _pageControl=[[UIPageControl alloc] init];
    [_pageControl setTranslatesAutoresizingMaskIntoConstraints:NO];
    _pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
    [self addSubview:_pageControl];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[pageControl]-0-|" options:0 metrics:nil views:@{@"pageControl":_pageControl}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageControl]-0-|" options:0 metrics:nil views:@{@"pageControl":_pageControl}]];
}

-(void)setIsAutoPlay:(BOOL)isAutoPlay
{
    _isAutoPlay = isAutoPlay;
}

#pragma mark - actions
-(void)AutoPlay
{
    if (self.isAutoPlay) {
        if (_pageControl.currentPage < _pageControl.numberOfPages-1) {
            [_scrollView setContentOffset:CGPointMake((_pageControl.currentPage+1)*_scrollView.frame.size.width, 0) animated:YES];
        }else
        {
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }
        
    }
}

-(void)setImagesWithUrls:(NSArray *)urls{
    _pageControl.numberOfPages = [urls count];
    while ([_scrollView.subviews count]>0) {
        [[_scrollView.subviews objectAtIndex:0] removeFromSuperview];
    }
    UIImageView *preView = nil;
    for (int i = 0; i<[urls count]; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_scrollView addSubview:imageView];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
        
        if (i==0)
        {
            [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]-0-|" options:0 metrics:nil views:@{@"imageView":imageView}]];
            [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[imageView]" options:0 metrics:nil views:@{@"imageView":imageView}]];
        }
        else
        {
            [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]" options:0 metrics:nil views:@{@"imageView":imageView}]];
            [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[preView]-0-[imageView]" options:0 metrics:nil views:@{@"imageView":imageView,@"preView":preView}]];
        }
        
        if (i==[urls count]-1)
        {
            [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[imageView]-0-|" options:0 metrics:nil views:@{@"imageView":imageView}]];
        }
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
        [imageView addGestureRecognizer:singleFingerOne];
        
        preView = imageView;
        YHTTPServiceUseBlock *httpService=[[YHTTPServiceUseBlock alloc] init];
        [httpService setResponseSuccessBlock:^(id responseObject, AFHTTPRequestOperation *operation, NSInteger requestTag, NSDictionary *otherFlags) {
            
            [imageView setImage:responseObject];
        }];
        
        [httpService sendHTTPRequestAsyncMethod:@"GET" Path:[urls objectAtIndex:i] HTTPHeader:Nil parameters:nil requestServiceType:RequestServiceGetImageAndCacheIt requestTag:0];
    }
}

-(void)setBannerImages:(NSArray *)images{
    _pageControl.numberOfPages = [images count];
    while ([_scrollView.subviews count]>0) {
        [[_scrollView.subviews objectAtIndex:0] removeFromSuperview];
    }
    UIImageView *preView = nil;
    for (int i = 0; i<[images count]; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:imageView];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
        
        if (i==0)
        {
            [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]-0-|" options:0 metrics:nil views:@{@"imageView":imageView}]];
            [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[imageView]" options:0 metrics:nil views:@{@"imageView":imageView}]];
        }
        else
        {
            [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]" options:0 metrics:nil views:@{@"imageView":imageView}]];
            [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[preView]-0-[imageView]" options:0 metrics:nil views:@{@"imageView":imageView,@"preView":preView}]];
        }
        
        if (i==[images count]-1)
        {
            [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[imageView]-0-|" options:0 metrics:nil views:@{@"imageView":imageView}]];
        }
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
        [imageView addGestureRecognizer:singleFingerOne];
        
        [imageView setImage:[images objectAtIndex:i]];
        preView = imageView;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    _pageControl.currentPage=_scrollView.contentOffset.x/_scrollView.frame.size.width;
}

#pragma mark - UITapGestureRecognizer
- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)sender
{
    NSInteger index = [_scrollView.subviews indexOfObject:sender.view];
    if ([self.delegate respondsToSelector:@selector(imageBannerView:selectImageIndex:)]) {
        [self.delegate imageBannerView:self selectImageIndex:index];
    }
}


@end
