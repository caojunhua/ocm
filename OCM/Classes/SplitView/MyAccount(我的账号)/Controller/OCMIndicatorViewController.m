//
//  OCMIndicatorViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/27.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMIndicatorViewController.h"
#import "OCMIndicatorView.h"
#import "CFDynamicLabel.h"
#import "WBPopOverView.h"
#import "OCMTaskTableViewController.h"
#import "OCMAreaTableViewController.h"

@interface OCMIndicatorViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)OCMIndicatorView *indicatorView;
@property (nonatomic,strong)NSArray<NSArray *> *dataArrs;
@property (nonatomic,strong)NSArray *teamsNameArr;
@property (nonatomic,strong)NSDictionary *myPerformance;
@property (nonatomic,copy)NSString *curArea; //当前选中的区域
@property (nonatomic,copy)NSString *curTask; //当前选中的任务
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

@implementation OCMIndicatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"指标";
    self.view.backgroundColor = [UIColor whiteColor];
    self.isChangArea = YES;
    self.isChangeTask = YES;
    [self setData];
    [self addIndictorV];
    [self addNotify];
}
- (void)addIndictorV {
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
- (void)setLeftWidth {
    if ((_isBigLeftWidth == NO && self.view.subviews.count > 0) && !self.isChangArea && !self.isChangeTask) {
        return;
    }
    _isBigLeftWidth = NO;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"OCMIndicatorView")]) {
            [obj removeFromSuperview];
            OCMLog(@"左--");
        }
    }];
    CGRect rect = CGRectMake(28, 25 + 64, screenWidth - 56 - kLeftSmallWidth, self.view.height - 50 - 64);
    _indicatorView = [[OCMIndicatorView alloc] initWithData:self.dataArrs frame:rect teamsViewNameArr:self.teamsNameArr myData:self.myPerformance];
    [self addIndicatorView];
}
- (void)setRightWidth {
    if ((_isBigLeftWidth == YES && self.view.subviews.count > 0) && !self.isChangArea && !self.isChangeTask) {
        return;
    }
    _isBigLeftWidth = YES;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"OCMIndicatorView")]) {
            [obj removeFromSuperview];
            OCMLog(@"右--");
        }
    }];
    CGRect rect = CGRectMake(28, 25 + 64, screenWidth - 56 - kLeftBigWidth, self.view.height - 50 - 64);
    _indicatorView = [[OCMIndicatorView alloc] initWithData:self.dataArrs frame:rect teamsViewNameArr:self.teamsNameArr myData:self.myPerformance];
    [self addIndicatorView];
}
- (void)addIndicatorView {
    _indicatorView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _indicatorView.barScrollV.delegate = self;
    [_indicatorView.leftBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    [_indicatorView.rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    [_indicatorView.btnArea addTarget:self action:@selector(clickAllArea:) forControlEvents:UIControlEventTouchUpInside];
    [_indicatorView.btnTask addTarget:self action:@selector(clickAllTask:) forControlEvents:UIControlEventTouchUpInside];
    self.indicatorView.areaLabel.text = _lastAreaStr;
    self.indicatorView.taskLabel.text = _lastTaskStr;
    [self.view addSubview:_indicatorView];
}
#pragma mark --点击事件
- (void)clickLeftBtn {
    CGFloat x = self.indicatorView.barScrollV.contentOffset.x;
    NSInteger cur = x / 115;
    if (cur == 0) {
        
    } else {
        cur -= 1;
        [self.indicatorView.barScrollV setContentOffset:CGPointMake(cur * 115, 0) animated:YES];
    }
}
- (void)clickRightBtn {
    CGFloat x = self.indicatorView.barScrollV.contentOffset.x;
    NSInteger cur = x / 115;
    if (cur == self.teamsNameArr.count - 6) {
        
    } else {
        cur += 1;
        [self.indicatorView.barScrollV setContentOffset:CGPointMake(cur * 115, 0) animated:YES];
    }
}
- (void)clickAllArea:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    CGFloat x = self.indicatorView.btnArea.frame.origin.x + 80;
    CGFloat y = self.indicatorView.btnArea.frame.origin.y + 30+10;
    CGPoint point = CGPointMake(x, y);
    self.areaPop = [[WBPopOverView alloc] initWithOrigin:point Width:100 Height:120 Direction:WBArrowDirectionUp3 onView:self.indicatorView.midV];
    self.areaPop.canHidden = YES;
    self.areaPop.backView.backgroundColor = [UIColor lightGrayColor];
    self.areaPop.backView.layer.cornerRadius = 5;
    [self.areaPop popViewToView:self.indicatorView.midV];
    OCMAreaTableViewController *areaTableView = [[OCMAreaTableViewController alloc] init];
    [self addChildViewController:areaTableView];
    areaTableView.areaArr = self.areaArr;
    areaTableView.view.frame = CGRectMake(0, 0, 100, 120);
    areaTableView.view.layer.cornerRadius = 5;
    ViewBorder(areaTableView.view, 1, [UIColor colorWithHexString:@"#cccccc"], 5);
    [self.areaPop.backView addSubview:areaTableView.view];
    areaTableView.areaBlock = ^(NSString *area) {
        __strong typeof(self) theSelf = weakSelf;
        theSelf.curArea = area;
        if ([theSelf.lastAreaStr isEqualToString:area]) {
            theSelf.isChangArea = NO;
        } else {
            theSelf.isChangArea = YES;
            [theSelf setData];
            [theSelf addIndictorV];
        }
    };
}
- (void)clickAllTask:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    CGFloat x = self.indicatorView.btnTask.frame.origin.x + 80;
    CGFloat y = self.indicatorView.btnTask.frame.origin.y + 30+10;
    CGPoint point = CGPointMake(x, y);
    self.taskPop = [[WBPopOverView alloc] initWithOrigin:point Width:100 Height:120 Direction:WBArrowDirectionUp3 onView:self.indicatorView.midV];
    self.taskPop.canHidden = YES;
    self.taskPop.backView.backgroundColor = [UIColor lightGrayColor];
    self.taskPop.backView.layer.cornerRadius = 5;
    [self.taskPop popViewToView:self.indicatorView.midV];
    OCMTaskTableViewController *taskTableView = [[OCMTaskTableViewController alloc] init];
    [self addChildViewController:taskTableView];
    taskTableView.dataArr = self.taskArr;
    taskTableView.view.frame = CGRectMake(0, 0, 100, 120);
    taskTableView.view.layer.cornerRadius = 5;
    ViewBorder(taskTableView.view, 1, [UIColor colorWithHexString:@"#cccccc"], 5);
    [self.taskPop.backView addSubview:taskTableView.view];
    taskTableView.taskBlock = ^(NSString *task) {
        __strong typeof(self) theSelf = weakSelf;
        theSelf.curTask = task;
        if ([theSelf.lastTaskStr isEqualToString:task]) {
            theSelf.isChangeTask = NO;
        } else {
            theSelf.isChangeTask = YES;
            [theSelf setData];
            [theSelf addIndictorV];
        }
    };
}
#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self modifyScrollPosition];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    OCMLog(@"_indicatorView-scrollViewDidEndDecelerating");
    [self modifyScrollPosition];
}
- (void)modifyScrollPosition {
    CGFloat x = self.indicatorView.barScrollV.contentOffset.x;
    NSInteger cur = x / 115;
    CGFloat trailX = x - cur * 115;
    if (cur >= self.teamsNameArr.count - 6 && self.isBigLeftWidth) {
        cur = self.teamsNameArr.count - 6;
        [self.indicatorView.barScrollV setContentOffset:CGPointMake(cur * 115, 0) animated:YES];
        return;
    }
    if (cur >= self.teamsNameArr.count -7 && !self.isBigLeftWidth) {
        cur = self.teamsNameArr.count - 7;
        [self.indicatorView.barScrollV setContentOffset:CGPointMake(cur * 115, 0) animated:YES];
        return;
    }
    if (trailX > 115/2) {
        [self.indicatorView.barScrollV setContentOffset:CGPointMake((cur + 1) * 115, 0) animated:YES];
    } else {
        [self.indicatorView.barScrollV setContentOffset:CGPointMake(cur * 115, 0) animated:YES];
    }
}
- (void)setData {
    _areaArr = @[@"南城区",@"东城区",@"莞城区",@"万江区",@"我是一个很长名字所有片区"];
    _taskArr = @[@"任务1",@"任务2",@"任务3",@"任务4",@"我是一个很长名字的任务"];
    _dataArrs = @[@[@"100",@"100",@"100",@"20",@"256",@"359",@"386",@"950",@"840",@"256",@"359",@"386",@"950",@"840",@"256"],
                 @[@"149",@"176",@"150",@"460",@"247",@"349",@"376",@"750",@"460",@"247",@"349",@"376",@"750",@"460",@"247"],
                 @[@"173",@"158",@"196",@"486",@"968",@"573",@"958",@"396",@"486",@"968",@"573",@"958",@"396",@"486",@"1000"],
                 ];
    if (_curTask == nil) {
        _lastTaskStr = _taskArr[0]; //默认选中第一个
    } else {
        NSInteger index = [_taskArr indexOfObject:_curTask];
        _lastTaskStr = _taskArr[index];
        switch (index) {
            case 0:
                _dataArrs = @[@[@"100",@"100",@"100",@"20",@"256",@"359",@"386",@"950",@"840",@"256",@"359",@"386",@"950",@"840",@"256"],
                              @[@"149",@"176",@"150",@"460",@"247",@"349",@"376",@"750",@"460",@"247",@"349",@"376",@"750",@"460",@"247"],
                              @[@"173",@"158",@"196",@"486",@"968",@"573",@"958",@"396",@"486",@"968",@"573",@"958",@"396",@"486",@"1000"],
                              ];
                break;
            case 1:
                _dataArrs = @[@[@"200",@"200",@"200",@"20",@"256",@"359",@"386",@"950",@"840",@"256",@"359",@"386",@"950",@"840",@"256"],
                              @[@"249",@"276",@"250",@"460",@"247",@"349",@"376",@"750",@"460",@"247",@"349",@"376",@"750",@"460",@"247"],
                              @[@"273",@"258",@"296",@"486",@"968",@"573",@"958",@"396",@"486",@"968",@"573",@"958",@"396",@"486",@"1000"],
                              ];
                break;
            case 2:
                _dataArrs = @[@[@"300",@"300",@"300",@"20",@"256",@"359",@"386",@"950",@"840",@"256",@"359",@"386",@"950",@"840",@"256"],
                              @[@"349",@"376",@"350",@"460",@"247",@"349",@"376",@"750",@"460",@"247",@"349",@"376",@"750",@"460",@"247"],
                              @[@"373",@"358",@"396",@"486",@"968",@"573",@"958",@"396",@"486",@"968",@"573",@"958",@"396",@"486",@"1000"],
                              ];
                break;
            case 3:
                _dataArrs = @[@[@"400",@"400",@"400",@"20",@"256",@"359",@"386",@"950",@"840",@"256",@"359",@"386",@"950",@"840",@"256"],
                              @[@"449",@"476",@"450",@"460",@"247",@"349",@"376",@"750",@"460",@"247",@"349",@"376",@"750",@"460",@"247"],
                              @[@"473",@"458",@"496",@"486",@"968",@"573",@"958",@"396",@"486",@"968",@"573",@"958",@"396",@"486",@"1000"],
                              ];
                break;
            case 4:
                _dataArrs = @[@[@"500",@"500",@"500",@"20",@"256",@"359",@"386",@"950",@"840",@"256",@"359",@"386",@"950",@"840",@"256"],
                              @[@"549",@"576",@"550",@"460",@"247",@"349",@"376",@"750",@"460",@"247",@"349",@"376",@"750",@"460",@"247"],
                              @[@"573",@"558",@"596",@"486",@"968",@"573",@"958",@"396",@"486",@"968",@"573",@"958",@"396",@"486",@"1000"],
                              ];
                break;
            default:
                break;
        }
        
    }
    if (_curArea == nil) {
        _lastAreaStr = _areaArr[0]; //默认选择第一个

    } else {
        NSInteger index = [_areaArr indexOfObject:_curArea];
        _lastAreaStr = _areaArr[index];
        switch (index) {
            case 0:
            _dataArrs = @[@[@"100",@"100",@"100",@"20",@"256",@"359",@"386",@"950",@"840",@"256",@"359",@"386",@"950",@"840",@"256"],
                          @[@"149",@"176",@"150",@"460",@"247",@"349",@"376",@"750",@"460",@"247",@"349",@"376",@"750",@"460",@"247"],
                          @[@"173",@"158",@"196",@"486",@"968",@"573",@"958",@"396",@"486",@"968",@"573",@"958",@"396",@"486",@"1000"],
                          ];
            break;
            case 1:
            _dataArrs = @[@[@"200",@"200",@"200",@"20",@"256",@"359",@"386",@"950",@"840",@"256",@"359",@"386",@"950",@"840",@"256"],
                          @[@"249",@"276",@"250",@"460",@"247",@"349",@"376",@"750",@"460",@"247",@"349",@"376",@"750",@"460",@"247"],
                          @[@"273",@"258",@"296",@"486",@"968",@"573",@"958",@"396",@"486",@"968",@"573",@"958",@"396",@"486",@"1000"],
                          ];
            break;
            case 2:
            _dataArrs = @[@[@"300",@"300",@"300",@"20",@"256",@"359",@"386",@"950",@"840",@"256",@"359",@"386",@"950",@"840",@"256"],
                          @[@"349",@"376",@"350",@"460",@"247",@"349",@"376",@"750",@"460",@"247",@"349",@"376",@"750",@"460",@"247"],
                          @[@"373",@"358",@"396",@"486",@"968",@"573",@"958",@"396",@"486",@"968",@"573",@"958",@"396",@"486",@"1000"],
                          ];
            break;
            case 3:
            _dataArrs = @[@[@"400",@"400",@"400",@"20",@"256",@"359",@"386",@"950",@"840",@"256",@"359",@"386",@"950",@"840",@"256"],
                          @[@"449",@"476",@"450",@"460",@"247",@"349",@"376",@"750",@"460",@"247",@"349",@"376",@"750",@"460",@"247"],
                          @[@"473",@"458",@"496",@"486",@"968",@"573",@"958",@"396",@"486",@"968",@"573",@"958",@"396",@"486",@"1000"],
                          ];
            break;
            case 4:
            _dataArrs = @[@[@"500",@"500",@"500",@"20",@"256",@"359",@"386",@"950",@"840",@"256",@"359",@"386",@"950",@"840",@"256"],
                          @[@"549",@"576",@"550",@"460",@"247",@"349",@"376",@"750",@"460",@"247",@"349",@"376",@"750",@"460",@"247"],
                          @[@"573",@"558",@"596",@"486",@"968",@"573",@"958",@"396",@"486",@"968",@"573",@"958",@"396",@"486",@"1000"],
                          ];
            break;
            default:
                break;
        }
    }
    
    _teamsNameArr = @[@"莞城组",@"长安组",@"南城组",@"东城组",@"大朗组",@"横沥组",@"万江组",@"寮步组",@"常平组",@"清溪组",@"长安组",@"虎门组",@"道滘组",@"桥头组",@"东坑组"];
    _myPerformance = @{@"南城组":@"89"};
    
}
#pragma mark -- dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
