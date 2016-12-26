//
//  YCSegmentView.h
//  GGsegmentScrollview
//
//  Created by heyudongfang on 16/4/18.
//  Copyright © 2016年 heyudongfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCSegmentView : UIView

///非选中颜色
@property(nonatomic,strong) UIColor *normalColor;
///选中颜色
@property(nonatomic,strong) UIColor *highlightColor;
/// 字体
@property(nonatomic,strong) UIFont *font;

-(instancetype)initWithFrame:(CGRect)frame titleHeight:(CGFloat)height viewControllers:(NSArray <UIViewController *>*)viewControlers;
@end
