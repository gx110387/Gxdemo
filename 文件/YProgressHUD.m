//
//  YProgressHUD.m
//  Libs
//
//  Created by wangyang on 13-12-27.
//  Copyright (c) 2013年 wangyang. All rights reserved.
//

#import "YProgressHUD.h"

#define STATUS_TEXT_FONT 16
#define CONTENT_MAX_WIDTH 150
#define MARGIN_BOTTOM_WHEN_AT_BOTTOM 20


@implementation YProgressHUD
{
    BOOL _isShowing;
    UIButton *_maskView;
    UIView *_contentView;
    UILabel *_statusLabel;
}

+(YProgressHUD*)sharedProgressHUD
{
    static YProgressHUD *_obj;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _obj = [[YProgressHUD alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    
    _obj.duration=0.0;
    _obj.frame =[UIScreen mainScreen].bounds;
    return _obj;
}

+(void)showToastWithStatus:(NSString*)status duration:(NSTimeInterval)duration
{
    YProgressHUD *hud=[YProgressHUD sharedProgressHUD];
    hud.HUDMaskType=YProgressHUDMaskTypeNone;
    hud.HUDPosition=YProgressHUDPositionBottom;
    hud.status=status;
    hud.statusView=nil;
    hud.duration=duration;
    
    [hud show];
}

-(id)init
{
    self = [self initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        
    }
    
    return self;
}

-(id)initWithStatus:(NSString *)status
{
    self=[self initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        self.status=status;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _isShowing=NO;
        self.HUDMaskType=YProgressHUDMaskTypeBlack;
        self.HUDPosition=YProgressHUDPositionCenter;
        
        _maskView = [[UIButton alloc] initWithFrame:frame];
        _maskView.backgroundColor=[UIColor clearColor];
        [_maskView addTarget:self action:@selector(maskViewClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_maskView];
        
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.9];
        _contentView.layer.cornerRadius = 7;
        _contentView.layer.masksToBounds = YES;
        
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [indicatorView startAnimating];
        self.statusView=indicatorView;
        
        self.status=@"";
        _statusLabel=[[UILabel alloc] init];
        _statusLabel.textAlignment=NSTextAlignmentCenter;
        _statusLabel.numberOfLines=0;
        _statusLabel.backgroundColor=[UIColor clearColor];
        _statusLabel.textColor=[UIColor whiteColor];
        [_statusLabel setFont:[UIFont systemFontOfSize:STATUS_TEXT_FONT]];
        
//        [_contentView addSubview:self.statusView];
        [_contentView addSubview:_statusLabel];
        [self addSubview:_contentView];
        
        self.duration=0.0;
    }
    
    return self;
}

-(void)positionSubviews
{
    float totalWidth=0;
    float totalHeight=0;
    
    if (self.statusView)
    {
        totalHeight=self.statusView.frame.size.height+30;
        totalWidth=self.statusView.frame.size.width+30;
        self.statusView.hidden=NO;
    }
    else
    {
        self.statusView.hidden=YES;
        totalHeight=10;
    }
    
    if (self.status && ![self.status isEqualToString:@""])
    {
        float statusTextWidth;
        float statusTextHeight;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            statusTextWidth=[self.status sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:STATUS_TEXT_FONT]}].width;
            statusTextHeight=[self.status sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:STATUS_TEXT_FONT]}].height;
        }
        else
        {
            statusTextWidth=[self.status sizeWithFont:[UIFont systemFontOfSize:STATUS_TEXT_FONT]].width;
            statusTextHeight=[self.status sizeWithFont:[UIFont systemFontOfSize:STATUS_TEXT_FONT]].height;
        }

        float maxWidth=CONTENT_MAX_WIDTH;
        if (self.HUDPosition==YProgressHUDPositionBottom)
        {
            maxWidth=self.frame.size.width-70;
        }
        
        if (statusTextWidth>maxWidth)
        {
            statusTextWidth=maxWidth;

            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            {
                statusTextHeight=[self.status boundingRectWithSize:CGSizeMake(statusTextWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:STATUS_TEXT_FONT]} context:nil].size.height;
            }
            else
            {
                statusTextHeight=[self.status sizeWithFont:[UIFont systemFontOfSize:STATUS_TEXT_FONT] constrainedToSize:CGSizeMake(statusTextWidth, MAXFLOAT)].height;
            }
        }

        totalHeight+=statusTextHeight+10;
        totalWidth=totalWidth>statusTextWidth+30?totalWidth:statusTextWidth+30;
        
        [_statusLabel setFrame:CGRectMake((totalWidth-statusTextWidth)/2, totalHeight-statusTextHeight-10, statusTextWidth, statusTextHeight)];
        _statusLabel.text=self.status;
        _statusLabel.hidden=NO;
    }
    else
    {
        _statusLabel.hidden=YES;
    }
    
    if (self.HUDPosition==YProgressHUDPositionCenter)
    {
        [_contentView setFrame:CGRectMake(self.center.x-totalWidth/2, self.center.y-totalHeight/2, totalWidth, totalHeight)];
    }
    else
    {
//        [_contentView setCenter:CGPointMake(self.center.x, self.frame.size.height-_contentView.frame.size.height/2-MARGIN_BOTTOM_WHEN_AT_BOTTOM)];
        
        [_contentView setFrame:CGRectMake(self.center.x-totalWidth/2,self.frame.size.height- MARGIN_BOTTOM_WHEN_AT_BOTTOM-totalHeight, totalWidth, totalHeight)];
    }
    
    [self.statusView setFrame:CGRectMake((totalWidth-self.statusView.frame.size.width)/2, 15, self.statusView.frame.size.width, self.statusView.frame.size.height)];

    if (self.HUDMaskType==YProgressHUDMaskTypeClear)
    {
        _maskView.backgroundColor=[UIColor clearColor];
        _maskView.hidden=NO;
        self.userInteractionEnabled=YES;
    }
    else if(self.HUDMaskType==YProgressHUDMaskTypeBlack)
    {
        _maskView.backgroundColor=[UIColor blackColor];
        _maskView.hidden=NO;
        _maskView.alpha=0.3;
        self.userInteractionEnabled=YES;
    }
    else
    {
        _maskView.hidden=YES;
        self.userInteractionEnabled=NO;
    }
}

