//
//  OCMRootViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/11/30.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMMasterViewController.h"
#import "OCMMasterTableViewCell.h"


#import "OCMMyAccountViewController.h" //1.我的账号
#import "OCMHomePageViewController.h" //2.首页
#import "OCMMonitoringViewController.h" //3.监控预警
#import "OCMReadLearningViewController.h" //4.待阅学习
#import "OCMTaskExecutionViewController.h" //5.任务执行及管理
#import "OCMCheckOnWorkViewController.h" //6.考勤排班
#import "OCMIntelligenceViewController.h" //7.情报收集
#import "OCMTownViewController.h" //8.工作台(镇域协同-->改为工作台)
#import "OCMKnowledgeViewController.h" //9.知识库
#import "OCMMyFavoriteViewController.h" //10.我的收藏

#import "OCMMyAccountLeftSubViewController.h" // 我的账号的subView
#import "OCMReadLeftSubViewController.h" // 待阅学习的subView
#import "OCMTaskLeftSubViewController.h" // 任务执行及管理的subView
#import "OCMTownLeftSubViewController.h" //镇域协同的subView
#import "OCMKnowledgeLeftSubViewController.h" //知识库的subView

#import "OCMRightBaseNavigationViewController.h"
#import "OCMBaseRightViewController.h"

@interface OCMMasterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OCMMasterTableViewCell *OCMCell;
@property (nonatomic, strong) NSArray *classNameArr;
@property (nonatomic, strong) NSArray *imgNameArr;
@property (nonatomic, strong) NSArray *titleNameArr;
@property (nonatomic, strong) NSIndexPath *selectedIndexP;
@property (nonatomic, strong) UILabel *accountL;//显示的账号
@property (nonatomic, strong) UIImageView *accountImg;//账号头像
@property (nonatomic, assign) BOOL isStretch;//左侧是否展开
@property (nonatomic, strong) UIView *titleHeadV;//头部view
@property (nonatomic, strong) NSMutableDictionary *detailViewDict;//视图控制器缓存字典

@property (nonatomic, strong) NSArray *permissionArr;//显示权限菜单名字
@property (nonatomic, strong) NSArray *hiddenArr;
@property (nonatomic, strong) NSArray *classPermissArr;
@end

@implementation OCMMasterViewController

static NSString *cellID = @"cell";

