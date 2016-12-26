    //
//  RadioButton.m
//  MovieInfo
//
//  Created by sunlg on 10-12-3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RadioButton.h"


@implementation RadioButton
{
    UIImage *_selectImage;
    UIImage *_unSelectImage;
}

@synthesize isChecked = _isChecked;

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame typeCheck:(BOOL)type_check{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		
		//self.frame =frame;
		self.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentLeft;
		self.isChecked =type_check;

		[self addTarget:self action:@selector(checkBoxClicked) forControlEvents:UIControlEventTouchUpInside];
	}
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        
        //self.frame =frame;
        self.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentLeft;
        self.isChecked = false;
        
        [self addTarget:self action:@selector(checkBoxClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void) checkBoxClicked{
	self.isChecked = !self.isChecked;
	[self resultReponse:self.isChecked buttonTag:self.tag];
	
}
-(void)setIsChecked:(BOOL)isChecked
{
    _isChecked = isChecked;
    if (isChecked) {
        [self setImage:_selectImage forState:UIControlStateNormal];
    }else {
        [self setImage:_unSelectImage forState:UIControlStateNormal];
    }
}
- (void)resultReponse:(BOOL)boolchange buttonTag:(NSInteger)BTag{
	if (delegate) {
		[delegate radioButtonChange:self didSelect:boolchange didSelectButtonTag:BTag];
	}
	
}
- (void)setSelectImage:(UIImage *)selectimage unSelectImage:(UIImage *)unselectimage{
    _selectImage = selectimage;
    _unSelectImage = unselectimage;
}

@end
