//
//  OCMRemunerationViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/27.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMRemunerationViewController.h"
#import "OCMRemunView.h"
#import "WBPopOverView.h"
#import "OCMRemunShapeLayer.h"

@interface OCMRemunerationViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)OCMRemunView *remunV;
@property (nonatomic,strong)NSMutableArray *yeasArr;
@property (nonatomic,strong)UIButton *selectedYearBtn;
@property (nonatomic,assign)NSInteger selectedCur;
@property (nonatomic,assign)BOOL isShowAllLines;
@property (nonatomic,strong)UIButton *selectedMonthBtn;
@property (nonatomic,strong)UIView *monthBtnSepV;
@property (nonatomic,assign)NSInteger selectedMonthCur;
@property (nonatomic,strong)NSMutableArray *bottomTitleArr;
@property (nonatomic,strong)OCMRemunShapeLayer *ocmLayer;

@property (nonatomic,strong)NSMutableArray *selectedBottomBtn;//记录底部选中的按钮
@property (nonatomic,strong)NSMutableDictionary *cacheDict;
//曲线数据
@property (nonatomic,strong)NSArray *dataArr;
@property (nonatomic,strong)NSMutableArray *needHiddenArr;

@property (nonatomic,strong)UIView *clearV;
@property (nonatomic,strong)UIView *pointClearV;
@end