-(void)show
{
    _maskView.frame = self.frame;
    _shownCount++;
    
    if (_isShowing)
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            [self positionSubviews];
        }];
        
        return;
    }
    
    self.alpha=0;
    _isShowing=YES;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [window endEditing:YES];
    
    [self positionSubviews];
    
    [self registerNotifications];
    
    if (self.duration > 0.0)
    {
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:self.duration];
    }
}

-(void)dismiss
{
    _shownCount--;
    if (_shownCount<0)
    {
        _shownCount=0;
    }
    
    if (!_isShowing || _shownCount>0)
    {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDidStopSelector:@selector(toRemoveSelf)];
    [UIView setAnimationDelegate:self];
    
    self.alpha = 0;

    [UIView commitAnimations];
}

-(void)dismissIgnoreShownCount
{
    _shownCount=1;
    
    [self dismiss];
}

-(void)willMoveToWindow:(UIWindow *)newWindow
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    
    self.alpha = 1.0;
    
    [UIView commitAnimations];
}

-(void)toRemoveSelf
{
    _isShowing=NO;
    [self removeFromSuperview];
}

#pragma mark - Notifications
- (void)registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(positionHUDWhenRotate:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}

- (void)positionHUDWhenRotate:(NSNotification*)notification
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGRect orientationFrame = [UIScreen mainScreen].bounds;
    
    if(UIInterfaceOrientationIsLandscape(orientation))
    {
        float temp = orientationFrame.size.width;
        orientationFrame.size.width = orientationFrame.size.height;
        orientationFrame.size.height = temp;
    }
    
    CGPoint newCenter;
    CGFloat rotateAngle;
    
    float min=_contentView.frame.size.width<_contentView.frame.size.height?_contentView.frame.size.width:_contentView.frame.size.height;
    
    switch (orientation)
    {
        case UIInterfaceOrientationPortraitUpsideDown:
            rotateAngle = M_PI;
            newCenter = CGPointMake(self.frame.size.width/2, MARGIN_BOTTOM_WHEN_AT_BOTTOM+min/2);
            break;
        case UIInterfaceOrientationLandscapeLeft:
            rotateAngle = -M_PI/2.0f;
            newCenter = CGPointMake(self.frame.size.width-MARGIN_BOTTOM_WHEN_AT_BOTTOM-min/2, self.frame.size.height/2);
            break;
        case UIInterfaceOrientationLandscapeRight:
            rotateAngle = M_PI/2.0f;
            newCenter = CGPointMake(MARGIN_BOTTOM_WHEN_AT_BOTTOM+min/2, self.frame.size.height/2);
            break;
        default: // as UIInterfaceOrientationPortrait
            rotateAngle = 0.0;
            newCenter = CGPointMake(self.frame.size.width/2,self.frame.size.height-MARGIN_BOTTOM_WHEN_AT_BOTTOM-min/2);
            break;
    }
    
    _contentView.transform = CGAffineTransformMakeRotation(rotateAngle);
    
    if (self.HUDPosition==YProgressHUDPositionBottom)
    {
        _contentView.center=newCenter;
    }
}

#pragma mark - actions
-(void)maskViewClicked:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(userDidTappedMask)])
    {
        [self.delegate userDidTappedMask];
    }
}

#pragma mark - setter & getter
-(void)setDuration:(NSTimeInterval)duration
{
    if (duration > 0.0)
    {
        _duration = duration;
        if (_isShowing)
        {
            [self performSelector:@selector(dismissIgnoreShownCount) withObject:nil afterDelay:_duration];
        }
    }
}

-(void)setStatusView:(UIView *)statusView
{
    if (!statusView)
    {
        [_statusView removeFromSuperview];
        _statusView=nil;
    }
    else
    {
        [_statusView removeFromSuperview];
        
        _statusView=statusView;
        [_contentView addSubview:_statusView];
    }
}
@end
