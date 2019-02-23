//
//  OCMTeamsRateViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/1/9.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMTeamsRateViewController.h"
#import "OCMTeamView.h"
#import "OCMTaskTableViewController.h"
#import "OCMAreaTableViewController.h"
#import "WBPopOverView.h"
#import "CFDynamicLabel.h"

@interface OCMTeamsRateViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)OCMTeamView *teamV;
//data
@property (nonatomic,strong)NSMutableArray<NSMutableArray *> *teamsCompletedArr; // 班组完成的任务
@property (nonatomic,strong)NSMutableArray<NSMutableArray *> *teamsPlanArr; // 班组的计划任务
@property (nonatomic,strong)NSMutableArray *taskNameArr;//任务名字
@property (nonatomic,strong)NSMutableArray *teamNameArr;//班组名字

@property (nonatomic,strong)UIScrollView *scro;
@property (nonatomic,strong)UIView *sepV;
@property (nonatomic,assign)NSInteger selectedTeam;//选中的组
@property (nonatomic,assign)CGFloat curX1;
@property (nonatomic,assign)CGFloat curX2;
//
@property (nonatomic,strong)NSArray *areaArr;
@property (nonatomic,strong)NSArray *taskArr;
@property (nonatomic,copy)NSString *lastAreaStr;//记录上一个选中的区域
@property (nonatomic,copy)NSString *lastTaskStr;//记录上一个选中的任务
@property (nonatomic,assign)BOOL isChangArea;
@property (nonatomic,assign)BOOL isChangeTask;

@property (nonatomic,strong)WBPopOverView *areaPop;
@property (nonatomic,strong)WBPopOverView *taskPop;
@end

@implementation OCMTeamsRateViewController

