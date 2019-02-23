//
//  OCMCheckOnWorkViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/1.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMCheckOnWorkViewController.h"
#import "OCMShiftViewController.h"
#import "OCMArrangeViewController.h"
#import "OCMAttendanceViewController.h"
#import "OCMArrangeNavigationController.h"
#import "OCMCalendarViewController.h"

@interface OCMCheckOnWorkViewController ()<UIScrollViewDelegate>
/*UI相关*/
@property (nonatomic, strong) UIView                            *nameView;                   //标题栏
@property (nonatomic, assign) NSInteger                         selectedTag;                 //选中的下标
@property (nonatomic, strong) UIButton                          *selectedBtn;                //选中的btn
@property (nonatomic, strong) UIView                            *sepView;                    //分割view
@property (nonatomic, assign) CGFloat                           w;                           //右侧视图的view的宽度
@property (nonatomic, strong) UIScrollView                      *scrollView;                 //子视图的容器view
@property (nonatomic, strong) NSMutableArray<UIButton*>         *titleBtnArr;                //标题按钮数组
/*子控制器*/
@property (nonatomic, strong) OCMShiftViewController            *shiftVC;                    //班制vc
@property (nonatomic, strong) OCMArrangeViewController          *arrangeVC;                  //排班vc
@property (nonatomic, strong) OCMAttendanceViewController       *attendanceVC;               //考勤vc
/*导航控制器*/
@property (nonatomic, strong) OCMArrangeNavigationController    *arrangeNav;                 //排班nav

@end

@implementation OCMCheckOnWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"考勤排班";
    [self addSubVC];
    [self initUI];
}
- (void)addSubVC {
//    _shiftVC      = [[OCMShiftViewController alloc] init];
    _shiftVC      = [OCMShiftViewController sharedInstance];
    
    _arrangeVC    = [[OCMArrangeViewController alloc] init];
    OCMCalendarViewController *calendarVC = [[OCMCalendarViewController alloc] init];
    _arrangeNav   = [[OCMArrangeNavigationController alloc] initWithRootViewController:calendarVC];
    
    _attendanceVC = [[OCMAttendanceViewController alloc] init];
    [self addChildViewController:_shiftVC];
    [self addChildViewController:_arrangeVC];
//    [self addChildViewController:_arrangeNav];
    
    [self addChildViewController:_attendanceVC];
}
- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.isStretch) {
        [self setRightWidth];
    } else {
        [self setLeftWidth];
    }
    [self addNotify];
}
- (void)addNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLeftWidth) name:NswipeLeftGes object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRightWidth) name:NswipeRightGes object:nil];
}
- (void)setLeftWidth {
    [self setSubViews:screenWidth - kLeftSmallWidth];//kLeftSmallWidth
    _w = screenWidth - kLeftSmallWidth;
}
- (void)setRightWidth {
    [self setSubViews:screenWidth - kLeftBigWidth];
    _w = screenWidth - kLeftBigWidth;
}
- (void)setSubViews:(CGFloat)CurrentWidth {
    if (_nameView.subviews) {  //刷新标题视图
        [_nameView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    if (self.view.subviews) {  //刷新自视图
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    _nameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CurrentWidth - 50, 44)];
    _nameView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = _nameView;
    
    //--------------------------------------------添加标题view--------------------------------------------//
    CGFloat w1       = 130;
    CGFloat h        = 44;
    CGFloat w2       = CurrentWidth - 50;
    NSArray *nameArr = @[@"排班",@"考勤",@"班制"];
    CGFloat x        = 0.;
    for (int i = 0; i < nameArr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag       = i;
        [self.titleBtnArr addObject:btn];
        x         = (1.0/nameArr.count * w2) * i + (1.0/nameArr.count * w2) * 0.5 - w1 * 0.5;
        btn.frame = CGRectMake(x, 0, w1, h);
        [self.nameView addSubview:btn];
        [btn setTitleColor:[UIColor RGBColorWithRed:255 withGreen:255 withBlue:255 withAlpha:0.6] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor RGBColorWithRed:255 withGreen:255 withBlue:255 withAlpha:1.0] forState:UIControlStateSelected];
        [btn setTitle:(NSString *)nameArr[i] forState:UIControlStateNormal];
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
    _sepView = [[UIView alloc] initWithFrame:CGRectMake((1.0/nameArr.count * w2) * _selectedTag + (1.0/nameArr.count * w2) * 0.5 - w1 * 0.5, 42, w1, 2)];
    _sepView.backgroundColor = [UIColor whiteColor];
    [_nameView addSubview:_sepView];
    
    //--------------------------------------------添加子视图view--------------------------------------------//
    CGFloat y               = 64.f;
    CGFloat scrollV_H       = screenHeight - y;
    _scrollView             = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, CurrentWidth, scrollV_H)];
    _scrollView.delegate    = self;
    _scrollView.contentSize = CGSizeMake(CurrentWidth * 3, scrollV_H);
    [_scrollView setContentOffset:CGPointMake(_selectedTag * CurrentWidth, 0)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled                  = YES;
    [self.view addSubview:_scrollView];
    
    _shiftVC.view.frame      = CGRectMake(CurrentWidth * 2, 0, CurrentWidth, scrollV_H);
    _arrangeVC.view.frame    = CGRectMake(0, 0, CurrentWidth, scrollV_H);
//    _arrangeNav.view.frame    = CGRectMake(0, 0, CurrentWidth, scrollV_H);
    _attendanceVC.view.frame = CGRectMake(CurrentWidth, 0, CurrentWidth, scrollV_H);
    [_scrollView addSubview:_shiftVC.view];
    [_scrollView addSubview:_arrangeVC.view];
//    [_scrollView addSubview:_arrangeNav.view];
    [_scrollView addSubview:_attendanceVC.view];
    
    /**
     *根据当前宽度布局
     */
    [_arrangeVC loadSubView:CurrentWidth];
    [_attendanceVC loadSubView:CurrentWidth];
    [_shiftVC loadSubView:CurrentWidth];
}
#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x >= 2* _w ) {
        self.scrollView.scrollEnabled = NO;
    } else {
        self.scrollView.scrollEnabled = YES;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint contentOffSet = _scrollView.contentOffset;
    _selectedTag          = (int)(contentOffSet.x / _w + 0.5);
    [self clickBtn:_titleBtnArr[_selectedTag]];
}
#pragma mark -- 点击事件
- (void)clickBtn:(UIButton *)sender {
    NSInteger tag         = sender.tag;
    _selectedTag          = tag;
    _selectedBtn.selected = NO;
    sender.selected       = YES;
    _selectedBtn          = sender;
    CGFloat w1            = 120;
    NSInteger count       = 3;
    [UIView animateWithDuration:0.5 animations:^{
        _sepView.frame = CGRectMake((1.0/count * (_w - 50)) * _selectedTag + (1.0/count * (_w - 50)) * 0.5 - w1 * 0.5, 42, w1, 2);
    }];
    [_scrollView setContentOffset:CGPointMake(_selectedTag * _w, 0)];
}
#pragma mark -- lazyInit
- (NSMutableArray<UIButton *> *)titleBtnArr {
    if (!_titleBtnArr) {
        _titleBtnArr = [NSMutableArray array];
    }
    return _titleBtnArr;
}
#pragma mark -- dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
