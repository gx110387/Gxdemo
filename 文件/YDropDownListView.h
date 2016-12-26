//
//  YDropDownListView.h
//  ztesoftLibs2
//
//  Created by wangyang on 14-6-19.
//  Copyright (c) 2014年 ztesoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YDropDownListViewDelegate;
/**
 *  下拉框
 */
@interface YDropDownListView : UIView

@property (weak,nonatomic) id<YDropDownListViewDelegate> delegate;

- (id)initWithItems:(NSArray*)items;

-(void)show;

@end

@protocol YDropDownListViewDelegate <NSObject>

-(void)dropDownListView:(YDropDownListView*)dropDownListView selectedItemsOnIndex:(NSInteger)index withTitle:(NSString*)title;

-(void)dropDownListViewDidDismiss:(YDropDownListView*)dropDownListView;

@end