static NSString *teamIndex = @"teamIndex";
static NSString *curkey1 = @"curkey1";
static NSString *curkey2 = @"curkey2";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getSandBoxData];
    [self setData];
    [self addView];
}
- (void)getSandBoxData {
    self.selectedTeam = [YDConfigurationHelper getIntegerValueForConfigurationKey:teamIndex];
    if (self.selectedTeam == 0) {
        self.selectedTeam = 1;
        [YDConfigurationHelper setIntegerForConfigurationKey:teamIndex withValue:self.selectedTeam];
    }
    self.curX1 = [YDConfigurationHelper getFloatForConfigurationKey:curkey1];
//    OCMLog(@"cur1--%f", self.curX1);
    self.curX2 = [YDConfigurationHelper getFloatForConfigurationKey:curkey2];
}
- (void)addView {
    if (self.teamV.subviews) {
        [self.teamV.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    CGRect rect = CGRectMake(28, 25, _showWidth - 56, self.view.height - 50 - 64);
    NSArray *arr = (NSArray *)self.teamsPlanArr.firstObject;
    CGFloat w = (86 + 36) * arr.count - 86 + 25 + 25 + 5;// 左右各多25间距
    CGFloat h = 500;
    
    self.teamV= [[OCMTeamView alloc] initWithFrame:rect planData:self.teamsPlanArr completedData:self.teamsCompletedArr teamName:self.teamNameArr taskName:self.taskNameArr sepWidth:w selectedData:self.selectedTeam curX1:_curX1];
    self.teamV.scrollView1.contentSize = CGSizeMake(w,h);
    self.teamV.areaLabel.text = @"所有片区";
    self.teamV.taskLabel.text = @"所有任务很长很长很长很长很长";
    [self.view addSubview:self.teamV];
    self.teamV.scrollView1.delegate = self;
    
    UIScrollView *scro = [[UIScrollView alloc] initWithFrame:CGRectMake(38, 530, _showWidth-56-38-38 , 48)];
    CGFloat width = 25 + (self.teamNameArr.count - 1) * (86 + 36) + 18 + 50;
    scro.contentSize = CGSizeMake(width, 48);
    scro.delegate = self;
    scro.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [scro setContentOffset:CGPointMake(_curX2, 0)];
    _scro = scro;
    [_scro setShowsHorizontalScrollIndicator:NO];
    [self.teamV addSubview:_scro];
    
    [self.teamV.areaBtn addTarget:self action:@selector(clickAreBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.teamV.taskBtn addTarget:self action:@selector(clickTaskBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.teamV.leftBtn addTarget:self action:@selector(clickLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.teamV.rightBtn addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    [self addTeamName];//添加班组名字
}
- (void)addTeamName {
    [YDConfigurationHelper getIntegerValueForConfigurationKey:teamIndex];
    for (int i = 0; i < self.teamNameArr.count; i++) {
        CGFloat x =  25 + i * (86 + 36) + 18;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, 100, 50)];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickTeamBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.centerX = x;
        [btn setTitle:[NSString stringWithFormat:@"%@",self.teamNameArr[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [self.scro addSubview:btn];
        if (i == self.selectedTeam -1) { // 添加选中指示条
            CGFloat x1 =  25 + i * (86 + 36) + 18;
            self.sepV = [[UIView alloc] initWithFrame:CGRectMake(x1, 46, 100, 4)];
            _sepV.centerX = x;
            self.sepV.backgroundColor = [UIColor colorWithHexString:@"#009dec"];
            [self.scro addSubview:self.sepV];
        }
    }
}
#pragma mark -- 点击事件
- (void)clickLeft {
    _curX1 = [YDConfigurationHelper getFloatForConfigurationKey:curkey1];
    CGFloat w1 = 25 + (self.teamNameArr.count - 1) * (86 + 36) + 18 + 50;
    CGFloat w2 = _showWidth-56-38-38;
    if (_curX1 > 0 && _curX1 < w1 - w2) {
        
    }
}
- (void)clickRight {
    
}
- (void)clickAreBtn {
    __weak typeof(self) weakSelf = self;
    CGFloat x = self.teamV.areaBtn.frame.origin.x + 80;
    CGFloat y = self.teamV.areaBtn.frame.origin.y + 30+10;
    CGPoint point = CGPointMake(x, y);
    self.areaPop = [[WBPopOverView alloc] initWithOrigin:point Width:100 Height:120 Direction:WBArrowDirectionUp3 onView:self.teamV];
    self.areaPop.canHidden = YES;
    self.areaPop.backView.backgroundColor = [UIColor lightGrayColor];
    self.areaPop.backView.layer.cornerRadius = 5;
    [self.areaPop popViewToView:self.teamV];
    OCMAreaTableViewController *areaTableView = [[OCMAreaTableViewController alloc] init];
    [self addChildViewController:areaTableView];
    areaTableView.areaArr = self.areaArr;
    areaTableView.view.frame = CGRectMake(0, 0, 100, 120);
    areaTableView.view.layer.cornerRadius = 5;
    ViewBorder(areaTableView.view, 1, [UIColor colorWithHexString:@"#cccccc"], 5);
    [self.areaPop.backView addSubview:areaTableView.view];
    areaTableView.areaBlock = ^(NSString *area) {
        __strong typeof(self) theSelf = weakSelf;
//        theSelf.curArea = area;
//        if ([theSelf.lastAreaStr isEqualToString:area]) {
//            theSelf.isChangArea = NO;
//        } else {
//            theSelf.isChangArea = YES;
//            [theSelf setData];
//            [theSelf addIndictorV];
//        }
    };
}
- (void)clickTaskBtn {
    __weak typeof(self) weakSelf = self;
    CGFloat x = self.teamV.taskBtn.frame.origin.x + 80;
    CGFloat y = self.teamV.taskBtn.frame.origin.y + 30+10;
    CGPoint point = CGPointMake(x, y);
    self.taskPop = [[WBPopOverView alloc] initWithOrigin:point Width:100 Height:120 Direction:WBArrowDirectionUp3 onView:self.teamV];
    self.taskPop.canHidden = YES;
    self.taskPop.backView.backgroundColor = [UIColor lightGrayColor];
    self.taskPop.backView.layer.cornerRadius = 5;
    [self.taskPop popViewToView:self.teamV];
    OCMAreaTableViewController *areaTableView = [[OCMAreaTableViewController alloc] init];
    [self addChildViewController:areaTableView];
    areaTableView.areaArr = self.taskArr;
    areaTableView.view.frame = CGRectMake(0, 0, 100, 120);
    areaTableView.view.layer.cornerRadius = 5;
    ViewBorder(areaTableView.view, 1, [UIColor colorWithHexString:@"#cccccc"], 5);
    [self.taskPop.backView addSubview:areaTableView.view];
    areaTableView.areaBlock = ^(NSString *area) {
        __strong typeof(self) theSelf = weakSelf;
        //        theSelf.curArea = area;
        //        if ([theSelf.lastAreaStr isEqualToString:area]) {
        //            theSelf.isChangArea = NO;
        //        } else {
        //            theSelf.isChangArea = YES;
        //            [theSelf setData];
        //            [theSelf addIndictorV];
        //        }
    };
    
}
- (void)clickTeamBtn:(UIButton *)sender {
    self.selectedTeam = sender.tag + 1;//修改数据源
    [YDConfigurationHelper setIntegerForConfigurationKey:teamIndex withValue:self.selectedTeam];
    [self addView];
    [self modifyContentOffset:self.scro];//修改位置
}
#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self modifyContentOffset:scrollView];//修改位置
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self modifyContentOffset:scrollView];//修改位置
}
- (void)modifyContentOffset:(UIScrollView *)scrollView {
    CGFloat currentX = scrollView.contentOffset.x;
    NSInteger cur = currentX / 122;
    CGFloat trailX = currentX - cur * 122;
    if (trailX > 38) {
        currentX = (cur + 1) * 122;
    } else {
        currentX = cur * 122;
    }
    if (scrollView == self.teamV.scrollView1) {
        _curX1 = currentX;
        [YDConfigurationHelper setFloatForConfigureationKey:curkey1 withValue:_curX1];
    } else {
        _curX2 = currentX;
        [YDConfigurationHelper setFloatForConfigureationKey:curkey2 withValue:_curX2];
    }
    [UIView animateWithDuration:0.5 animations:^{
        [scrollView setContentOffset:CGPointMake(currentX, 0)];
    }];
}
#pragma mark --  数据
- (void)setData {
    _areaArr = @[@"南城区",@"东城区",@"莞城区",@"万江区",@"我是一个很长名字所有片区"];
    _taskArr = @[@"任务1",@"任务2",@"任务3",@"任务4",@"我是一个很长名字的任务"];
}
- (NSMutableArray<NSMutableArray *> *)teamsCompletedArr { //班组完成的任务
    if (!_teamsCompletedArr) {
        NSArray *tempArr = @[@[@"40",@"25",@"84",@"44",@"58",@"57",@"68",@"90"],
                             @[@"67",@"67",@"87",@"87",@"45",@"76",@"56",@"89"],
                             @[@"34",@"32",@"98",@"25",@"13",@"46",@"67",@"15"],
                             @[@"96",@"66",@"54",@"76",@"24",@"35",@"14",@"46"],
                             @[@"80",@"45",@"87",@"55",@"35",@"11",@"24",@"25"],
                             @[@"14",@"13",@"44",@"23",@"46",@"35",@"35",@"89"],
                             @[@"57",@"98",@"66",@"34",@"57",@"24",@"46",@"68"],
                             @[@"35",@"53",@"21",@"68",@"57",@"65",@"66",@"78"],
                             @[@"87",@"44",@"33",@"24",@"68",@"33",@"78",@"66"],
                             @[@"45",@"86",@"56",@"64",@"78",@"13",@"89",@"56"],
                             @[@"76",@"27",@"76",@"45",@"89",@"24",@"56",@"45"],
                             @[@"33",@"65",@"67",@"76",@"43",@"45",@"78",@"67"]];
        _teamsCompletedArr = [NSMutableArray arrayWithArray:tempArr];
    }
    return _teamsCompletedArr;
}
- (NSMutableArray<NSMutableArray *> *)teamsPlanArr { //班组计划的任务
    if (!_teamsPlanArr) {
        NSArray *tempArr = @[@[@"100",@"200",@"100",@"300",@"120",@"130",@"140",@"110"],
                             @[@"103",@"147",@"120",@"130",@"230",@"190",@"130",@"130"],
                             @[@"120",@"167",@"140",@"130",@"170",@"150",@"120",@"200"],
                             @[@"140",@"256",@"167",@"230",@"120",@"178",@"130",@"140"],
                             @[@"345",@"245",@"178",@"250",@"134",@"167",@"126",@"165"],
                             @[@"123",@"234",@"189",@"334",@"134",@"156",@"178",@"176"],
                             @[@"134",@"223",@"123",@"323",@"145",@"145",@"189",@"198"],
                             @[@"145",@"289",@"134",@"389",@"156",@"134",@"178",@"190"],
                             @[@"156",@"278",@"145",@"378",@"167",@"123",@"167",@"189"],
                             @[@"167",@"267",@"156",@"367",@"178",@"189",@"165",@"178"],
                             @[@"178",@"256",@"167",@"367",@"189",@"178",@"154",@"167"],
                             @[@"189",@"245",@"178",@"356",@"123",@"167",@"143",@"156"],];
        _teamsPlanArr = [NSMutableArray arrayWithArray:tempArr];
    }
    return _teamsPlanArr;
}
- (NSMutableArray *)taskNameArr {
    if (!_taskNameArr) {
        NSArray *temp = @[@"日常走访",@"常规走访",@"测试下发任务",@"测试下发任务2",@"110走访",@"6月宣传覆盖",@"8月宣传覆盖",@"10月宣传覆盖"];
        _taskNameArr = [NSMutableArray arrayWithArray:temp];
    }
    return _taskNameArr;
}
- (NSMutableArray *)teamNameArr {
    if (!_teamNameArr) {
        NSArray *temp = @[@"茶山组",@"山口组",@"云符组",@"武当组",@"明教组",@"少林组",@"鸿兴组",@"宣传组",@"日常组",@"娱乐组",@"食欲组",@"控件组"];
        _teamNameArr = [NSMutableArray arrayWithArray:temp];
    }
    return _teamNameArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
