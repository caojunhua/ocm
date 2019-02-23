//
//  OCMTopFirstViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/16.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMTopFirstViewController.h"
#import "OCMLeftTopFirstTableViewCell.h"
#import "BaseFiltrationViewController.h"
#import "StarsFiltrationViewController.h"
#import "TownFiltrationViewController.h"
#import "NetCellFiltrationViewController.h"
#import "StatusFiltrationViewController.h"
#import "OCMLeftTopTaskTableViewCell.h"
#import "OCMTaskItem.h"
#import "OCMDetailItem.h"
#import "OCMSubTaskItem.h"

@interface OCMTopFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArr1;
@property (nonatomic, strong) NSMutableArray *dataArr2;
@property (nonatomic, strong) UIButton *starBtn;
@property (nonatomic, strong) UIButton *townBtn;
@property (nonatomic, strong) UIButton *netCellBtn;
@property (nonatomic, strong) UIButton *statusBtn;
@property (nonatomic, strong) UIView *filtrationView;
@property (nonatomic, strong) NSArray *filtraArr;
@property (nonatomic, strong) UIView *curView;
@property (nonatomic, strong) NSMutableArray *arr1;             //星级返回的条件
@property (nonatomic, strong) NSMutableArray *arr2;             //镇区返回的条件
@property (nonatomic, strong) NSMutableArray *arr3;             //网元返回的条件
@property (nonatomic, strong) NSMutableArray *arr4;             //状态返回的条件
@property (nonatomic, strong) UIButton *curSelectedBtn;         //当前选中的btn
@property (nonatomic, strong) UIView *coverView;                //筛选view蒙版遮挡view

@property (nonatomic, strong) NSMutableArray *isCloseArr;       //是否展开
@property (nonatomic, strong) NSMutableArray<NSArray *> *groupTitleArr;//任务数组
@property (nonatomic, strong) NSMutableArray *titleArr;                //任务主题

@property (nonatomic, strong) NSIndexPath *selectedIndex;       //当前选中的行
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation OCMTopFirstViewController

