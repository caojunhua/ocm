//
//  OCMSettingsViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/27.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMSettingsViewController.h"
#import "OCMSettingTableViewCell.h"
#import "GestureLoginViewController.h"
#import "MessageLoginViewController.h"
#import "AppDelegate.h"

@interface OCMSettingsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat currentWidth;
@property (nonatomic, strong) UIButton *signOutBtn;
@property (nonatomic, strong) NSMutableDictionary *dictCache;
@end

@implementation OCMSettingsViewController

static NSString *IdCell = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _dictCache = [NSMutableDictionary dictionary];
    [self setNotification];
    if (self.isBigLeftWidth) {
        [self resetLeft];
    } else {
        [self resetRight];
    }
    [self addSignOutBtn];
}
- (void)setNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetRight) name:NswipeLeftGes object:nil];//向左
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetLeft) name:NswipeRightGes object:nil];//向右
}
- (void)resetLeft {
    _isBigLeftWidth = NO;
    self.currentWidth = screenWidth - kLeftBigWidth;
    [self setUpUI];
}
- (void)resetRight {
    _isBigLeftWidth = YES;
    self.currentWidth = screenWidth - kLeftSmallWidth;
    [self setUpUI];
}
- (void)setUpUI {
    NSMutableArray<UIView*> *arr = self.view.subviews.mutableCopy;
    [arr enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITableView class]]) {
            [obj removeFromSuperview];
        }
    }];
    CGRect rect = CGRectMake(0, 64, self.currentWidth, 465 + 50);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //iOS11新特性下,关闭self-sizing,否则动态设置headerView有问题
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
}

#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
    } else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OCMSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IdCell];
    if (!cell) {
        cell = [[OCMSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        cell.titleL.text = @"自动打卡";
        cell.switchBtn.hidden = NO;
        cell.switchBtn.tag = 0;
        [cell.switchBtn addTarget:self action:@selector(clickSwitchBtn:) forControlEvents:UIControlEventTouchUpInside];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.titleL.text = @"手势密码";
            cell.sepV.hidden = NO;
            cell.switchBtn.hidden = NO;
            cell.switchBtn.tag = 1;
            [cell.switchBtn addTarget:self action:@selector(clickSwitchBtn:) forControlEvents:UIControlEventTouchUpInside];
        } else if (indexPath.row == 1) {
            cell.titleL.text = @"更改手势密码";
            cell.sepV.hidden = NO;
        } else {
            cell.titleL.text = @"指纹密码";
            cell.switchBtn.hidden = NO;
            cell.switchBtn.tag = 1;
            [cell.switchBtn addTarget:self action:@selector(clickFingerBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
    } else {
        cell.titleL.text = @"版本号";
        cell.textL.hidden = NO;
        NSString *ver = [@"V" stringByAppendingString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        cell.textL.text = ver;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            GestureLoginViewController *gesVC = [_dictCache objectForKey:@"GestureLoginViewController"];
            if (!gesVC) {
                OCMLog(@"if --(!gesVC");
                GestureLoginViewController *gesVC = [[GestureLoginViewController alloc] init];
                [_dictCache setObject:gesVC forKey:@"GestureLoginViewController"];
                [self.navigationController presentViewController:gesVC animated:YES completion:^{
                    gesVC.resetBtn.hidden = NO;
                    gesVC.btn.hidden = YES;
                    [gesVC resetGes];
                }];
                
            } else {
                OCMLog(@"from-dict");
                [self.navigationController presentViewController:gesVC animated:YES completion:^{
                    gesVC.resetBtn.hidden = NO;
                    gesVC.btn.hidden = YES;
                    [gesVC resetGes];
                }];
            }
//            GestureLoginViewController *gesVC = [[GestureLoginViewController alloc] init];
//            [_dictCache setValue:gesVC forKey:@"GestureLoginViewController"];
//            [self.navigationController presentViewController:gesVC animated:YES completion:^{
//                gesVC.resetBtn.hidden = NO;
//                gesVC.btn.hidden = YES;
//                [gesVC resetGes];
//            }];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *head0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _currentWidth, 50)];
        UILabel *lable0 = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 100, 20)];
        lable0.text = @"打卡设置";
        lable0.textColor = [UIColor colorWithHexString:@"#999999"];
        lable0.font = [UIFont systemFontOfSize:17];
        [head0 addSubview:lable0];
        return head0;
    } else if (section == 1) {
        UIView *head1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _currentWidth, 90)];
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, 100, 20)];
        lable1.text = @"手势设置";
        lable1.textColor = [UIColor colorWithHexString:@"#999999"];
        lable1.font = [UIFont systemFontOfSize:17];
        [head1 addSubview:lable1];
        return head1;
    } else {
        UIView *head2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _currentWidth, 93)];
        UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 58, 100, 20)];
        lable2.text = @"关于";
        lable2.textColor = [UIColor colorWithHexString:@"#999999"];
        lable2.font = [UIFont systemFontOfSize:17];
        [head2 addSubview:lable2];
        return head2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 50;
    } else if (section == 1) {
        return 90;
    } else {
        return 93;
    }
}
#pragma mark -- 点击事件
- (void)clickSwitchBtn:(UISwitch *)sender {
    if (sender.tag == 0) {
        if (sender.on) {
            OCMLog(@"点击了第0个--打开");
        } else {
            OCMLog(@"点击了第0个--关闭");
        }
    } else {
        if (sender.on) {
            OCMLog(@"点击了第1个--打开");
        } else {
            OCMLog(@"点击了第1个--关闭");
        }
    }
}
- (void)clickFingerBtn:(UISwitch *)sender {
    if (sender.tag == 0) {
        if (sender.on) {
            OCMLog(@"clickFingerBtn0个--打开");
        } else {
            OCMLog(@"clickFingerBtn0个--关闭");
        }
    } else {
        if (sender.on) {
            OCMLog(@"clickFingerBtn个--打开");
        } else {
            OCMLog(@"clickFingerBtn个--关闭");
        }
    }
}
- (void)clickSignOut {
    OCMLog(@"clickSignOut");
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"退出登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    __weak typeof(self) weakSelf = self;
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        OCMLog(@"确定退出");
        //token-->清空
        //跳转登录界面
//        MessageLoginViewController *msgLogin = [[MessageLoginViewController alloc] init];
        //        [weakSelf presentViewController:msgLogin animated:YES completion:nil];
        
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app showLoginView];
    }];
    [alertC addAction:cancelAction];
    [alertC addAction:OKAction];
    [self presentViewController:alertC animated:YES completion:nil];
}
#pragma mark -- 退出登录
- (void)addSignOutBtn {
    self.signOutBtn = [[UIButton alloc] init];
    [self.view addSubview:self.signOutBtn];
    
    __weak typeof(self) weakSelf = self;
    __block CGFloat dis = (screenHeight - 64 - self.tableView.height) * 0.5 - 25;
    [self.signOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.view).offset(-dis);
        make.width.mas_equalTo(430);
        make.height.mas_equalTo(50);
    }];
    ViewBorder(self.signOutBtn, 0, [UIColor clearColor], 5);
    self.signOutBtn.backgroundColor = [UIColor colorWithHexString:@"#009dec"];
    [self.signOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.signOutBtn addTarget:self action:@selector(clickSignOut) forControlEvents:UIControlEventTouchUpInside];
    [self.signOutBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor greenColor]] forState:UIControlStateHighlighted];
}
//- (NSDictionary *)dictCache {
//    if (!_dictCache) {
//        _dictCache = [NSDictionary dictionary];
//    }
//    return _dictCache;
//}
#pragma mark -- dealloc
- (void)dealloc {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
