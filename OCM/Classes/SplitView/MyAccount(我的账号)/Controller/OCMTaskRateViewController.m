//
//  OCMTaskRateViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/27.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMTaskRateViewController.h"
#import "OCMTeamsRateViewController.h"
#import "OCMPersonalRateViewController.h"

@interface OCMTaskRateViewController ()
@property (nonatomic,strong)OCMTeamsRateViewController *teamVC;
@property (nonatomic,strong)OCMPersonalRateViewController *personalVC;
@property (nonatomic,strong)UIView *nameView;
@property (nonatomic,strong)UIView *slideView;
@property (nonatomic,strong)UIButton *teamsBtn;
@property (nonatomic,strong)UIButton *personalBtn;
@property (nonatomic,assign)BOOL isSelectFirst;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIView *teamView;
@property (nonatomic,strong)UIView *personalView;
@end

@implementation OCMTaskRateViewController
static CGFloat distance1 = 450;
static CGFloat distance2 = 550;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self addSubView];
    [self addNotify];
}
- (void)addChildVC:(CGFloat)width {
    if (self.childViewControllers) {
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromParentViewController];
        }];
    }
    self.teamVC = [[OCMTeamsRateViewController alloc] init];
    self.teamVC.showWidth = width;
    self.personalVC = [[OCMPersonalRateViewController alloc] init];
    self.personalVC.showWidth = width;
    [self addChildViewController:self.teamVC];
    [self addChildViewController:self.personalVC];
}
- (void)addSubView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 44)];
    self.nameView = view;
    self.navigationItem.titleView = view;
    _isSelectFirst = YES;
    
    CGRect rect = CGRectMake(0, 64, 2 * self.view.width, self.view.height);
    self.bgView = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:self.bgView];
    
//    if (_isBigLeftWidth == nil) {
//        OCMLog(@"为空");
//        [self setRightWidth];
//        return;
//    }
    if (_isBigLeftWidth) {
        [self setRightWidth];
    } else {
        [self setLeftWidth];
    }
}
- (void)addNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLeftWidth) name:NswipeLeftGes object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRightWidth) name:NswipeRightGes object:nil];
}
- (void)setRightWidth { // 左侧很窄的时候
    _isBigLeftWidth = YES;
    [self addTitleView:distance1];
    CGFloat width = screenWidth - kLeftBigWidth;
    [self addTwoViews:width];
}
- (void)setLeftWidth { // 左侧比较宽的时候
    _isBigLeftWidth = NO;
    [self addTitleView:distance2];
    CGFloat width = screenWidth - kLeftSmallWidth;
    [self addTwoViews:width];
}
- (void)addTwoViews:(CGFloat)width {
    [self addChildVC:(CGFloat)width];
    if (self.bgView.subviews) {
        [self.bgView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    self.teamView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, self.view.height - 64)];
//    OCMLog(@"传的width-->%f", width);
    [self.bgView addSubview:self.teamView];
    [self.teamView addSubview:self.teamVC.view];
    self.teamVC.view.frame = self.teamView.bounds;
    
    self.personalView = [[UIView alloc] initWithFrame:CGRectMake(width, 0, width, self.view.height - 64)];
    [self.bgView addSubview:self.personalView];
    [self.personalView addSubview:self.personalVC.view];
    self.personalVC.view.frame = self.personalView.bounds;
    
    if (_isSelectFirst) {
        self.bgView.frame = CGRectMake(0, 64, self.teamView.width * 2, self.view.height - 64);
    } else {
        self.bgView.frame = CGRectMake(-self.teamView.width, 64, self.teamView.width * 2, self.view.height - 64);
    }
}
- (void)addTitleView:(CGFloat)xDistance {
    if (self.nameView.subviews) {
        [self.nameView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    UIColor *normalColor = [UIColor RGBColorWithRed:255 withGreen:255 withBlue:255 withAlpha:0.6];
    self.teamsBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 0, 100, 44)];
    [self.teamsBtn setTitle:@"班组进度" forState:UIControlStateNormal];
    [self.teamsBtn setTitleColor:normalColor forState:UIControlStateNormal];
    [self.teamsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.teamsBtn addTarget:self action:@selector(clickTeamsBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.nameView addSubview:self.teamsBtn];
    self.teamsBtn.selected = YES;//默认选中-->班组
    
    self.personalBtn = [[UIButton alloc] initWithFrame:CGRectMake(xDistance, 0, 100, 44)];
    [self.personalBtn setTitle:@"个人进度" forState:UIControlStateNormal];
    [self.personalBtn setTitleColor:normalColor forState:UIControlStateNormal];
    [self.personalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.personalBtn addTarget:self action:@selector(clickPersonalBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.nameView addSubview:self.personalBtn];
    
    //增加滑动条
    self.slideView = [[UIView alloc] init];
    self.slideView.backgroundColor = [UIColor whiteColor];
    [self.nameView addSubview:self.slideView];
    
    __weak typeof(self) weakSelf = self;
    if (_isSelectFirst) {
        [self.slideView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.teamsBtn.mas_bottom).offset(0);
            make.height.mas_equalTo(2);
            make.left.mas_equalTo(weakSelf.teamsBtn.mas_left);
            make.width.mas_equalTo(100);
        }];
    } else {
        [self.slideView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.teamsBtn.mas_bottom).offset(0);
            make.height.mas_equalTo(2);
            make.left.mas_equalTo(weakSelf.personalBtn.mas_left);
            make.width.mas_equalTo(100);
        }];
    }
    
}
#pragma mark -- 点击事件
- (void)clickTeamsBtn:(UIButton *)sender {
//    OCMLog(@"clickTeamsBtn");
    _isSelectFirst = YES;
    self.personalBtn.selected = NO;
    self.teamsBtn.selected = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.slideView.frame = CGRectMake(100, 42, 100, 2);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.frame = CGRectMake(0, 64, self.teamView.width * 2, self.view.height - 64);
    }];
}
- (void)clickPersonalBtn:(UIButton *)sender {
//    OCMLog(@"clickPersonalBtn");
    _isSelectFirst = NO;
    self.personalBtn.selected = YES;
    self.teamsBtn.selected = NO;
    if (_isBigLeftWidth) {
        [UIView animateWithDuration:0.5 animations:^{
            self.slideView.frame = CGRectMake(distance1, 42, 100, 2);
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.slideView.frame = CGRectMake(distance2, 42, 100, 2);
        }];
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.frame = CGRectMake(-self.teamView.width, 64, self.teamView.width * 2, self.view.height - 64);
    }];
}
#pragma mark -- dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