static NSString *cellID = @"OCMLeftTopFirstTableViewCell";
#define kMiddleViewHeight 285
- (instancetype)init {
    if (self = [super init]) {
        _arr1 = [NSMutableArray array];
        _arr2 = [NSMutableArray array];
        _arr3 = [NSMutableArray array];
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
        _hud.mode = MBProgressHUDModeIndeterminate;
        _hud.label.text = @"数据请求中...";
//        [self.view addSubview:_hud];
//        [_hud showAnimated:YES];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor RGBColorWithRed:241 withGreen:241 withBlue:241 withAlpha:0.8];
//    [self addData];
    [self addFitrationView];
//    [self addTableView];
//    [self loadData];  //由于接口问题,暂时不请求数据,用假数据
//    self.groupTitleArr = [NSMutableArray array];
//    self.titleArr = [NSMutableArray array];
}
#pragma mark -- 网络请求
- (void)loadData {
    [_hud showAnimated:YES];
    __weak typeof(self) weakSelf = self;
    OCMApiRequest *request = [OCMApiRequest sharedOCMApiRequest];
    NSString *path = [BaseURL stringByAppendingString:@"/v1/task/info/sorting"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *str1,*str2,*str3;
    if (_arr1.count > 0) str1 = [_arr1 componentsJoinedByString:@","];
    else str1 = NULL;
    if (_arr2.count > 0) str2 = [_arr2 componentsJoinedByString:@","];
    else str2 = NULL;
    if (_arr3.count > 0) str3 = [_arr3 componentsJoinedByString:@","];
    else str3 = NULL;
    params[@"levelId"] = str1;
    params[@"townId"] = str2;
    params[@"haStatus"] = str3;
//    OCMLog(@"[str1==%@\nstr2 == %@\nstr3==%@", str1,str2,str3);
    [request POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_hud removeFromSuperview];
        __strong typeof(self) theSelf = weakSelf;
        OCMTaskItem *taskItem = [OCMTaskItem mj_objectWithKeyValues:responseObject];
        theSelf.groupTitleArr = taskItem.data;
        [theSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _hud.label.text = @"加载失败";
        [_hud removeFromSuperview];
        OCMLog(@"failure--%@", error);
    }];
}
- (void)addFitrationView {
    CGFloat w = 290.f;
    CGFloat h = 36.f;
    NSInteger count = 3;
    _filtrationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    _filtrationView.backgroundColor = [UIColor RGBColorWithRed:255 withGreen:255 withBlue:255 withAlpha:0.7];
    [self.view addSubview:_filtrationView];
    CGFloat space = 5;// 图片和文字的间距
    NSString *titleString = [NSString stringWithFormat:@"文字"];
    CGFloat titleWidth = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}].width;
    UIImage *btnImage = [UIImage imageNamed:@"icon_inforeward_left"];
    CGFloat imageWidth = btnImage.size.width;
    CGFloat btnWidth = w/4;// 按钮的宽度
    if (titleWidth > btnWidth - imageWidth - space) {
        titleWidth = btnWidth- imageWidth - space;
    }
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(w/count * i, 0, w/count, h)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, titleWidth+space*0.5, 0, -titleWidth-space*0.5)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWidth-space*0.5, 0, imageWidth+space*0.5)];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"009dec"] forState:UIControlStateSelected];
        [btn setImage:ImageIs(@"btn_task_down") forState:UIControlStateNormal];
        [btn setImage:ImageIs(@"btn_task_up") forState:UIControlStateSelected];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:[UIColor RGBColorWithRed:255 withGreen:255 withBlue:255 withAlpha:0.7]];
        if (i == 0) {
            self.starBtn = btn;
            [btn setTitle:@"星级" forState:UIControlStateNormal];
        } else if (i == 1) {
            self.townBtn = btn;
            [btn setTitle:@"镇区" forState:UIControlStateNormal];
        } else {
            self.statusBtn = btn;
            [btn setTitle:@"状态" forState:UIControlStateNormal];
        }
        [self.filtrationView addSubview:btn];
        UIView *sepV = [[UIView alloc] initWithFrame:CGRectMake(w/count * (i+1), 10, 1, 16)];
        sepV.backgroundColor = [UIColor colorWithHexString:@"d6d6d6"];
        if (i <count - 1) {
            [self.filtrationView addSubview:sepV];
        }
        //添加控制器
        NSString *className = self.filtraArr[i];
        UIViewController *vc = [[NSClassFromString(className) alloc] init];
        [self addChildViewController:vc];
    }
    UIView *topSepV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 0.5)];
    topSepV.backgroundColor = [UIColor colorWithHexString:@"d6d6d6"];
    topSepV.alpha = 0.8;
    UIView *bottomSepV = [[UIView alloc] initWithFrame:CGRectMake(0, h-1, w, 0.5)];
    bottomSepV.backgroundColor = [UIColor colorWithHexString:@"d6d6d6"];
    bottomSepV.alpha = 0.8;
    [self.filtrationView addSubview:topSepV];
    [self.filtrationView addSubview:bottomSepV];
    self.coverView = [[UIView alloc] initWithFrame:CGRectMake(0, h, 290.0, kMiddleViewHeight-h)];
    self.coverView.backgroundColor = [UIColor colorWithHexString:@"969696"];
    self.coverView.alpha = 0.25;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] init];
    [tapGes addTarget:self action:@selector(hiddenFiltrationView)];
    [self.coverView addGestureRecognizer:tapGes];
}