#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    _isStretch = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self setData];
        [self setNotification];
    });
    [self setUpLayout];
    [self setTitleView];
    [self setDefaultSelectedCell];
}
#pragma mark -- 通知
- (void)setNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swipeLeft) name:NswipeLeftGes object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swipeRight) name:NswipeRightGes object:nil];
}
- (void)setTitleView { //展开/隐藏 的按钮
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _leftBtn = leftBtn;
    _leftBtn.tag = 100;
    if (_isStretch) {
        [leftBtn setImage:[UIImage imageNamed:@"icon_leftbar1_list"] forState:UIControlStateNormal];
    } else {
        [leftBtn setImage:[UIImage imageNamed:@"icon_leftbar1_list_pre"] forState:UIControlStateNormal];
    }
    [leftBtn addTarget:self action:@selector(clickLeftItem) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:leftBtn];
}
- (void)setUpLayout {
    _isStretch = YES;//默认左侧展开
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    OCMLog(@"_hiddenArr--%@\nrect--%f", [_hiddenArr debugDescription],self.view.bounds.size.width);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor RGBColorWithRed:47 withGreen:60 withBlue:66 withAlpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
- (void)setDefaultSelectedCell {
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:indexP animated:NO scrollPosition:0];
    [self tableView:self.tableView didSelectRowAtIndexPath:indexP];
    self.selectedIndexP = indexP;
}
#pragma mark -- 点击事件
- (void)clickAccountBtn {
    _titleHeadV.backgroundColor = [UIColor colorWithHexString:@"#253136"];
    OCMMyAccountViewController *accountVC = [self.detailViewDict objectForKey:@"OCMMyAccountViewController"];
    if (!accountVC) {
        OCMMyAccountViewController *accountVC = [[OCMMyAccountViewController alloc] init];
        [self.detailViewDict setObject:accountVC forKey:@"OCMMyAccountViewController"];
        OCMRightBaseNavigationViewController *navi = [[OCMRightBaseNavigationViewController alloc] initWithRootViewController:accountVC];
        [navi.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff"]}];
        [self showDetailViewController:navi sender:nil];
    } else {
        OCMRightBaseNavigationViewController *navi = [[OCMRightBaseNavigationViewController alloc] initWithRootViewController:accountVC];
        [navi.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff"]}];
        [self showDetailViewController:navi sender:nil];
    }
    
//    OCMMyAccountLeftSubViewController *accountSubVC = [[OCMMyAccountLeftSubViewController alloc] init]; //隐藏二级菜单
//    [self.navigationController pushViewController:accountSubVC animated:YES];
    //取消当前选中的cell
    [self.tableView deselectRowAtIndexPath:self.selectedIndexP animated:NO];
    OCMMasterTableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.selectedIndexP];
    cell.backgroundColor = [UIColor RGBColorWithRed:47 withGreen:60 withBlue:66 withAlpha:1.0];
    self.selectedIndexP = nil;
}
- (void)clickLeftItem {
    [[NSNotificationCenter defaultCenter] postNotificationName:NclickLeftBtn object:nil];
}
#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _permissionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OCMMasterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[OCMMasterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor RGBColorWithRed:47 withGreen:60 withBlue:66 withAlpha:1.0];
    }
    cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgNameArr[indexPath.row]]];
    if (_isStretch) {
//        cell.label.text = self.titleNameArr[indexPath.row];
        cell.label.text = self.permissionArr[indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat height = 50;
    UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, height)];
    _accountL = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 100, 50)];
    _accountL.text = @"测试人员";
    _accountL.textColor = [UIColor RGBColorWithRed:254 withGreen:254 withBlue:254 withAlpha:1.0];
    _accountImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    UIImage *img = [UIImage createImageWithColor:[UIColor redColor]];
    _accountImg = [UIImageView createWithImageView:_accountImg width:33 height:33 BorderWidth:2 borderColor:[UIColor whiteColor]];
    [_accountImg setImage:img];
    CGRect rect = _accountImg.frame;
    rect.origin.x = 8.5;
    rect.origin.y = 8.5;
    _accountImg.frame = rect;
    
    [view addSubview:_accountImg];
    [view addSubview:_accountL];
    [view addTarget:self action:@selector(clickAccountBtn) forControlEvents:UIControlEventTouchUpInside];
    _titleHeadV = view;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    OCMMasterTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor RGBColorWithRed:47 withGreen:60 withBlue:66 withAlpha:1.0];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _titleHeadV.backgroundColor = [UIColor RGBColorWithRed:47 withGreen:60 withBlue:66 withAlpha:1.0];
    OCMMasterTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHexString:@"#253136"];
    self.selectedIndexP = indexPath;
    
//    NSString *className = self.classNameArr[indexPath.row];
    NSString *className = self.classPermissArr[indexPath.row];
    OCMRightBaseNavigationViewController *navi = [self getViewControllerWithClassName:className];
    if (indexPath.row == 0) {
        [navi setNavigationBarHidden:YES animated:YES];
    }
    [self showDetailViewController:navi sender:nil];
    
    if ([className isEqualToString:@"OCMTaskExecutionViewController"]) {
        OCMLog(@"点击了任务执行及管理");
        OCMMyAccountLeftSubViewController *accountSubVC = [[OCMMyAccountLeftSubViewController alloc] init]; //隐藏二级菜单
        [self.navigationController pushViewController:accountSubVC animated:YES];
        self.leftBtn.hidden = YES;
    }
}

/**
 根据类名字返回该类作为根控制器的导航控制器

 @param className 类名字
 @return 对应的导航控制器
 */
