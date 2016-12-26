//
//  YFloatingTextField.m
//  YFloatingTextField
//
//  Created by wangyang on 14-1-3.
//  Copyright (c) 2014年 wangyang. All rights reserved.
//

#import "YFloatingTextField.h"
#define FLOATING_LABEL_MARGIN_TOP 1

@implementation YFloatingTextField
{
    UILabel *_floatingLabel;

    NSString *_warningMessage;
}

#pragma mark - init
-(id)init
{
    self=[super init];
    if (self)
    {
        [self YF_initialization];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self YF_initialization];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self)
    {
        [self YF_initialization];
    }
    return self;
}

-(void)YF_initialization
{
    _floatingLabel = [[UILabel alloc] init];
    [_floatingLabel setBackgroundColor:[UIColor clearColor]];
    _floatingLabel.alpha = 0.0f;
    _floatingLabel.font = [UIFont boldSystemFontOfSize:11.0f];
    [_floatingLabel setFrame:CGRectMake(0, FLOATING_LABEL_MARGIN_TOP, self.frame.size.width, _floatingLabel.font.lineHeight)];
    [self addSubview:_floatingLabel];
    
    self.floatingDefaultColor = [UIColor grayColor];
    self.floatingWarningColor = [UIColor redColor];
    
    if ([self respondsToSelector:@selector(tintColor)])
    {
        self.floatingHighlightColor = [self performSelector:@selector(tintColor)];
    }
    else
    {
        self.floatingHighlightColor=[UIColor blueColor];
    }
    
    __block YFloatingTextField *blockSelf=self;
    _autoValidateCompletionBlockWithFailure=^(NSString *failureInfo){
        
        [blockSelf showFloatingWarningMessage:failureInfo];
    };
}

#pragma mark - public method
-(void)showFloatingWarningMessage:(NSString *)message
{
    _warningMessage=message;
    _floatingLabel.text = message;
    _floatingLabel.textColor=self.floatingWarningColor;
    
    [self showFloatingLabel:self.isFirstResponder];
}

#pragma mark - layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.isFirstResponder && self.text && self.text.length > 0)
    {
        _floatingLabel.textColor = self.floatingHighlightColor;
    }
    else if(!self.isFirstResponder && [_floatingLabel.text isEqualToString:_warningMessage])
    {
        _floatingLabel.textColor = self.floatingWarningColor;
    }
    else
    {
        _floatingLabel.textColor = self.floatingDefaultColor;
    }
    
    if (self.isFirstResponder || ![_floatingLabel.text isEqualToString:_warningMessage])
    {
        if ((self.text && [self.text length]>0))
        {
            _floatingLabel.text = self.placeholder;
            [self showFloatingLabel:self.isFirstResponder];
        }
        else
        {
            [self hideFloatingLabel:self.isFirstResponder];
        }
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect([super textRectForBounds:bounds],
                                 UIEdgeInsetsMake(ceilf(_floatingLabel.font.lineHeight),
                                                  0.0f,
                                                  0.0f,
                                                  0.0f));
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect([super editingRectForBounds:bounds],
                                 UIEdgeInsetsMake(ceilf(_floatingLabel.font.lineHeight),
                                                  0.0f,
                                                  0.0f,
                                                  0.0f));
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    CGRect rect = [super clearButtonRectForBounds:bounds];
    rect = CGRectMake(rect.origin.x,
                      rect.origin.y + (_floatingLabel.font.lineHeight / 2.0),
                      rect.size.width,
                      rect.size.height);
    return rect;
}

#pragma mark - show & hide
- (void)showFloatingLabel:(BOOL)animated
{
    void (^showBlock)() = ^{
        _floatingLabel.alpha = 1.0f;
        _floatingLabel.frame = CGRectMake(0,
                                          FLOATING_LABEL_MARGIN_TOP,
                                          self.frame.size.width,
                                          _floatingLabel.font.lineHeight);
    };
    
    if (animated)
    {
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut
                         animations:showBlock
                         completion:nil];
    }
    else
    {
        showBlock();
    }
}

- (void)hideFloatingLabel:(BOOL)animated
{
    void (^hideBlock)() = ^{
        _floatingLabel.alpha = 0.0f;
        _floatingLabel.frame = CGRectMake(0,
                                          _floatingLabel.font.lineHeight,
                                          self.frame.size.width,
                                          _floatingLabel.font.lineHeight);
    };
    
    if (animated)
    {
        [UIView animateWithDuration:0.15f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseIn
                         animations:hideBlock
                         completion:nil];
    }
    else
    {
        hideBlock();
    }
}

#pragma mark - getter & setter
- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    [_floatingLabel setTextAlignment:self.textAlignment];
    
    [self setNeedsLayout];
}

@end
