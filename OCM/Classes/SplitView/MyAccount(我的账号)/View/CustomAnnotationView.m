//
//  CustomAnnotationView.m
//  CustomAnnotationDemo
//
//  Created by songjian on 13-3-11.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"

#define kWidth  52.f
#define kHeight 78.f

#define kHoriMargin 26.f
#define kVertMargin -20.f

#define kPortraitWidth  26.f
#define kPortraitHeight 39.f

#define kCalloutWidth   210.0
#define kCalloutHeight  120.0

@interface CustomAnnotationView ()

@property (nonatomic, strong) UIImageView *portraitImageView;

@end

@implementation CustomAnnotationView

//@synthesize calloutView;
@synthesize portraitImageView   = _portraitImageView;
@synthesize nameLabel           = _nameLabel; // 重写setter getter
@synthesize titleLabel          = _titleLabel;

#pragma mark - Handle Action

- (void)btnAction
{
    CLLocationCoordinate2D coorinate = [self.annotation coordinate];
    
//    NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
    self.clickMoreBlock(coorinate);
}

#pragma mark - Override
- (void)setPhoneNumber:(NSString *)phoneNumber {
    self.telLabel.text = [NSString stringWithFormat:@"联系电话 : %@",phoneNumber];
}
- (void)setStarsInfo:(NSString *)starsInfo {
    self.starsLabel.text = starsInfo;
}
- (void)setNumber:(NSString *)number {
    self.numberLabel.text = number;
}
- (void)setConnectPeople:(NSString *)connectPeople {
    self.connetctLabel.text = [NSString stringWithFormat:@"网点联系人 : %@",connectPeople];
}
- (NSString *)name
{
    return self.nameLabel.text;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}


- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
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
        if (self.calloutView == nil)
        {
            /* Construct custom callout. */
//            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
//            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
//                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
//
//            [self layoutCallOutView];
        }
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
#pragma mark -- 弹出的视图的布局
- (void)layoutCallOutView {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, 173-6, 35)];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.calloutView addSubview:self.titleLabel];
    
    UIView *verticalView = [[UIView alloc] initWithFrame:CGRectMake(173, 8, 1, 20)];
    verticalView.backgroundColor = [UIColor RGBColorWithRed:245 withGreen:245 withBlue:245 withAlpha:1];
    [self.calloutView addSubview:verticalView];
    
    UIView *herizalView = [[UIView alloc] initWithFrame:CGRectMake(0, 36, kCalloutWidth, 1)];
    herizalView.backgroundColor = [UIColor RGBColorWithRed:245 withGreen:245 withBlue:245 withAlpha:1];
    [self.calloutView addSubview:herizalView];
    
    self.moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(174, 0, 35, 35)];
    [self.moreBtn setImage:ImageIs(@"more") forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.calloutView addSubview:self.moreBtn];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(9, 36, 80-9, 25)];
    self.numberLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.numberLabel.font = [UIFont systemFontOfSize:11];
    [self.calloutView addSubview:self.numberLabel];
    
    self.connetctLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 36, kCalloutWidth - 80, 20)];
    self.connetctLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.connetctLabel.font = [UIFont systemFontOfSize:11];
    self.connetctLabel.textAlignment = NSTextAlignmentCenter;
    [self.calloutView addSubview:self.connetctLabel];
    
    self.starsLabel = [[UILabel alloc] initWithFrame:CGRectMake(9, 58, 100-9, 25)];
    self.starsLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.starsLabel.font = [UIFont systemFontOfSize:11];
    [self.calloutView addSubview:self.starsLabel];
    
    self.telLabel = [[UILabel alloc] initWithFrame:CGRectMake(9, 80, kCalloutWidth-9, 25)];
    self.telLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.telLabel.font = [UIFont systemFontOfSize:11];
    [self.calloutView addSubview:self.telLabel];
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
        
        self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
        self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                              -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        
        [self layoutCallOutView];
    }
    
    return self;
}

@end
