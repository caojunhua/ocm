//
//  CustomAnnotationView.m
//  CustomAnnotationDemo
//
//  Created by songjian on 13-3-11.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "OCMHomeCustomAnnotationView.h"
#import "OCMHomeCustomCalloutView.h"

@interface OCMHomeCustomAnnotationView ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

#define kWidth  52.f
#define kHeight 78.f

#define kHoriMargin 26.f
#define kVertMargin -20.f

#define kPortraitWidth  26.f
#define kPortraitHeight 39.f

#define kCalloutWidth   210.0
#define kCalloutHeight  180.0

@implementation OCMHomeCustomAnnotationView

//@synthesize calloutView;
@synthesize portraitImageView   = _portraitImageView;
@synthesize nameLabel           = _nameLabel;

#pragma mark - Handle Action

- (void)btnAction
{
    CLLocationCoordinate2D coorinate = [self.annotation coordinate];
    
    NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
}

#pragma mark - Override

- (NSString *)name
{
    return self.nameLabel.text;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }];
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
        [UIView animateWithDuration:0.5 animations:^{
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }
    
    [super setSelected:selected animated:animated];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}
#pragma mark -- 弹出的视图的布局
- (void)layoutCallOutView {
    CGFloat leftDis = 12.f;
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftDis, 0, 173-6+35, 35)];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.calloutView addSubview:self.titleLabel];
    
    UIView *verticalView = [[UIView alloc] initWithFrame:CGRectMake(173, 8, 1, 20)];
    verticalView.backgroundColor = [UIColor RGBColorWithRed:245 withGreen:245 withBlue:245 withAlpha:1];
    [self.calloutView addSubview:verticalView];
    verticalView.hidden = YES; //隐藏竖线
    
    UIView *herizalView = [[UIView alloc] initWithFrame:CGRectMake(0, 36, kCalloutWidth, 1)];
    herizalView.backgroundColor = [UIColor RGBColorWithRed:245 withGreen:245 withBlue:245 withAlpha:1];
    [self.calloutView addSubview:herizalView];
    
    self.moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(174, 0, 35, 35)];
    [self.moreBtn setImage:ImageIs(@"more") forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.calloutView addSubview:self.moreBtn];
    self.moreBtn.hidden = YES;//隐藏按钮
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftDis, 36, 80-9, 25)];
    self.numberLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.numberLabel.font = [UIFont systemFontOfSize:11];
    [self.calloutView addSubview:self.numberLabel];
    
    self.connetctLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 36, kCalloutWidth - 80, 20)];
    self.connetctLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.connetctLabel.font = [UIFont systemFontOfSize:11];
    self.connetctLabel.textAlignment = NSTextAlignmentCenter;
    [self.calloutView addSubview:self.connetctLabel];
    
    self.starsLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftDis, 58, 100-9, 25)];
    self.starsLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.starsLabel.font = [UIFont systemFontOfSize:11];
    [self.calloutView addSubview:self.starsLabel];
    
    self.telLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftDis, 80, kCalloutWidth-9, 25)];
    self.telLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.telLabel.font = [UIFont systemFontOfSize:11];
    [self.calloutView addSubview:self.telLabel];
    //4个按钮
    self.warningBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftDis, 110, 35, 20)];
    [self.warningBtn setTitle:@"预警" forState:UIControlStateNormal];
    [_warningBtn setTitleColor:[UIColor colorWithHexString:@"#ed1e1e"] forState:UIControlStateNormal];
    _warningBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    ViewBorder(_warningBtn, 1, [UIColor colorWithHexString:@"#ed1e1e"], 3);
    [self.calloutView addSubview:self.warningBtn];
    
    self.checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(61, 110, 35, 20)];
    [_checkBtn setTitle:@"考核" forState:UIControlStateNormal];
    [_checkBtn setTitleColor:[UIColor colorWithHexString:@"#ed891e"] forState:UIControlStateNormal];
    _checkBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    ViewBorder(_checkBtn, 1, [UIColor colorWithHexString:@"#ed891e"], 3);
    [self.calloutView addSubview:self.checkBtn];
    
    self.taskBtn = [[UIButton alloc] initWithFrame:CGRectMake(115, 110, 35, 20)];
    [_taskBtn setTitle:@"任务" forState:UIControlStateNormal];
    [_taskBtn setTitleColor:[UIColor colorWithHexString:@"#05a805"] forState:UIControlStateNormal];
    _taskBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    ViewBorder(_taskBtn, 1, [UIColor colorWithHexString:@"#05a805"], 3);
    [self.calloutView addSubview:self.taskBtn];
    
    self.signBtn = [[UIButton alloc] initWithFrame:CGRectMake(162, 110, 35, 20)];
    [self.signBtn setTitle:@"签到" forState:UIControlStateNormal];
    self.signBtn.backgroundColor = [UIColor colorWithHexString:@"#009dec"];
    ViewBorder(_signBtn, 1, [UIColor clearColor], 3);
    _signBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.calloutView addSubview:_signBtn];
    
    self.netInfoBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftDis, 140, 83, 20)];
    self.netInfoBtn.backgroundColor = [UIColor colorWithHexString:@"009dec"];
    [self.netInfoBtn setTitle:@"网点信息" forState:UIControlStateNormal];
    [self.netInfoBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.netInfoBtn.titleLabel setTextColor:[UIColor whiteColor]];
    ViewBorder(self.netInfoBtn, 1, [UIColor clearColor], 5);
    [self.calloutView addSubview:self.netInfoBtn];
    
    self.naviBtn = [[UIButton alloc] initWithFrame:CGRectMake(115, 140, 83, 20)];
    self.naviBtn.backgroundColor = [UIColor colorWithHexString:@"009dec"];
    [self.naviBtn setTitle:@"导航到这里" forState:UIControlStateNormal];
    [self.naviBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [self.naviBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    ViewBorder(self.naviBtn, 1, [UIColor clearColor], 5);
    [self.calloutView addSubview:self.naviBtn];
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
        
        self.backgroundColor = [UIColor clearColor];
        
        /* Create portrait image view and add to view hierarchy. */
        self.portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 0, kPortraitWidth, kPortraitHeight)];
        [self addSubview:self.portraitImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 3, 20, 20)];
        self.nameLabel.backgroundColor  = [UIColor clearColor];
        self.nameLabel.textAlignment    = NSTextAlignmentCenter;
        self.nameLabel.font             = [UIFont systemFontOfSize:15.f];
        [self addSubview:self.nameLabel];
        
        self.calloutView = [[OCMHomeCustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
        self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                              -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        
        [self layoutCallOutView];
        
    }
    
    return self;
}

@end


