//
//  YTextField.m
//  Libs
//
//  Created by wangyang on 14-1-2.
//  Copyright (c) 2014年 wangyang. All rights reserved.
//

#import "YTextField.h"

#define TAG_BEGIN_WITH -700
#define MARGIN_KEYBOARD 15

@implementation YTextField
{
    UIToolbar *_toolbar;
    
    __weak UIScrollView *_parentScrollView;  //用以实现滚动，防止键盘挡住输入框
    
    UIBarButtonItem *_previousBarButton;
    UIBarButtonItem *_nextBarButton;
    
    BOOL _isEnd;
}

#pragma mark - init
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self Y_initialization];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self)
    {
        [self Y_initialization];
    }
    return self;
}

-(void)Y_initialization
{
    //初始化属性
    self.isNeedToolBar=YES;
    self.isAutoValidate=YES;
    self.validateRegExpDic=nil;
    _autoValidateCompletionBlockWithSuccess=^(){};
    _autoValidateCompletionBlockWithFailure=^(NSString *failureInfo){
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"输入错误"
                                                      message:failureInfo
                                                     delegate:nil
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil];
        [alert show];
    };
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Y_textFieldBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Y_textFieldEndEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
    
    _toolbar = [[UIToolbar alloc] init];
    _toolbar.frame = CGRectMake(0, 0, self.window.frame.size.width, 35);
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [_toolbar setBarStyle:UIBarStyleDefault];
    }
    else
    {
        [_toolbar setBarStyle:UIBarStyleBlack];
    }
    
    _previousBarButton = [[UIBarButtonItem alloc] initWithTitle:@"前一项"
                                                          style:UIBarButtonItemStyleBordered
                                                         target:self
                                                         action:@selector(previousButtonClicked:)];
    _nextBarButton = [[UIBarButtonItem alloc] initWithTitle:@"后一项"
                                                      style:UIBarButtonItemStyleBordered
                                                     target:self
                                                     action:@selector(nextButtonClicked:)];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                   target:self
                                                                                   action:@selector(doneButtonClicked:)];
    
    NSArray *barButtonItems = @[_previousBarButton, _nextBarButton, flexBarButton, doneBarButton];
    
    _toolbar.items = barButtonItems;
}

#pragma mark - public method
//进行验证
-(BOOL)validateInput
{
    if (self.validateRegExpDic)
    {
        for (NSString *key_regExp in [self.validateRegExpDic allKeys])
        {
            if(![self isString:self.text matchRegExp:key_regExp])
            {
                _invalidInfo=[self.validateRegExpDic objectForKey:key_regExp];
                return NO;
            }
        }
    }
    
    return YES;
}

-(void)setAutoValidateCompletionBlockWithSuccess:(void(^)(void))successBlock
                                         failure:(void(^)(NSString *failureInfo))failure
{
    _autoValidateCompletionBlockWithSuccess=successBlock;
    _autoValidateCompletionBlockWithFailure=failure;
}

#pragma mark - functional
//给父view 里的所有 UITextField UITextView 按照从上到下，从左到右的顺序设置 tag,从 TAG_BEGIN_WITH 开始
-(void)setAllYTextFieldTagInSuperView
{
    NSMutableArray *allYTextField=[[NSMutableArray alloc] init];

    for (UIView *subView in [self getAllSubViewsInView:self.window])
    {
        if ([subView isKindOfClass:[UITextField class]] || [subView isKindOfClass:[UITextView class]])
        {
            [allYTextField addObject:subView];
        }
    }
    
    //按位置排序
    NSArray *allTextAfterSorted = [allYTextField sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        UIView *obj1_view=(UIView *)obj1;
        UIView *obj2_view=(UIView *)obj2;
        
        CGPoint view1_origin = [self.window convertPoint:obj1_view.frame.origin fromView:obj1_view.superview];
        CGPoint view2_origin = [self.window convertPoint:obj2_view.frame.origin fromView:obj2_view.superview];
        
        if (view1_origin.y<view2_origin.y)
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        else if(view1_origin.y>view2_origin.y)
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        else
        {
            if (view1_origin.x<view2_origin.x)
            {
                return (NSComparisonResult)NSOrderedAscending;
            }
            else
            {
                return (NSComparisonResult)NSOrderedDescending;
            }
        }
    }];
    
    for (NSInteger i=0; i<[allTextAfterSorted count]; i++)
    {
        ((UIView *)[allTextAfterSorted objectAtIndex:i]).tag=TAG_BEGIN_WITH+i;
    }
    
    if (self.tag==TAG_BEGIN_WITH+[allTextAfterSorted count]-1)
    {
        _isEnd=YES;
    }
    else
    {
        _isEnd=NO;
    }
}

