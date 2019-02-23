//
//  OCMRemunView.m
//  OCM
//
//  Created by 曹均华 on 2017/12/28.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMRemunView.h"

@interface OCMRemunView ()

@end

@implementation OCMRemunView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setViews];
    }
    return self;
}
- (void)setViews {
    self.upView = [UIView new];//上部分矩形
    self.upView.frame = CGRectMake(0, 0, self.width, 540);
    ViewBorder(self.upView, 1, [UIColor colorWithHexString:@"cccccc"], 0);
    [self addSubview:self.upView];
    /*-------topView--------*/
    {
        self.topView = [UIView new];
        self.topView.frame = CGRectMake(0, 0, self.width, 50);
        self.topView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];//colorWithHexString:@"f9f9f9"
        [self.upView addSubview:self.topView];
        
        CGFloat topSubViewsY = 17;
        self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(17, topSubViewsY, 180, 17)];
        self.titleL.font = [UIFont systemFontOfSize:17];
        self.titleL.textColor = [UIColor colorWithHexString:@"666666"];
        [self.topView addSubview:self.titleL];
        
        self.rightArrBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 26, topSubViewsY, 11, 20)];
        [self.rightArrBtn setImage:[UIImage imageNamed:@"icon_inforeward_right"] forState:UIControlStateNormal];
        [self.topView addSubview:self.rightArrBtn];
        self.yearsScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(self.width - 200, topSubViewsY, 150, 20)];
        [self.yearsScrollV setBackgroundColor:[UIColor clearColor]];
        
        [self.topView addSubview:self.yearsScrollV];
        self.leftArrBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 235, topSubViewsY, 11, 20)];
        [self.leftArrBtn setImage:[UIImage imageNamed:@"icon_inforeward_left"] forState:UIControlStateNormal];
        [self.topView addSubview:self.leftArrBtn];
    }
    /*--------topView-------*/
    
    /*--------midView-------*/
    {
        self.midView = [[UIView alloc] init];
        CGFloat y = CGRectGetMaxY(self.topView.frame);
        self.midView.frame = CGRectMake(0, y, self.width, 490);
        [self.upView addSubview:self.midView];
        
        
        self.showAllLineBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 150, 20)];
        [self.showAllLineBtn setTitle:@"显示全部折线图" forState:UIControlStateNormal];
        [self.showAllLineBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [self.showAllLineBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.showAllLineBtn setImage:[UIImage imageNamed:@"icon_inforeward_rb"] forState:UIControlStateNormal];
        [self.showAllLineBtn setImage:[UIImage imageNamed:@"icon_inforeward_rb_select"] forState:UIControlStateSelected];
        self.showAllLineBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        [self.midView addSubview:self.showAllLineBtn];
        
        self.linesView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.width, 400)];
        [self.midView addSubview:self.linesView];
        
        self.XAxisNamesView = [[UIView alloc] initWithFrame:CGRectMake(0, 450, self.width, 40)];
        [self.midView addSubview:self.XAxisNamesView];
        
        UIView *sepV = [[UIView alloc] initWithFrame:CGRectMake(0, 449, self.width, 1)];
        sepV.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
        [self.midView addSubview:sepV];
    }
    /*--------midView-------*/
    
    CGFloat y = CGRectGetMaxY(self.upView.frame);
    self.downView = [UIView new]; //下部分view
    self.downView.frame = CGRectMake(0, y, self.width, self.height - y);
    [self addSubview:self.downView];
}
- (void)reAddLinesView {
    self.linesView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 450)];
    self.linesView.backgroundColor = [UIColor lightGrayColor];
    [self.midView addSubview:self.linesView];
}
- (void)setUpView:(UIView *)upView {
    _upView = upView;
    _upView.frame = CGRectMake(0, 0, upView.width, upView.height);
}

@end