#pragma mark -- 点击事件
- (void)hiddenFiltrationView {
    [self.curView removeFromSuperview];
    [self.coverView removeFromSuperview];
    _curView = nil;
}
- (void)clickBtn:(UIButton *)btn {
    if (_curView && btn.tag == self.curSelectedBtn.tag) {
        [_curView removeFromSuperview];
        [self.coverView removeFromSuperview];
        _curView = nil;
        return;
    }
    self.curSelectedBtn.selected = !self.curSelectedBtn.selected;
    btn.selected = YES;
    self.curSelectedBtn = btn;
    
    [self.curView removeFromSuperview];
    [self.coverView removeFromSuperview];
    
    [self.view addSubview:self.coverView];
    NSInteger index = btn.tag;
    BaseFiltrationViewController *vc = [self.childViewControllers objectAtIndex:index];
    if (vc) {
        if (_curView) {
            [_curView removeFromSuperview];
        }
        _curView = vc.view;
        [UIView animateWithDuration:0.5 animations:^{
            [self.view addSubview:vc.view];
        }];
    }
    __weak typeof(self) weakSelf = self;
    switch (index) {
        case 0:
        {
            vc.hiddenBlock = ^(NSMutableArray *arr) {
                __strong typeof(self) theSelf = weakSelf;
                theSelf.arr1 = arr;
                [UIView animateWithDuration:0.5 animations:^{
                    [theSelf.curView removeFromSuperview];
                    [theSelf.coverView removeFromSuperview];
                }];
                OCMLog(@"vc.selectedArr-111-%@", [arr debugDescription]);
                [theSelf loadData];
            };
        }
            break;
        case 1:
        {
            vc.hiddenBlock = ^(NSMutableArray *arr) {
                __strong typeof(self) theSelf = weakSelf;
                theSelf.arr2 = arr;
                [UIView animateWithDuration:0.5 animations:^{
                    [theSelf.curView removeFromSuperview];
                    [theSelf.coverView removeFromSuperview];
                }];
                OCMLog(@"vc.selectedArr-2222-%@", [arr debugDescription]);
                [theSelf loadData];
            };
        }
            break;
        case 2:
        {
            vc.hiddenBlock = ^(NSMutableArray *arr) {
                __strong typeof(self) theSelf = weakSelf;
                theSelf.arr4 = arr;
                [UIView animateWithDuration:0.5 animations:^{
                    [theSelf.curView removeFromSuperview];
                    [theSelf.coverView removeFromSuperview];
                }];
                //                OCMLog(@"vc.selectedArr-444-%@", [arr debugDescription]);
                [theSelf loadData];
            };
        }
            break;
        default:
            break;
    }
}
- (void)clickTitleView:(UIControl *)control {
    NSInteger index = control.tag;
    [self.isCloseArr replaceObjectAtIndex:index withObject:@(![self.isCloseArr[index] boolValue])];
    NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:index];
    [self.tableView reloadSections:indexset withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark -- UITableViewDelegate,dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groupTitleArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BOOL isClose = [self.isCloseArr[section] boolValue];
    if (isClose == 1) {
        return 0;
    } else {
//        OCMDetailItem *detailItem = self.groupTitleArr[section];
//        return self.groupTitleArr[section].count;
        OCMDetailItem *detailItem = [OCMDetailItem mj_objectWithKeyValues:self.groupTitleArr[section]];
        return detailItem.taskdetaillist.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OCMLeftTopTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OCMLeftTopTaskTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    OCMDetailItem *detailItem = [OCMDetailItem mj_objectWithKeyValues:self.groupTitleArr[indexPath.section]];
    NSMutableArray *tempArr = [NSMutableArray mj_objectWithKeyValues:detailItem.taskdetaillist];
    OCMSubTaskItem *subTaskItem = tempArr[indexPath.row];
    cell.detailNetL.text = subTaskItem.chname;
    if (indexPath == self.selectedIndex) {
        cell.netL.textColor = [UIColor colorWithHexString:@"009dec"];
        cell.numberL.textColor = [UIColor colorWithHexString:@"009dec"];
        cell.detailL.textColor = [UIColor colorWithHexString:@"009dec"];
        cell.detailNetL.textColor = [UIColor colorWithHexString:@"009dec"];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 39;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath;
//    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.row];
//    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadData];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIControl *titleView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 290, 39)];
    titleView.backgroundColor = [UIColor RGBColorWithRed:255 withGreen:255 withBlue:255 withAlpha:1.0];
    titleView.tag = section;
    [titleView addTarget:self action:@selector(clickTitleView:) forControlEvents:UIControlEventTouchUpInside];
    OCMDetailItem *detailItem = [OCMDetailItem mj_objectWithKeyValues:self.groupTitleArr[section]];
    //1.任务类型
    UIButton *taskBtn = [[UIButton alloc] initWithFrame:CGRectMake(13, 13, 48, 14)];
    if (section == 0) {
        ViewBorder(taskBtn, 1, [UIColor colorWithHexString:@"009dec"], 3);
        [taskBtn setTitle:@"常规任务" forState:UIControlStateNormal];
        [taskBtn setTitleColor:[UIColor colorWithHexString:@"009dec"] forState:UIControlStateNormal];
    } else if (section == 1) {
        ViewBorder(taskBtn, 1, [UIColor colorWithHexString:@"F03225"], 3);
        [taskBtn setTitle:@"巡检任务" forState:UIControlStateNormal];
        [taskBtn setTitleColor:[UIColor colorWithHexString:@"F03225"] forState:UIControlStateNormal];
    } else {
        ViewBorder(taskBtn, 1, [UIColor colorWithHexString:@"F5991F"], 3);
        [taskBtn setTitle:@"110任务" forState:UIControlStateNormal];
        [taskBtn setTitleColor:[UIColor colorWithHexString:@"F5991F"] forState:UIControlStateNormal];
    }
    [taskBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [titleView addSubview:taskBtn];
    //2.文本标题
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(65, 13, 190, 14)];
    [titleView addSubview:label];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor colorWithHexString:@"333333"];
//    label.text = [NSString stringWithFormat:@"第%ld个任务",section];
    label.text = detailItem.taskTheme;
    //3.箭头
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(260, 15, 14, 7)];
    BOOL isClose = [self.isCloseArr[section] boolValue];
    if (isClose == 1) {
        imgV.image = ImageIs(@"btn_task_zoom@2x");
    } else {
        imgV.image = ImageIs(@"upArrow");
    }
    [titleView addSubview:imgV];
    return titleView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- data
- (UITableView *)tableView {
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 36, 290, kMiddleViewHeight) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.view addSubview:self.tableView];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.isCloseArr = [NSMutableArray new];
        for (int i = 0; i < self.groupTitleArr.count; i++) {
            if (i == 0) {
                [self.isCloseArr addObject:@(NO)]; //默认第一个展开
            } else {
                [self.isCloseArr addObject:@(YES)];
            }
        }
        self.tableView.sectionFooterHeight = 0.1f;
    }
    return _tableView;
}
- (NSArray *)filtraArr {
    if (!_filtraArr) {
        _filtraArr = @[@"StarsFiltrationViewController",@"TownFiltrationViewController",@"NetCellFiltrationViewController",@"StatusFiltrationViewController"];
    }
    return _filtraArr;
}
- (NSMutableArray<NSArray *> *)groupTitleArr {
    if (!_groupTitleArr) {
        _groupTitleArr = @[@[@"1-1",@"1-2",@"1-3",@"1-4",@"1-5",@"1-3",@"1-4",@"1-5",@"1-3",@"1-4",@"1-5"],@[@"2-1",@"2-2",@"2-3",@"2-4",@"2-5",@"1-3",@"1-4",@"1-5",@"1-3",@"1-4",@"1-5"],@[@"3-1",@"3-2",@"3-3",@"3-4",@"3-5",@"1-3",@"1-4",@"1-5",@"1-3",@"1-4",@"1-5",@"1-3",@"1-4",@"1-5"],@[@"4-1",@"4-2",@"4-3",@"4-4",@"1-3",@"1-4",@"1-5",@"1-3",@"1-4",@"1-5",@"1-3",@"1-4",@"1-5"],@[@"5-1",@"5-2",@"5-3",@"5-4",@"1-3",@"1-4",@"1-5",@"1-3",@"1-4",@"1-5",@"1-3",@"1-4",@"1-5"]];
    }
    return _groupTitleArr;
}
- (void)addData {
    _dataArr1 = [[NSMutableArray alloc] initWithObjects:@"小谷围街信息枢纽楼一楼电话卡特约代理点(SQD123585)",@"东莞狮山镇芙蓉王广场网点(SQD12583)",@"小谷围街信息枢纽楼一楼电话卡特约代理点(SQD123585)",@"东莞狮山镇芙蓉王广场网点(SQD12583)",@"小谷围街信息枢纽楼一楼电话卡特约代理点(SQD123585)",@"东莞狮山镇芙蓉王广场网点(SQD12583)",@"小谷围街信息枢纽楼一楼电话卡特约代理点(SQD123585)",@"东莞狮山镇芙蓉王广场网点(SQD12583)",@"小谷围街信息枢纽楼一楼电话卡特约代理点(SQD123585)",@"东莞狮山镇芙蓉王广场网点(SQD12583)",@"小谷围街信息枢纽楼一楼电话卡特约代理点(SQD123585)",@"东莞狮山镇芙蓉王广场网点(SQD12583)", nil];
    _dataArr2 = [[NSMutableArray alloc] initWithObjects:@"QD123696",@"QD123696",@"QD123696",@"QD123696",@"QD123696",@"QD123696",@"QD123696",@"QD123696",@"QD123696",@"QD123696",@"QD123696",@"QD123696",nil];
    
}
@end
