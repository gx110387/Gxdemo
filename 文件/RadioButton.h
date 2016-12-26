//
//  RadioButton.h
//  MovieInfo
//
//  Created by sunlg on 10-12-3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
//gaoxing

#import <UIKit/UIKit.h>


@protocol RadioButtonDelegate;

@interface RadioButton : UIButton {
	BOOL _isChecked;
}
@property (nonatomic,assign) BOOL isChecked;

@property (assign) id<RadioButtonDelegate> delegate;

- (id)initWithFrame:(CGRect)frame typeCheck:(BOOL)type_check;
- (void)resultReponse:(BOOL)boolchange buttonTag:(NSInteger)BTag;
- (void)setSelectImage:(UIImage *)selectimage unSelectImage:(UIImage *)unselectimage;
@end


@protocol RadioButtonDelegate
- (void)radioButtonChange:(RadioButton *)radiobutton didSelect:(BOOL)boolchange didSelectButtonTag:(NSInteger )tagselect;
@end