@implementation OCMRemunerationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"量酬";
    self.view.backgroundColor = [UIColor whiteColor];
    _selectedCur = -1;
    _selectedMonthCur = 0;
    _isShowAllLines = NO;
    _selectedBottomBtn = [self.cacheDict objectForKey:@"selectedBottomBtn"];
    [self addRemunView];
    [self addNotify];
}
- (void)setDetailRemunView {
    _remunV.titleL.text = @"量化薪酬信息明细表";
    [self.view addSubview:_remunV];
    [self setYearsScrollView];
    [_remunV.leftArrBtn addTarget:self action:@selector(clickLeft) forControlEvents:UIControlEventTouchUpInside];
    [_remunV.rightArrBtn addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    [_remunV.showAllLineBtn addTarget:self action:@selector(clickShowAllLines) forControlEvents:UIControlEventTouchUpInside];
    [self addBottomBtn];
    
    [self addline];
    UIView *pointClearV = [[UIView alloc] initWithFrame:_remunV.linesView.bounds];
    _pointClearV = pointClearV;
    [_remunV.linesView addSubview:_pointClearV];
    UIView *clearV = [[UIView alloc] initWithFrame:_remunV.linesView.bounds];
    _clearV = clearV;
    [_remunV.linesView addSubview:clearV];
    
    [self addMonthsBtn];
}
- (void)addNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLeftWidth) name:NswipeLeftGes object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRightWidth) name:NswipeRightGes object:nil];
}
- (void)setLeftWidth { //向左滑
    if (_isBigLeftWidth == NO && self.view.subviews.count > 0) {
        return;
    }
    _isBigLeftWidth = NO;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"OCMRemunView")]) {
            [obj removeFromSuperview];
        }
    }];
    OCMRemunView *remunV = [[OCMRemunView alloc] initWithFrame:CGRectMake(28, 25 + 64, screenWidth - 56 - kLeftSmallWidth, self.view.height - 50 - 64)];
    _remunV = remunV;
    [self setDetailRemunView];
}
- (void)setRightWidth { //向右滑
    if (_isBigLeftWidth == YES && self.view.subviews.count > 0) {
        return;
    }
    _isBigLeftWidth = YES;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"OCMRemunView")]) {
            [obj removeFromSuperview];
        }
    }];
    OCMRemunView *remunV = [[OCMRemunView alloc] initWithFrame:CGRectMake(28, 25 + 64, screenWidth - 56 - kLeftBigWidth, self.view.height - 50 - 64)];
    _remunV = remunV;
    [self setDetailRemunView];
}
- (void)addRemunView {
//    if (self.isBigLeftWidth == nil) {
//        OCMLog(@"为空");
//        [self setRightWidth];
//        return;
//    }
    if (self.isBigLeftWidth) {
        [self setRightWidth];
    } else {
        [self setLeftWidth];
    }
}
- (void)setYearsScrollView {
    NSInteger count = self.yeasArr.count;
    _remunV.yearsScrollV.contentSize = CGSizeMake((_remunV.yearsScrollV.width / 3) * count , _remunV.yearsScrollV.height);
    _remunV.yearsScrollV.showsVerticalScrollIndicator = NO;
    _remunV.yearsScrollV.showsHorizontalScrollIndicator = NO;
    _remunV.yearsScrollV.bounces = NO;
    _remunV.yearsScrollV.delegate = self;
    CGFloat w = _remunV.yearsScrollV.width / 3;
    CGFloat h = _remunV.yearsScrollV.height;
    for (int i = 0; i < count; i++) {
        UIButton *yearBtn = [[UIButton alloc] init];
        yearBtn.tag = i;
        [_remunV.yearsScrollV addSubview:yearBtn];
        yearBtn.backgroundColor = [UIColor clearColor];
        [yearBtn setTitle:self.yeasArr[i] forState:UIControlStateNormal];
        [yearBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        yearBtn.frame = CGRectMake(i * w, 0, w, h);
        [yearBtn addTarget:self action:@selector(yearsPick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (_selectedCur >= 0 && i == _selectedCur) { //如果上次有记录选中,重新布局的时候,则选择上次选中的
            yearBtn.selected = YES;
            _selectedYearBtn = yearBtn;
            [yearBtn setTitleColor:[UIColor colorWithHexString:@"#009dec"] forState:UIControlStateNormal];
            if (_selectedCur == self.yeasArr.count - 1 || _selectedCur == self.yeasArr.count - 2) {
                [_remunV.yearsScrollV setContentOffset:CGPointMake((self.yeasArr.count - 3) * w, 0)];
            } else if (_selectedCur == 0 || _selectedCur == 1) {
                [_remunV.yearsScrollV setContentOffset:CGPointMake(0 , 0)];
            } else {
                [_remunV.yearsScrollV setContentOffset:CGPointMake((_selectedCur - 1) * w , 0)];
            }
        } else if (_selectedCur < 0) { //默认选中最大的年份
            if (i == count - 1) {
                yearBtn.selected = YES;
                _selectedYearBtn = yearBtn;
                [yearBtn setTitleColor:[UIColor colorWithHexString:@"#009dec"] forState:UIControlStateNormal];
                [_remunV.yearsScrollV setContentOffset:CGPointMake((i - 2) * w, 0)];
                self.selectedCur = i;
            }
        }
    }
}
- (void)addMonthsBtn { //月份 1月~12月
    NSArray *monthArr = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    CGFloat superViewWidth = _remunV.frame.size.width;
    CGFloat w = superViewWidth / monthArr.count;
    CGFloat h = 40;
    
    self.monthBtnSepV = [[UIView alloc] initWithFrame:CGRectMake(w * _selectedMonthCur, 36, w, 4)];
    self.monthBtnSepV.backgroundColor = [UIColor colorWithHexString:@"#009dec"];
    [_remunV.XAxisNamesView addSubview:self.monthBtnSepV];
    for (int i = 0; i < monthArr.count; i++) {
        UIButton *monthBtn = [[UIButton alloc] initWithFrame:CGRectMake(i * w, 0, w, h)];
        monthBtn.tag = i;
        [monthBtn setTitle:[NSString stringWithFormat:@"%@",monthArr[i]] forState:UIControlStateNormal];
        [monthBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [_remunV.XAxisNamesView addSubview:monthBtn];
        [monthBtn addTarget:self action:@selector(clickMonthBtn:) forControlEvents:UIControlEventTouchUpInside];
        //默认选中第_selectedMonthCur个
        if (i == _selectedMonthCur) {
            monthBtn.selected = YES;
            _selectedMonthBtn = monthBtn;
            [self clickMonthBtn:monthBtn];
        }
    }
}
- (void)addBottomBtn { //选项按钮
    CGFloat superW = CGRectGetWidth(_remunV.frame);
    CGFloat btnW = 130;
    CGFloat btnH = 36;
    CGFloat detalDis = (superW - btnW * 5 ) / 4;
    NSArray *colorArr = @[[UIColor colorWithHexString:@"#fd6060"],[UIColor colorWithHexString:@"#60d56a"],[UIColor colorWithHexString:@"#ffba5d"],[UIColor colorWithHexString:@"#7cdfff"],[UIColor colorWithHexString:@"#fb55ab"],[UIColor colorWithHexString:@"#b15edc"],[UIColor colorWithHexString:@"#2172e8"]];
    
    for (int i = 0; i < self.bottomTitleArr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        [btn setTitle:[NSString stringWithFormat:@"%@",self.bottomTitleArr[i]] forState:UIControlStateNormal];
        [btn setTitleColor:(UIColor *)colorArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setBackgroundImage:[UIImage createImageWithColor:(UIColor *)colorArr[i]] forState:UIControlStateSelected];
        btn.frame = CGRectMake((btnW + detalDis) * (i % 5), (i / 5 * 49) + 27, btnW, btnH);
        ViewBorder(btn, 2, (UIColor *)colorArr[i], 12);
        [_remunV.downView addSubview:btn];
        [btn addTarget:self action:@selector(clickBottomBtn:) forControlEvents:UIControlEventTouchUpInside];
        for (NSString *strTag in self.selectedBottomBtn) {
            if (i == [strTag intValue]) {
                btn.selected = YES;
            }
        }
    }
}
#pragma mark -- 画线
- (void)addline {
    _ocmLayer = [OCMRemunShapeLayer layer];
    _ocmLayer.pointArr = self.dataArr.mutableCopy;
    _ocmLayer.detalX = self.remunV.linesView.frame.size.width / 12;
    _ocmLayer.showedLineArr = [self.selectedBottomBtn mutableCopy];
    _ocmLayer.frame = _remunV.linesView.bounds;
    [_remunV.linesView.layer addSublayer:_ocmLayer];
    [_ocmLayer setNeedsDisplay];
}
- (void)addPopViewWithTag:(int)tag isSelectedNow:(BOOL)isSel{
    //先移除其他月份上的pop
    if (_clearV.subviews) {
        [_clearV.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[WBPopOverView class]]) {
                [obj removeFromSuperview];
            }
        }];
    }
    if (_pointClearV.subviews) {
        [_pointClearV.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                [obj removeFromSuperview];
            }
        }];
    }
    NSMutableArray *maxValueArr = [NSMutableArray array];
    NSMutableArray *minValueArr = [NSMutableArray array];
    CGFloat realValue = 0;
    for (int i = 0; i < self.dataArr.count; i++) {
        NSArray *subArr = self.dataArr[i];
        CGFloat maxTemp = [[subArr valueForKeyPath:@"@max.floatValue"] floatValue];
        [maxValueArr addObject:[NSString stringWithFormat:@"%f",maxTemp]];
        CGFloat minTemp = [[subArr valueForKeyPath:@"@min.floatValue"] floatValue];
        [minValueArr addObject:[NSString stringWithFormat:@"%f",minTemp]];
    }
    CGFloat currentMax = [[maxValueArr valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat currentMin = [[minValueArr valueForKeyPath:@"@min.floatValue"] floatValue];
    for (int i = 0; i < self.dataArr.count; i++) {
        UIBezierPath *subPath = [UIBezierPath bezierPath];
        [subPath setLineWidth:5.0];
        [subPath setLineCapStyle:kCGLineCapRound];
        [subPath setLineJoinStyle:kCGLineJoinRound];
        NSArray *subArr = self.dataArr[i];
        realValue = [subArr[self.selectedMonthCur] floatValue];
        BOOL isHidden = YES;
        for (int m = 0; m < self.selectedBottomBtn.count; m++) {
            NSInteger k = [self.selectedBottomBtn[m] integerValue]; // 要显示的第k条线
            if (k == i) {
                isHidden = NO;
                break;
            }
        }
        CGFloat w = self.remunV.linesView.frame.size.width / 12;
        CGFloat x =  w * (tag + 0.5);
        CGFloat y = (1 - ([subArr[tag] floatValue] - currentMin) / (currentMax - currentMin)) * 350 + 45;
        
        if (isHidden) {
            
        } else {
            
            CGPoint point=CGPointMake(x, y);//箭头点的位置
            UIImageView *pointImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_blue_point"]];
            pointImgV.center = point; //添加蓝点
            [_pointClearV addSubview:pointImgV];
            
            WBPopOverView *view=[[WBPopOverView alloc]initWithOrigin:point Width:w Height:40 Direction:WBArrowDirectionDown2 onView:_remunV.linesView];
            view.backView.backgroundColor = [UIColor colorWithHexString:@"#009dec"];
            view.backView.layer.cornerRadius = 5;
            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
            lable.text= [NSString stringWithFormat:@"%.1f",realValue];
            lable.textColor=[UIColor whiteColor];
            [view.backView addSubview:lable];
            [view popViewToView:_clearV];
        }
    }
}
#pragma mark -- 点击事件
- (void)yearsPick:(UIButton *)sender {
    if (sender.tag == _selectedCur) {
        OCMLog(@"选中的是同一个");
    } else {
        OCMLog(@"选中了另一个年份,需切换数据源");
    }
    
    _selectedYearBtn.selected = NO;
    [_selectedYearBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    sender.selected = YES;
    _selectedYearBtn = sender;
    
    NSInteger cur = sender.tag;
    _selectedCur = cur;
    CGFloat w = _remunV.yearsScrollV.width / 3;
    
    [_selectedYearBtn setTitleColor:[UIColor colorWithHexString:@"#009dec"] forState:UIControlStateNormal];
    if (cur == self.yeasArr.count - 1 || cur == self.yeasArr.count - 2) {
        [_remunV.yearsScrollV setContentOffset:CGPointMake((self.yeasArr.count - 3) * w, 0)];
    } else if (cur == 0 || cur == 1){
        [_remunV.yearsScrollV setContentOffset:CGPointMake(0 , 0)];
    } else {
        [_remunV.yearsScrollV setContentOffset:CGPointMake((cur - 1) * w , 0)];
    }
}
- (void)clickLeft {
    [_remunV.yearsScrollV.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.selectedCur == 0) {
            *stop = YES;
        } else {
            if (idx == self.selectedCur - 1) {
                [self yearsPick:obj];
                *stop = YES;
            }
        }
    }];
}
- (void)clickRight {
    [_remunV.yearsScrollV.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.selectedCur == _remunV.yearsScrollV.subviews.count - 1) {
            *stop = YES;
        } else {
            if (idx == self.selectedCur + 1) {
                [self yearsPick:obj];
                *stop = YES;
            }
        }
    }];
}
- (void)clickShowAllLines {
    self.remunV.showAllLineBtn.selected = !self.remunV.showAllLineBtn.selected;
    _isShowAllLines = !_isShowAllLines;
    if (_isShowAllLines) {
        OCMLog(@"显示所有的曲线");
        [_remunV.downView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = (UIButton *)obj;
            btn.selected = NO;
            [self clickBottomBtn:btn];
        }];
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",nil];
        self.selectedBottomBtn = [arr mutableCopy];
        _ocmLayer.showedLineArr = [self.selectedBottomBtn mutableCopy];
        [_ocmLayer setNeedsDisplay];
    } else {
        OCMLog(@"不显示所有的曲线");
        [_remunV.downView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = (UIButton *)obj;
            btn.selected = YES;
            [self clickBottomBtn:btn];
        }];
        
        [self.selectedBottomBtn removeAllObjects];
        _ocmLayer.showedLineArr = [self.selectedBottomBtn mutableCopy];
        [_ocmLayer setNeedsDisplay];
    }
}
- (void)clickMonthBtn:(UIButton *)sender {
    OCMLog(@"clickMonthBtn");
    _selectedMonthBtn.selected = NO;
    _selectedMonthBtn = sender;
    _selectedMonthBtn.selected = YES;
    
    NSInteger cur = sender.tag;
    CGFloat superViewWidth = _remunV.frame.size.width;
    CGFloat w = superViewWidth / 12;
    [UIView animateWithDuration:0.5 animations:^{
        [self.monthBtnSepV setFrame:CGRectMake(w * cur, 36, w, 4)];
    }];
    _selectedMonthCur = cur;
    
    //处理显示pop
    [self addPopViewWithTag:(int)sender.tag isSelectedNow:sender.selected];
}

    
- (void)clickBottomBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLock *lock = [NSLock new];
    [lock lock];
        if (sender.selected) {
            [sender.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
            
            [self.selectedBottomBtn addObject:[NSString stringWithFormat:@"%ld",sender.tag]];
            _ocmLayer.showedLineArr = [self.selectedBottomBtn mutableCopy];
            [_ocmLayer setNeedsDisplay];
            
        } else {
            [sender.titleLabel setFont:[UIFont systemFontOfSize:14]];
            
            [self.selectedBottomBtn removeObject:[NSString stringWithFormat:@"%ld",sender.tag]];
            if (self.selectedBottomBtn.count) {
                [self.selectedBottomBtn enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSString *str = obj;
                    if ([str integerValue] == sender.tag) {
                        [self.selectedBottomBtn removeObjectAtIndex:idx];
                    }
                }];
            }
            _ocmLayer.showedLineArr = [self.selectedBottomBtn mutableCopy];
            [_ocmLayer setNeedsDisplay];
        }
    [lock unlock];
    UIButton *btn = _remunV.XAxisNamesView.subviews[_selectedMonthCur + 1];
    [self clickMonthBtn:btn];
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    OCMLog(@"scrollViewDidEndDecelerating");
    [self modifyLoaction];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self modifyLoaction];
}
- (void)modifyLoaction {
    CGFloat x = _remunV.yearsScrollV.contentOffset.x;
    CGFloat btnW = _remunV.yearsScrollV.width / 3;
    NSInteger cur = x / btnW;
    CGFloat trailX = x - cur * btnW;
    if (trailX != 0) {
        if (cur == self.yeasArr.count - 1 || x == self.yeasArr.count - 2) {
            [_remunV.yearsScrollV setContentOffset:CGPointMake((self.yeasArr.count - 3) * btnW, 0)];
        } else if (cur == 0){
            [_remunV.yearsScrollV setContentOffset:CGPointMake(0 , 0)];
        } else {
            if (trailX < btnW * 0.5) {
                [_remunV.yearsScrollV setContentOffset:CGPointMake(cur * btnW , 0)];
            } else {
                [_remunV.yearsScrollV setContentOffset:CGPointMake((cur + 1) * btnW , 0)];
                cur += 1;
            }
        }
    }
    
    [_remunV.yearsScrollV.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == cur + 1) {
            _selectedYearBtn.selected = NO;
            [_selectedYearBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            obj.selected = YES;
            _selectedYearBtn = obj;
            [_selectedYearBtn setTitleColor:[UIColor colorWithHexString:@"#009dec"] forState:UIControlStateNormal];
            _selectedCur = idx;
        }
    }];
}
#pragma mark -- 数据
- (NSMutableArray *)yeasArr {
    if (!_yeasArr) {
        _yeasArr = [NSMutableArray arrayWithObjects:@"2005",@"2006",@"2007",@"2008",@"2009",@"2010",@"2011",@"2012",@"2013",@"2014",@"2015",@"2016",@"2017",nil];
    }
    return _yeasArr;
}
- (NSMutableArray *)bottomTitleArr {
    if (!_bottomTitleArr) {
        _bottomTitleArr = [NSMutableArray arrayWithObjects:@"新增有效客户数",@"4G客户数",@"新增4G套餐客户数",@"4G客户数",@"4G客户数",@"4G客户数",@"薪酬",nil];
    }
    return _bottomTitleArr;
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@[@"100.56",@"200.3",@"200.2",@"300.5",@"300.0",@"250.7",@"250.5",@"300.4",@"350.3",@"200.6",@"200.8",@"300.9"],
                     @[@"150",@"250",@"200",@"400",@"350",@"550",@"450",@"300",@"250",@"400",@"100",@"200"],
                     @[@"200",@"200",@"300",@"500",@"600",@"350",@"150",@"200",@"250",@"300",@"300",@"600"],
                     @[@"250",@"400",@"100",@"230",@"130",@"136",@"345",@"214",@"184",@"234",@"209",@"578"],
                     @[@"300",@"650",@"680",@"870",@"560",@"460",@"568",@"468",@"654",@"765",@"654",@"651"],
                     @[@"350",@"765",@"986",@"976",@"876",@"765",@"146",@"753",@"875",@"864",@"654",@"753"],
                     @[@"400",@"245",@"854",@"865",@"345",@"245",@"532",@"704",@"256",@"532",@"164",@"636"]
                     ];
    }
    return _dataArr;
}
- (NSMutableArray *)needHiddenArr {
    if (!_needHiddenArr) {
        _needHiddenArr = [NSMutableArray array];
    }
    return _needHiddenArr;
}
- (NSMutableArray *)selectedBottomBtn {
    if (!_selectedBottomBtn) {
        _selectedBottomBtn = [NSMutableArray arrayWithObjects:@"0",@"1",nil];
    }
    return _selectedBottomBtn;
}
- (NSMutableDictionary *)cacheDict {
    if (!_cacheDict) {
        _cacheDict = [NSMutableDictionary dictionary];
    }
    return _cacheDict;
}
#pragma mark -- dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
