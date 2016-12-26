//
//  YImageBannerView.h
//  ires
//
//  Created by zhengch on 15/8/10.
//  Copyright (c) 2015年 ZTESoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YImageBannerViewDelegate;
/**
 *  滚动图片控件
 */
@interface YImageBannerView : UIView<UIScrollViewDelegate>

@property(weak,nonatomic)id<YImageBannerViewDelegate> delegate;
/**
 *  图片是否自动播放
 */
@property(assign,nonatomic) BOOL isAutoPlay;

/**
 *  设置banner的图像-网络地址
 *
 *  @param urls NSString的网络地址数据集
 */
-(void)setImagesWithUrls:(NSArray *)urls;

/**
 *  设置banner的图像-UIImage
 *
 *  @param images UIImage数据集
 */
-(void)setBannerImages:(NSArray *)images;

@end

@protocol YImageBannerViewDelegate <NSObject>

/**
 *  返回点击图片的index序列号
 *
 *  @param imageBannerView <#imageBannerView description#>
 *  @param index           点击的序列号
 */
-(void)imageBannerView:(YImageBannerView *)imageBannerView selectImageIndex:(NSInteger)index;

@end
