//
//  OCMRightBottomViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/19.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMRightBottomViewController.h"
#import "OCMRightBottomFirstViewController.h"
#import "OCMRightBottomSecondViewController.h"

@interface OCMRightBottomViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIButton *btn1;
@property (nonatomic,strong)UIButton *btn2;
@property (nonatomic,strong)UIView *sepLineV;
@end

@implementation OCMRightBottomViewController
#define topHeight 40
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor RGBColorWithRed:241 withGreen:241 withBlue:241 withAlpha:0.8];
    self.view.frame = CGRectMake(0, 0, kRightBottomWidth, kRightBottomHeight);
    [self addTopView];
    [self addScrollView];
    
}
- (void)addTopView {
    UIView *topView = [UIView new];
    _topView = topView;
    topView.frame = CGRectMake(0, 0, kRightBottomWidth, topHeight);
    topView.layer.backgroundColor = [UIColor colorWithHexString:@"#009dec"].CGColor;
//    topView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:topView];
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:topView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
//    CAShapeLayer *maskerLayer = [CAShapeLayer layer];
//    maskerLayer.frame = topView.frame;
//    maskerLayer.path = bezierPath.CGPath;
//    maskerLayer.backgroundColor = [UIColor blueColor].CGColor;
//    [topView.layer addSublayer:maskerLayer];
//    topView.backgroundColor = [UIColor blueColor];
//    [topView setBackgroundColor:[UIColor blueColor]];
    
    _btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kRightBottomWidth * 0.5, topHeight)];
    _btn1.tag = 400 + 1;
    [_btn1 setTitle:@"任务包" forState:UIControlStateNormal];
    [_btn1 setTitleColor:[UIColor colorWithRed:25 green:255 blue:255 alpha:0.6] forState:UIControlStateNormal];
    [_btn1 setTitleColor:[UIColor colorWithRed:25 green:255 blue:255 alpha:1.0] forState:UIControlStateSelected];
    [_btn1.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [_btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn2 = [[UIButton alloc] initWithFrame:CGRectMake(kRightBottomWidth * 0.5, 0, kRightBottomWidth * 0.5, topHeight)];
    _btn2.tag = 400 + 2;
    [_btn2 setTitle:@"附近网点" forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor colorWithRed:25 green:255 blue:255 alpha:0.6] forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor colorWithRed:25 green:255 blue:255 alpha:1.0] forState:UIControlStateSelected];
    [_btn2.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [_btn2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_btn1];
    [topView addSubview:_btn2];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeView:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [topView addGestureRecognizer:swipeUp];
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeView:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [topView addGestureRecognizer:swipeDown];
}
- (void)addSepView {
    _sepLineV = [[UIView alloc] initWithFrame:CGRectMake(0 * kRightBottomWidth * 0.5 + 25, topHeight - 2.5, kRightBottomWidth * 0.5 - 50, 2.5)];
    _sepLineV.backgroundColor = [UIColor whiteColor];
    [_topView addSubview:_sepLineV];
}
- (void)addScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topHeight, kRightBottomWidth, kRightBottomHeight - topHeight)];
    [self.view addSubview:_scrollView];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(kRightBottomWidth * 2, kRightBottomHeight - topHeight);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
//    _scrollView.backgroundColor = [UIColor RGBColorWithRed:241 withGreen:241 withBlue:241 withAlpha:0.8];
    [self addTwoTableView];
    [self addSepView];
}
- (void)addTwoTableView {
    OCMRightBottomFirstViewController *firstVC = [[OCMRightBottomFirstViewController alloc] init];
    [self addChildViewController:firstVC];
    [_scrollView addSubview:firstVC.view];
    firstVC.view.frame = CGRectMake(0, 0, kRightBottomWidth, kRightBottomHeight - topHeight);
    firstVC.view.alpha = 0.5;
    
    OCMRightBottomSecondViewController *secondVC = [[OCMRightBottomSecondViewController alloc] init];
    [self addChildViewController:secondVC];
    [_scrollView addSubview:secondVC.view];
    secondVC.view.frame = CGRectMake(kRightBottomWidth, 0, kRightBottomWidth, kRightBottomHeight - topHeight);
    secondVC.view.alpha = 0.5;
}
#pragma mark -- 点击事件
- (void)click:(UIButton *)btn {
    if (btn.tag == 401) {
        [UIView animateWithDuration:0.5 animations:^{
            _sepLineV.frame = CGRectMake(25, topHeight - 2.5, kRightBottomWidth * 0.5 - 50, 2.5);
        }];
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    if (btn.tag == 402) {
        [UIView animateWithDuration:0.5 animations:^{
            _sepLineV.frame = CGRectMake(kRightBottomWidth * 0.5 + 25, topHeight - 2.5, kRightBottomWidth * 0.5 - 50, 2.5);
        }];
        [_scrollView setContentOffset:CGPointMake(kRightBottomWidth, 0) animated:YES];
    }
}
#pragma mark -- scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    NSInteger cur = x / kRightBottomWidth;
    [UIView animateWithDuration:0.5 animations:^{
        _sepLineV.frame = CGRectMake(kRightBottomWidth * 0.5 * cur + 25, topHeight - 2.5, kRightBottomWidth * 0.5 - 50, 2.5);
    }];
    
}
#pragma mark -- UISwipeGesture
- (void)swipeView:(UISwipeGestureRecognizer *)swipeGes {
    if (swipeGes.direction == UISwipeGestureRecognizerDirectionUp) {
        BOOL isShow = YES;
        self.hiddenOrShow(isShow);
    }
    if (swipeGes.direction == UISwipeGestureRecognizerDirectionDown) {
        BOOL isShow = NO;
        self.hiddenOrShow(isShow);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