- (OCMRightBaseNavigationViewController *)getViewControllerWithClassName:(NSString *)className {
    OCMBaseRightViewController *vc = [self.detailViewDict objectForKey:className];
    if (!vc) {
        Class class = NSClassFromString(className);
        OCMBaseRightViewController *vc = [[class alloc] init];
        [self.detailViewDict setObject:vc forKey:className];
        vc.referWidht = self.leftWidth;
        vc.isStretch = self.isStretch;
        OCMRightBaseNavigationViewController *navi = [[OCMRightBaseNavigationViewController alloc] initWithRootViewController:vc];
        [navi.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff"]}];
        return navi;
    } else {
        vc.referWidht = self.leftWidth;
        vc.isStretch = self.isStretch;
        OCMRightBaseNavigationViewController *navi = [[OCMRightBaseNavigationViewController alloc] initWithRootViewController:vc];
        [navi.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff"]}];
        return navi;
    }
}
- (NSArray *)shouldHiddenArrWithPermission:(NSArray *)permissArray titleArr:(NSArray *)titleNameArray {
    NSMutableArray *temp1 = [NSMutableArray arrayWithArray:titleNameArray];
    NSMutableArray *temp2 = [NSMutableArray arrayWithArray:permissArray];
    [temp1 removeObjectsInArray:temp2];
    return temp1;
}
#pragma mark -- 懒加载
- (NSArray *)classNameArr {
    if (!_classNameArr) {
        _classNameArr = @[@"OCMHomePageViewController",@"OCMTownViewController",@"OCMMonitoringViewController",@"OCMReadLearningViewController",@"OCMTaskExecutionViewController",@"OCMCheckOnWorkViewController",@"OCMIntelligenceViewController",@"OCMKnowledgeViewController",@"OCMMyFavoriteViewController"];
    }
    return _classNameArr;
}
- (NSArray *)titleNameArr {
    if (!_titleNameArr) {
        _titleNameArr = @[@"首页",@"工作台",@"监控预警",@"待学待阅",@"任务执行及管理",@"考勤排班",@"点位信息采集",@"知识库",@"我的收藏"];
    }
    return _titleNameArr;
}
- (void)setData {
    _classNameArr = @[@"OCMHomePageViewController",@"OCMTownViewController",@"OCMMonitoringViewController",@"OCMReadLearningViewController",@"OCMTaskExecutionViewController",@"OCMCheckOnWorkViewController",@"OCMIntelligenceViewController",@"OCMKnowledgeViewController",@"OCMMyFavoriteViewController"];
    _titleNameArr = @[@"首页",@"工作台",@"监控预警",@"待学待阅",@"任务执行及管理",@"考勤排班",@"点位信息采集",@"知识库",@"我的收藏"];
    _permissionArr = @[@"首页",@"工作台",@"监控预警",@"待学待阅",@"任务执行及管理",@"考勤排班",@"点位信息采集",@"知识库",@"我的收藏"];
    _hiddenArr = [self shouldHiddenArrWithPermission:_permissionArr titleArr:_titleNameArr];//待学待阅,点位信息采集,知识库
    NSMutableArray *tagArr = [NSMutableArray array];
    for (int i = 0; i < _hiddenArr.count; i++) {
        NSString *str = _hiddenArr[i];
        if ([_titleNameArr containsObject:str]) {
            NSInteger index = [_titleNameArr indexOfObject:str];
            NSString *indexStr = [NSString stringWithFormat:@"%ld",index];
            [tagArr addObject:indexStr];
        }
    }
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:_classNameArr];
    NSMutableArray *temp1 = [NSMutableArray array];
    for (int i = 0; i < tagArr.count; i++) {
        NSInteger index = [tagArr[i] integerValue];
        NSString *str = [tempArr objectAtIndex:index];
        [temp1 addObject:str];
    }
    [tempArr removeObjectsInArray:temp1];
    _classPermissArr = tempArr;
    OCMLog(@"_calssPermissArr--%@", [_classPermissArr debugDescription]);
}
- (NSArray *)imgNameArr {
    if (!_imgNameArr) {
        _imgNameArr = @[@"icon_leftbar2_home",@"icon_leftbar3_working",@"icon_leftbar4_warning",@"icon_leftbar5_learning",@"icon_leftbar6_task",@"icon_leftbar7_check",@"icon_leftbar8_message",@"icon_leftbar9_knowledge",@"icon_leftbar10_collection"];
    }
    return _imgNameArr;
}
- (NSMutableDictionary *)detailViewDict {
    if (!_detailViewDict) {
        _detailViewDict = [NSMutableDictionary dictionary];
    }
    return _detailViewDict;
}
#pragma mark -- 监听左侧收缩或展开状态
- (void)swipeLeft {
    OCMLog(@"向左扫动了...或点击收缩.....");
    _isStretch = NO;
    [_leftBtn setImage:[UIImage imageNamed:@"icon_leftbar1_list_pre"] forState:UIControlStateNormal];
    [self.tableView reloadData];
}
- (void)swipeRight {
    OCMLog(@"向右扫动了...或点击展开.....");
    _isStretch = YES;
    [_leftBtn setImage:[UIImage imageNamed:@"icon_leftbar1_list"] forState:UIControlStateNormal];
    [self.tableView reloadData];
}

#pragma mark -- dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    OCMLog(@"销毁了--MasterVC");
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
