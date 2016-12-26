//
//  YCheckBox.m
//  ztesoftLibs
//
//  Created by wangyang on 13-11-9.
//  Copyright (c) 2013年 ztesoft. All rights reserved.
//

#import "YCheckBox.h"

@implementation YCheckBox
#pragma mark - init
-(id)init
{
    self = [super init];
    if (self)
    {
        [self doSomeInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self doSomeInit];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self doSomeInit];
    }
    return self;
}

-(void)doSomeInit
{
    self.exclusiveTouch = YES;
    [self addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - actions
-(void)buttonClicked
{
    [self setChecked:![self checked]];
}

#pragma mark - getter and setter
-(void)setChecked:(BOOL)checked
{
    if (self.selected==checked)
    {
        return;
    }
    
    self.selected=checked;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(checkBox:checked:)])
    {
        [self.delegate checkBox:self checked:checked];
    }
}

-(BOOL)checked
{
    return self.selected;
}

@end