//设置 toolbar
-(void)setToolbarForSelf
{
    if (self.isNeedToolBar)
    {
        _nextBarButton.enabled=!_isEnd;
        
        if (self.tag==TAG_BEGIN_WITH)
        {
            _previousBarButton.enabled=NO;
        }
        else
        {
            _previousBarButton.enabled=YES;
        }
        
        self.inputAccessoryView=_toolbar;
    }
}

-(UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve
{
    switch (curve) {
        case UIViewAnimationCurveEaseInOut:
            return UIViewAnimationOptionCurveEaseInOut;
            break;
        case UIViewAnimationCurveEaseIn:
            return UIViewAnimationOptionCurveEaseIn;
            break;
        case UIViewAnimationCurveEaseOut:
            return UIViewAnimationOptionCurveEaseOut;
            break;
        case UIViewAnimationCurveLinear:
            return UIViewAnimationOptionCurveLinear;
            break;
    }
    
    return kNilOptions;
}

//字符串是否匹配给定的正则表达式
-(BOOL)isString:(NSString *)str matchRegExp:(NSString *)regExpString
{
    NSRegularExpression *regExp=[NSRegularExpression regularExpressionWithPattern:regExpString
                                                                          options:NSRegularExpressionCaseInsensitive
                                                                            error:nil];
    
    NSInteger num=[regExp numberOfMatchesInString:str options:0 range:NSMakeRange(0, str.length)];
    
    if(num>0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(NSArray*)getAllSubViewsInView:(UIView*)view
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:view];
    
    for (UIView *subview in view.subviews)
    {
        [arr addObjectsFromArray:(NSArray*)[self getAllSubViewsInView:subview]];
    }
    
    return arr;
}

#pragma mark - actions
-(void)previousButtonClicked:(id)sender
{
    UIView *previousTextField=(UIView*)[self.window viewWithTag:self.tag-1];
    [previousTextField becomeFirstResponder];
}

-(void)nextButtonClicked:(id)sender
{
    UIView *nextTextField=(UIView*)[self.window viewWithTag:self.tag+1];
    [nextTextField becomeFirstResponder];
}

-(void)doneButtonClicked:(id)sender
{
    [self resignFirstResponder];
}

#pragma mark - UITextField notifications
-(void)Y_textFieldBeginEditing:(NSNotification *)notification
{
    UIView *superView=self.superview;
    _parentScrollView=nil;
    
    while (superView)
    {
        if ([superView isKindOfClass:[UIScrollView class]])
        {
            _parentScrollView = (UIScrollView *)superView;
            break;
        }
        
        superView=superView.superview;
    }
    
    if (_parentScrollView)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Y_keyboardWillShowOrHide:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Y_keyboardWillShowOrHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    [self setAllYTextFieldTagInSuperView];
    [self setToolbarForSelf];
    
    if ([self respondsToSelector:@selector(textFieldBeginEditing:)])
    {
        [self textFieldBeginEditing:notification];
    }
}

-(void)Y_textFieldEndEditing:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    if (self.isAutoValidate)
    {
        if ([self validateInput])
        {
            _autoValidateCompletionBlockWithSuccess();
        }
        else
        {
            _autoValidateCompletionBlockWithFailure(self.invalidInfo);
        }
    }
    
    if ([self respondsToSelector:@selector(textFieldEndEditing:)])
    {
        [self textFieldEndEditing:notification];
    }
}

#pragma mark - UIKeyboard notifications
-(void)Y_keyboardWillShowOrHide:(NSNotification *)notification
{
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	UIViewAnimationCurve curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
	double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (duration==0)
    {
        duration=0.2;
    }
    
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:[self animationOptionsForCurve:curve]
                     animations:^{
                         
                         //排除 superview 处于屏幕中间的情况
                         CGFloat keyboardY = keyboardRect.origin.y;
                         UIView *v=_parentScrollView;
                         keyboardY-=v.frame.origin.y;
                         
                         while (v.superview)
                         {
                             keyboardY-=v.superview.frame.origin.y;
                             v=v.superview;
                         }
                         
                         UIEdgeInsets insets = UIEdgeInsetsMake(0.0f,
                                                                0.0f,
                                                                _parentScrollView.bounds.size.height-keyboardY,
                                                                0.0f);
                         _parentScrollView.contentInset = insets;

                         CGPoint origin = [_parentScrollView convertPoint:self.frame.origin fromView:self.superview];
                         CGFloat offset=origin.y +self.frame.size.height + MARGIN_KEYBOARD -keyboardY;
                         
                         if (offset<0)
                         {
                             offset=0;
                         }
                         
                         [_parentScrollView setContentOffset:CGPointMake(0, offset) animated:NO];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}
@end
