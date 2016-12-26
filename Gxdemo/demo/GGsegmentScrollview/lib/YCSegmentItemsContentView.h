//
//  YCSegmentItemsContentView.h
//  GGsegmentScrollview
//
//  Created by heyudongfang on 16/4/18.
//  Copyright © 2016年 heyudongfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCSegmentViewTitleItem.h"

@protocol YCSegmentItemsContentViewDelegate;

@protocol YCSegmentItemsContentViewDelegate <NSObject>

-(void)didSelectedButtonAtIndex:(NSInteger)index;

@end
@interface YCSegmentItemsContentView : UIView

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString*>*)titles;

@property (nonatomic,assign) id<YCSegmentItemsContentViewDelegate> delegate;
@property (nonatomic,assign) NSInteger page;

///非选中颜色
@property (nonatomic,strong) UIColor *normalColor;
///选中颜色
@property (nonatomic,strong) UIColor *highlightColor;
///字体
@property (nonatomic,strong) UIFont  *font;

@end
