//
//  OCMTownViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/1.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMTownViewController.h"

@interface OCMTownViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *namesView;
@property (nonatomic, assign) NSInteger selectedTag;
@property (nonatomic, strong) NSArray *namesArr; //标题名字
@property (nonatomic, strong) UIView *sepView;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, strong) NSArray *nameArr;
@property (nonatomic, strong) UIScrollView *scrollView;
@end
@implementation OCMTownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.isStretch) {
        [self setRightWidth];
    } else {
        [self setLeftWidth];
    }
    [self setNotify];
}
- (void)setNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLeftWidth) name:NswipeLeftGes object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRightWidth) name:NswipeRightGes object:nil];
}
- (void)setLeftWidth {
    OCMLog(@"left--subviews--%ld", self.view.subviews.count);
    CGFloat w = screenWidth - kLeftSmallWidth - 50;
    _w = w;
    _namesView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 44)];
    _namesView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = _namesView;
    if (_namesView.subviews) {
        [_namesView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    if (self.view.subviews) {
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    [self addFourBtn:w];
}
- (void)setRightWidth {
    OCMLog(@"right--subviews--%ld", self.view.subviews.count);
    CGFloat w = screenWidth - kLeftBigWidth - 50;
    _w = w;
    _namesView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 44)];
    _namesView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = _namesView;
    if (_namesView.subviews) {
        [_namesView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    if (self.view.subviews) {
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    [self addFourBtn:w];
}
- (void)addFourBtn:(CGFloat)w {
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        btn.frame = CGRectMake((0.25 * w) * i + (0.25 * w) * 0.5 - 25, 0, 50, 44);
        [_namesView addSubview:btn];
        [btn setTitleColor:[UIColor RGBColorWithRed:255 withGreen:255 withBlue:255 withAlpha:0.6] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor RGBColorWithRed:255 withGreen:255 withBlue:255 withAlpha:1.0] forState:UIControlStateSelected];
        [btn setTitle:(NSString *)self.nameArr[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (!_selectedTag) {
            if (i == 0) {
                btn.selected = YES;
                _selectedBtn = btn;
                _selectedTag = 0;
            }
        } else {
            if (i == _selectedTag) {
                btn.selected = YES;
                _selectedBtn = btn;
            }
        }
    }
    _sepView = [[UIView alloc] initWithFrame:CGRectMake((0.25 * w) * _selectedTag + (0.25 * w) * 0.5 - 25, 42, 50, 2)];
    _sepView.backgroundColor = [UIColor whiteColor];
    [_namesView addSubview:_sepView];
//    [self addFourViews:w]; //暂不添加scrollview
    UIImageView *imgeView = [[UIImageView alloc] initWithImage:ImageIs(@"noInfo")];
    imgeView.centerY = self.view.centerY;
    imgeView.centerX = w * 0.5;
    [self.view addSubview:imgeView];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithHexString:@"e5e5e5"];
    label.text = @"暂无相关信息";
    label.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgeView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(imgeView.mas_centerX).offset(10);
        make.size.mas_equalTo(CGSizeMake(171, 28));
    }];
}
- (void)addFourViews:(CGFloat)w {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, w, screenHeight - 64)];
    _scrollView.contentSize = CGSizeMake(w * 4, screenHeight - 64);
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
}
#pragma mark -- 点击事件
- (void)clickBtn:(UIButton *)sender {
    NSInteger tag = sender.tag;
    _selectedTag = tag;
    _selectedBtn.selected = NO;
    sender.selected = YES;
    _selectedBtn = sender;
    [UIView animateWithDuration:0.5 animations:^{
        _sepView.frame = CGRectMake((0.25 * _w) * tag + (0.25 * _w) * 0.5 - 25, 42, 50, 2);
    }];
    
}
#pragma mark -- lazyInit
- (NSArray *)nameArr {
    if (!_namesArr) {
        _nameArr = @[@"待阅",@"已阅",@"待办",@"已办"];
    }
    return _nameArr;
}
#pragma mark -- dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
