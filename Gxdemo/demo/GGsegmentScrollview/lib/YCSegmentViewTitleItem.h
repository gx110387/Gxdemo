//
//  YCSegmentViewTitleItem.h
//  GGsegmentScrollview
//
//  Created by heyudongfang on 16/4/18.
//  Copyright © 2016年 heyudongfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCSegmentViewTitleItem : UIView

@property(nonatomic,copy) NSString *title; // 标题 我们希望可以后期更改标题

@property(nonatomic,assign) CGFloat space; // 间距 我们希望可以控制如果有多个item他们的间距

@property(nonatomic,assign) BOOL highlight;

///非选中颜色
@property (nonatomic,strong) UIColor *normalColor;
///选中颜色
@property (nonatomic,strong) UIColor *highlightColor;

///字体
@property (nonatomic,strong) UIFont  *font;

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

+(CGFloat)calcuWidth:(NSString *)title;

///添加点击事件
- (void)addTarget:(id)target action:(SEL)action;

@end
