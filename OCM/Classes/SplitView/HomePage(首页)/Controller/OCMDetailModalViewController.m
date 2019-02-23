//
//  OCMDetailModalViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/3/12.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMDetailModalViewController.h"
#import "OCMDetailNetViewController.h"
#import "ModalFirstViewController.h"
#import "ModalSecondViewController.h"
#import "ModalThirdViewController.h"
#import "ModalFourthViewController.h"
#import "ModalFifthViewController.h"
#import "ModalSixthViewController.h"
#import "ModalSeventhViewController.h"
#import "OCMMasterTableViewCell.h"
#import "rightMidDetailItem.h"
#import "ModalRightBaseViewController.h"

@interface OCMDetailModalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *rightView;

@property (nonatomic, strong) NSArray *titleNameArr;
@property (nonatomic, strong) NSArray *imgNameArr;
@property (nonatomic, strong) NSMutableDictionary *vcDict;
@property (nonatomic, strong) OCMDetailNetViewController *detailVC;
@property (nonatomic, strong) ModalFirstViewController *firstVC;
@property (nonatomic, strong) ModalSecondViewController *secondVC;
@property (nonatomic, strong) ModalThirdViewController *thridVC;
@property (nonatomic, strong) rightMidDetailItem *item;
@property (nonatomic, strong) ModalRightBaseViewController *rightBaseNavVC;
@end

@implementation OCMDetailModalViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addSubVC];
    [self getData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self config];
//    [self addSubVC];
    [self setSelectedCell];
}
- (void)setSelectedCell {
    NSIndexPath *index = [NSIndexPath indexPathForRow:self.indexP inSection:0];
    [self.tableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionTop];
    if ([self.tableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:index];
    }
}
- (void)addSubVC {
    if (!_detailVC) {
        _detailVC = [[OCMDetailNetViewController alloc] init];
    }
    [self.vcDict setObject:_detailVC forKey:@"OCMDetailNetViewController"];
    [self addChildViewController:_detailVC];
    
    if (!_firstVC) {
        _firstVC = [[ModalFirstViewController alloc] init];
    }
    [self.vcDict setObject:_firstVC forKey:@"ModalFirstViewController"];
    [self addChildViewController:_firstVC];
    
    if (!_secondVC) {
        _secondVC = [[ModalSecondViewController alloc] init];
    }
    [self.vcDict setObject:_secondVC forKey:@"ModalSecondViewController"];
    [self addChildViewController:_secondVC];
    
    if (!_thridVC) {
        _thridVC = [[ModalThirdViewController alloc] init];
    }
    [self.vcDict setObject:_thridVC forKey:@"ModalThirdViewController"];
    [self addChildViewController:_thridVC];
}
#pragma mark -- 布局
- (void)config {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 64)];
    view.backgroundColor = [UIColor colorWithHexString:@"009dec"];
    [self.view addSubview:view];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 50, 30)];
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    [view addSubview:btn];
    [btn addTarget:self action:@selector(clickDismiss) forControlEvents:UIControlEventTouchUpInside];
    
    //添加NavigationController
//    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(kLeftBigWidth, 0, screenWidth - kLeftBigWidth, screenHeight - 64)];
//    self.rightBaseNavVC = [[ModalRightBaseNavViewController alloc] init];
//    [self addChildViewController:self.rightBaseNavVC];
//    [self.view addSubview:self.rightView];
//    [self.rightView addSubview:self.rightBaseNavVC.view];
    //左侧列表
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kLeftBigWidth, screenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor RGBColorWithRed:37 withGreen:50 withBlue:56 withAlpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //右侧rightV
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(kLeftBigWidth, 64, screenWidth - kLeftBigWidth, screenHeight - 64)];
    self.rightView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.rightView];
    [self.rightView addSubview:_detailVC.view]; // 默认显示的界面
}
#pragma mark -- 点击事件
- (void)clickDismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cellID";
    OCMMasterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[OCMMasterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor RGBColorWithRed:37 withGreen:50 withBlue:56 withAlpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.imgView.image = ImageIs(self.imgNameArr[indexPath.row]);
    cell.label.text = self.titleNameArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    OCMMasterTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor RGBColorWithRed:37 withGreen:50 withBlue:56 withAlpha:1];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OCMMasterTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithHexString:@"#253136"];
//    cell.backgroundColor = [UIColor grayColor];
    cell.backgroundColor = [UIColor RGBColorWithRed:28 withGreen:37 withBlue:41 withAlpha:1];
    if (self.rightView.subviews) {
        [self.rightView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    if (indexPath.row == 0) {
        if (!_detailVC) {
            _detailVC = [[OCMDetailNetViewController alloc] init];
            [self addChildViewController:_detailVC];
        }
        [self.rightView addSubview:_detailVC.view];
//        [self.rightView addSubview:self.rightBaseNavVC.view];
    } else if (indexPath.row == 1) {
        if (!_secondVC) {
            _secondVC = [[ModalSecondViewController alloc] init];
            [self addChildViewController:_secondVC];
        }
        [self.rightView addSubview:_secondVC.view];
    } else if (indexPath.row == 2) {
        if (!_thridVC) {
            _thridVC = [[ModalThirdViewController alloc] init];
            [self addChildViewController:_thridVC];
        }
        [self.rightView addSubview:_thridVC.view];
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
- (NSMutableDictionary *)vcDict {
    if (!_vcDict) {
        _vcDict = [NSMutableDictionary dictionary];
    }
    return _vcDict;
}
- (void)getData {
    OCMApiRequest *request = [OCMApiRequest sharedOCMApiRequest];
    NSString *url = @"/channel/detail";
    NSString *path = [BaseURL stringByAppendingString:url];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = self.QDid;
    [request POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        OCMLog(@"success--%@", responseObject);
        rightMidDetailItem *item = [rightMidDetailItem mj_objectWithKeyValues:responseObject[@"data"]];
        self.item = item;
//        self.midV.item = item;
//        self.titleLabel.text = item.chName;
//        self.stars = 3;
        //        OCMLog(@"ite--%@", item.rankCode);  //星级
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.hud.hidden = YES;
//        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        OCMLog(@"failure--%@", error);
    }];
}
@end
