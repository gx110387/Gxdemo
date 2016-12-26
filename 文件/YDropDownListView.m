//
//  YDropDownListView.m
//  ztesoftLibs2
//
//  Created by wangyang on 14-6-19.
//  Copyright (c) 2014年 ztesoft. All rights reserved.
//

#import "YDropDownListView.h"

#pragma mark - YTriangleView
@interface YTriangleView : UIView

@property (strong,nonatomic) UIColor *triangleColor;

@end

@implementation YTriangleView

-(id)init
{
    self=[super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, 0, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width/2, 0);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextAddLineToPoint(context, 0, rect.size.height);
    
    CGContextSetFillColorWithColor(context, self.triangleColor.CGColor);
    CGContextFillPath(context);
}

@end

#pragma mark - YDropDownListView
@interface YDropDownListView ()

@property (strong,nonatomic) NSArray *items;
@property (strong,nonatomic) UIButton *bgButton;
@property (strong,nonatomic) UIView *dropDownView;

@end

@implementation YDropDownListView

- (id)initWithItems:(NSArray*)items
{
    self=[super init];
    if (self)
    {
        self.items = items;
        self.bgButton = [[UIButton alloc] init];
        [self.bgButton addTarget:self action:@selector(bgButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        self.dropDownView = [[UIView alloc] init];
        self.dropDownView.backgroundColor = [UIColor darkGrayColor];
        self.dropDownView.clipsToBounds = YES;
        self.dropDownView.layer.cornerRadius = 5;
    }
    
    return self;
}

-(void)show
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[self]-0-|" options:0 metrics:nil views:@{@"self":self}]];
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[self]-0-|" options:0 metrics:nil views:@{@"self":self}]];
    
    [self addSubview:self.bgButton];
    [self.bgButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[bgButton]-0-|" options:0 metrics:nil views:@{@"bgButton":self.bgButton}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[bgButton]-0-|" options:0 metrics:nil views:@{@"bgButton":self.bgButton}]];
    
    YTriangleView *triangle = [[YTriangleView alloc] init];
    [triangle setTranslatesAutoresizingMaskIntoConstraints:NO];
    triangle.triangleColor = [UIColor darkGrayColor];
    
    [self addSubview:triangle];
    [triangle addConstraint:[NSLayoutConstraint constraintWithItem:triangle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:20]];
    [triangle addConstraint:[NSLayoutConstraint constraintWithItem:triangle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:10]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[triangle]-15-|" options:0 metrics:nil views:@{@"triangle":triangle}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[triangle]" options:0 metrics:nil views:@{@"triangle":triangle}]];
    
    [self.dropDownView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self addSubview:self.dropDownView];
    [self.dropDownView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[dropDownView]-5-|" options:0 metrics:nil views:@{@"dropDownView":self.dropDownView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[dropDownView]" options:0 metrics:nil views:@{@"dropDownView":self.dropDownView}]];
    
    UIButton *preButton = nil;
    UIButton *lastButton = nil;
    
    for (NSInteger i = 0;i<self.items.count ;i++)
    {
        NSString *title = self.items[i];
        
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTranslatesAutoresizingMaskIntoConstraints:NO];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button addTarget:self  action:@selector(itemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.dropDownView addSubview:button];
        
        [self.dropDownView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-18-[button]-18-|" options:0 metrics:nil views:@{@"button":button}]];
        [button addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:45]];
        
        if (preButton)
        {
            [self.dropDownView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[preButton]-0-[button]" options:0 metrics:nil views:@{@"button":button,@"preButton":preButton}]];
        }
        else
        {
            [self.dropDownView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[button]" options:0 metrics:nil views:@{@"button":button}]];
        }
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [line setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.dropDownView addSubview:line];
        
        [line addConstraint:[NSLayoutConstraint constraintWithItem:line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:1]];
        [self.dropDownView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-5-[line]-5-|" options:0 metrics:nil views:@{@"line":line}]];
        [self.dropDownView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button]-0-[line]" options:0 metrics:nil views:@{@"line":line,@"button":button}]];
        
        preButton = button;
        lastButton = button;
    }
    
    [self.dropDownView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastButton]-0-|" options:0 metrics:nil views:@{@"lastButton":lastButton}]];
}

-(void)itemButtonClicked:(UIButton*)button
{
    [self removeFromSuperview];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropDownListView:selectedItemsOnIndex:withTitle:)])
    {
        [self.delegate dropDownListView:self selectedItemsOnIndex:button.tag withTitle:[button titleForState:UIControlStateNormal]];
    }
}

-(void)bgButtonClicked
{
    [self removeFromSuperview];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropDownListViewDidDismiss:)])
    {
        [self.delegate dropDownListViewDidDismiss:self];
    }
}
@end
