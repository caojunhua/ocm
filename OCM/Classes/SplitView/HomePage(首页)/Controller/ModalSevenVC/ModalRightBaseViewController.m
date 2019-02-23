//
//  ModalRightBaseNavViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/3/15.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "ModalRightBaseViewController.h"
//#import "ModalFirstViewController.h"
#import "OCMLeftBaseNavigationController.h"
#import "ModalRightBaseViewController.h"
#import "OCMMasterTableViewCell.h"
//右侧控制器
#import "OCMDetailNetViewController.h"
#import "ModalSecondViewController.h"
#import "ModalThirdViewController.h"
#import "ModalFourthViewController.h"
#import "ModalFifthViewController.h"
#import "ModalSixthViewController.h"
#import "ModalSeventhViewController.h"

#import "OCMRightBaseNavigationViewController.h"
#import "OCMBaseRightViewController.h"

@interface ModalRightBaseViewController ()<UITableViewDelegate,UITableViewDataSource>
//@property (nonatomic, strong) ModalFirstViewController *firstVC;
//@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OCMLeftBaseNavigationController *masterVC;
@property (nonatomic, strong) ModalRightBaseViewController *rightBaseVC;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleNameArr;
@property (nonatomic, strong) NSArray *imgNameArr;
@property (nonatomic, strong) NSIndexPath *selectedIndexP;                  //左侧当前选中的
@property (nonatomic, strong) NSArray *classPermissArr;
@property (nonatomic, strong) NSMutableDictionary *detailViewDict;//视图控制器缓存字典
@property (nonatomic, strong) UIButton *closeBtn;
@end

@implementation ModalRightBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self config];
    [self setTitleView];
    [self setDefaultSelectedCell:self.selectIndex];
}
- (void)config {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor RGBColorWithRed:47 withGreen:60 withBlue:66 withAlpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
- (void)setTitleView { //展开/隐藏 的按钮
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _closeBtn = leftBtn;
    [leftBtn setTitle:@"退出" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(clickLeftItem) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:leftBtn];
}
- (void)setDefaultSelectedCell:(NSInteger)indexRow {
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:indexRow inSection:0];
    [self.tableView selectRowAtIndexPath:indexP animated:NO scrollPosition:0];
    [self tableView:self.tableView didSelectRowAtIndexPath:indexP];
    self.selectedIndexP = indexP;
}
#pragma mark -- 点击事件
- (void)clickLeftItem {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleNameArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    OCMMasterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[OCMMasterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor RGBColorWithRed:47 withGreen:60 withBlue:66 withAlpha:1.0];
    }
    cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgNameArr[indexPath.row]]];
    cell.label.text = self.titleNameArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    OCMMasterTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor RGBColorWithRed:47 withGreen:60 withBlue:66 withAlpha:1.0];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OCMMasterTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHexString:@"#253136"];
    self.selectedIndexP = indexPath;
    NSString *className = self.classPermissArr[indexPath.row];
    OCMRightBaseNavigationViewController *navi = [self getViewControllerWithClassName:className];
    [self showDetailViewController:navi sender:nil];
}

/**
 根据类名字返回该类作为根控制器的导航控制器
 
 @param className 类名字
 @return 对应的导航控制器
 */
- (OCMRightBaseNavigationViewController *)getViewControllerWithClassName:(NSString *)className {
    UIViewController *vc = [self.detailViewDict objectForKey:className];
    if (!vc) {
        Class class = NSClassFromString(className);
        UIViewController *vc = [[class alloc] init];
        [self.detailViewDict setObject:vc forKey:className];
        //        vc.referWidht = self.leftWidth;
        //        vc.isStretch = self.isStretch;
        OCMRightBaseNavigationViewController *navi = [[OCMRightBaseNavigationViewController alloc] initWithRootViewController:vc];
        [navi.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff"]}];
        return navi;
    } else {
        //        vc.referWidht = self.leftWidth;
        //        vc.isStretch = self.isStretch;
        OCMRightBaseNavigationViewController *navi = [[OCMRightBaseNavigationViewController alloc] initWithRootViewController:vc];
        [navi.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff"]}];
        return navi;
    }
}
#pragma mark -- data
- (NSArray *)titleNameArr {
    if (!_titleNameArr) {
        _titleNameArr = @[@"任务清单",@"基础信息",@"业务发展",@"酬金账单",@"业务质量",@"走访记录",@"异动预警"];
    }
    return _titleNameArr;
}
- (NSArray *)imgNameArr {
    if (!_imgNameArr) {
        _imgNameArr = @[@"icon_iinformation_task",@"icon_leftbar3_working",@"icon_iinformation_develop",@"icon_iinformation_bill",@"icon_iinformation_quality",@"icon_iinformation_record",@"icon_iinformation_warn"];
    }
    return _imgNameArr;
}
- (NSArray *)classPermissArr {
    if (!_classPermissArr) {
        _classPermissArr = @[@"OCMDetailNetViewController",@"ModalSecondViewController",@"ModalThirdViewController",@"ModalFourthViewController",@"ModalFifthViewController",@"ModalSixthViewController",@"ModalSeventhViewController"];
    }
    return _classPermissArr;
}
//- (void)config {
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screenWidth - kLeftBigWidth, screenHeight - 64) style:UITableViewStylePlain];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    [self.view addSubview:self.tableView];
//}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 5;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *ID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    cell.textLabel.text = @"aaaa";
//    return cell;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    ModalFirstViewController *firstVC = [[ModalFirstViewController alloc] init];
//    [self.navigationController pushViewController:firstVC animated:YES];
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
