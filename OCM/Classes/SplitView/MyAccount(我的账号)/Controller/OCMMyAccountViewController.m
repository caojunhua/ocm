//
//  OCMMyAcountViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/1.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMMyAccountViewController.h"
#import "OCMRemunerationViewController.h"  //量酬
#import "OCMIndicatorViewController.h"     //指标
#import "OCMTaskRateViewController.h"      //任务进度
#import "OCMTaskPathViewController.h"      //任务轨迹
#import "OCMNetCheckViewController.h"      //网点查询
#import "OCMSettingsViewController.h"      //设置


@interface OCMMyAccountViewController ()
@property (nonatomic, strong) UIImageView *headImgV;//头像
@property (nonatomic, strong) UILabel *nameL;//名字

@property (nonatomic, strong) UIView *midView;//中间的部分view
@property (nonatomic, strong) UILabel *userNameL;//用户名
@property (nonatomic, strong) UILabel *jobL;//职位
@property (nonatomic, strong) UILabel *phoneNumberL;//手机号码
@property (nonatomic, strong) UILabel *emailL;//邮箱
@property (nonatomic, strong) UILabel *cityL;//地市
@property (nonatomic, strong) UILabel *countyL;//区县

@property (nonatomic, strong) UIView *bottomView;//底部的view

@property (nonatomic, strong) NSArray *btnImgArr;
@property (nonatomic, strong) NSArray *btnTitleArr;
@property (nonatomic, strong) NSMutableDictionary *vcCacheDict;

@property (nonatomic, assign) BOOL isBigLeft;
@end

@implementation OCMMyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    if (self.isStretch) {
        self.isBigLeft = YES;
        OCMLog(@"isBig==yes");
    } else {
        self.isBigLeft = NO;
        OCMLog(@"isbig==no");
    }
    [self setUpUI];
    [self addNotify];
}
- (void)addNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLeftWidth) name:NswipeLeftGes object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRightWidth) name:NswipeRightGes object:nil];
}
- (void)setLeftWidth {
    self.isBigLeft = NO;
    self.isStretch = NO;
    OCMLog(@"通知-->NO");
}
- (void)setRightWidth {
    self.isBigLeft = YES;
    self.isStretch = YES;
    OCMLog(@"通知-->YES");
}
- (void)setUpUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self seUpTopView];
    [self setUpMidView];
    [self setUpBottomView];
}
- (void)seUpTopView {
    self.headImgV = [[UIImageView alloc] init];
    self.headImgV.image = [UIImage createImageWithColor:[UIColor purpleColor]];
    self.headImgV = [UIImageView createWithImageView:self.headImgV width:95 height:95 BorderWidth:3.0 borderColor:[UIColor colorWithHexString:@"009dec"]];
    [self.view addSubview:self.headImgV];
    
    self.nameL = [UILabel new];
    self.nameL.font = [UIFont boldSystemFontOfSize:20];
    self.nameL.textColor = [UIColor colorWithHexString:@"009dec"];
    self.nameL.text = @"测试人员";
    [self.view addSubview:self.nameL];
    
    __weak typeof(self) weakSelf = self;
    [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(95);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(25 + 64);
    }];
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.headImgV.mas_bottom).offset(8);
        make.height.mas_equalTo(23);
    }];
}
- (void)setUpMidView {
    self.midView = [[UIView alloc] init];
    [self.view addSubview:self.midView];
    
    UILabel *label1 = [UILabel new];//用户名称
    label1.textColor = [UIColor colorWithHexString:@"666666"];
    label1.text = @"用户名称:";
    [self.midView addSubview:label1];
    self.userNameL = [UILabel new];
    self.userNameL.textColor = [UIColor colorWithHexString:@"666666"];
    self.userNameL.text = @"林小如";
    [self.midView addSubview:self.userNameL];

    UILabel *label2 = [UILabel new];//职位
    label2.textColor = [UIColor colorWithHexString:@"666666"];
    label2.text = @"职位:";
    [self.midView addSubview:label2];
    self.jobL = [UILabel new];
    self.jobL.textColor = [UIColor colorWithHexString:@"666666"];
    self.jobL.text = @"渠道经理(中级专员)";
    [self.midView addSubview:self.jobL];

    UILabel *label3 = [UILabel new];//手机号码
    label3.textColor = [UIColor colorWithHexString:@"666666"];
    label3.text = @"手机号码:";
    [self.midView addSubview:label3];
    self.phoneNumberL = [UILabel new];
    self.phoneNumberL.textColor = [UIColor colorWithHexString:@"666666"];
    self.phoneNumberL.text = @"188xxxx8888";
    [self.midView addSubview:self.phoneNumberL];

    UILabel *label4 = [UILabel new];//电子邮箱
    label4.textColor = [UIColor colorWithHexString:@"666666"];
    label4.text = @"电子邮箱:";
    [self.midView addSubview:label4];
    self.emailL = [UILabel new];
    self.emailL.textColor = [UIColor colorWithHexString:@"666666"];
    self.emailL.text = @"example@example.com";
    [self.midView addSubview:self.emailL];

    UILabel *label5 = [UILabel new];//地市
    label5.textColor = [UIColor colorWithHexString:@"666666"];
    label5.text = @"地市:";
    [self.midView addSubview:label5];
    self.cityL = [UILabel new];
    self.cityL.textColor = [UIColor colorWithHexString:@"666666"];
    self.cityL.text = @"东莞分公司";
    [self.midView addSubview:self.cityL];

    UILabel *label6 = [UILabel new];//区县
    label6.textColor = [UIColor colorWithHexString:@"666666"];
    label6.text = @"区县:";
    [self.midView addSubview:label6];
    self.countyL = [UILabel new];
    self.countyL.textColor = [UIColor colorWithHexString:@"666666"];
    self.countyL.text = @"东城区分公司";
    [self.midView addSubview:self.countyL];

    __weak typeof(self) weakSelf = self;
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.nameL.mas_bottom).offset(32);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(650);
        make.height.mas_equalTo(100);
    }];
    CGFloat leftDis = 0;
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftDis);
        make.top.mas_equalTo(0);
    }];
    [self.userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1.mas_right);
        make.top.mas_equalTo(label1);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.midView.mas_centerX).offset(30);
        make.top.mas_equalTo(label1);
    }];
    [self.jobL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label2.mas_right);
        make.top.mas_equalTo(0);
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftDis);
        make.top.mas_equalTo(label1.mas_bottom).mas_offset(16);
    }];
    [self.phoneNumberL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label3.mas_right);
        make.top.mas_equalTo(label3);
    }];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.midView.mas_centerX).offset(30);
        make.top.mas_equalTo(label3);
    }];
    [self.emailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label4.mas_right);
        make.top.mas_equalTo(label4);
    }];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1);
        make.top.mas_equalTo(label3.mas_bottom).offset(16);
    }];
    [self.cityL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label5.mas_right);
        make.top.mas_equalTo(label5);
    }];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.midView.mas_centerX).offset(30);
        make.top.mas_equalTo(label5);
    }];
    [self.countyL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label6.mas_right);
        make.top.mas_equalTo(label6);
    }];
    
}
- (void)setUpBottomView {
    self.bottomView = [UIView new];
    [self.view addSubview:self.bottomView];
    
    __weak typeof(self) weakSelf = self;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.midView.mas_bottom);
        make.width.mas_equalTo(750);
        make.height.mas_equalTo(400);
    }];
    CGFloat btnW = 90;
    CGFloat btnH = 90;
    for (int i = 0; i < 6; i++) {
        UserButton *btn = [[UserButton alloc] initWithFrame:CGRectMake(0, 0, btnW, btnH)];
        [btn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.btnImgArr[i]]] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%@",self.btnTitleArr[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake((i % 3) * 250 + 80, (i / 3) * 200 + 55, btnW, btnH);
        [self.bottomView addSubview:btn];
    }
    for (int i = 0; i < 4; i++) {
        UIView *sepV = [UIView new];
        sepV.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
        CGFloat y = (i / 2) * 200 + 35;
        sepV.frame = CGRectMake((i % 2 + 1) * 250, y, 1, 130);
        [self.bottomView addSubview:sepV];
    }
    for (int i = 0; i < 3; i++) {
        UIView *sepV = [UIView new];
        sepV.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
        CGFloat x = 250 * i + 60;
        sepV.frame = CGRectMake(x, 200, 130, 1);
        [self.bottomView addSubview:sepV];
    }
}
#pragma mark -- 点击事件
- (void)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            OCMLog(@"点击了0");
        {
            OCMRemunerationViewController *remunVC = [[OCMRemunerationViewController alloc] init];
            remunVC.isBigLeftWidth = self.isBigLeft;
            [self.navigationController pushViewController:remunVC animated:YES];
        }
            break;
        case 1:
            OCMLog(@"点击了1");
        {
            OCMIndicatorViewController *indiVC = [[OCMIndicatorViewController alloc] init];
            indiVC.isBigLeftWidth = self.isBigLeft;
            [self.navigationController pushViewController:indiVC animated:YES];
        }
            break;
        case 2:
            OCMLog(@"点击了2");
        {
            OCMTaskRateViewController *rateVC = [[OCMTaskRateViewController alloc] init];
            rateVC.isBigLeftWidth = self.isBigLeft;
            [self.navigationController pushViewController:rateVC animated:YES];
        }
            break;
        case 3:
            OCMLog(@"点击了3");
            {
                OCMTaskPathViewController *pathVC = [[OCMTaskPathViewController alloc] init];
                [self.navigationController pushViewController:pathVC animated:NO];
            }
            break;
        case 4:
            OCMLog(@"点击了4");
            {
                OCMNetCheckViewController *netVC = [[OCMNetCheckViewController alloc] init];
                netVC.isBigLeftWidth = self.isBigLeft;
                [self.navigationController pushViewController:netVC animated:NO]; //暂时不让点击有效果
            }
            break;
        case 5:
            OCMLog(@"点击了5");
            {
                OCMSettingsViewController *settingVC = [[OCMSettingsViewController alloc] init];
                settingVC.isBigLeftWidth = self.isBigLeft;
                [self.navigationController pushViewController:settingVC animated:NO];
            }
            break;
        default:
            break;
    }
}
#pragma mark -- 懒加载
- (NSArray *)btnImgArr {
    if (!_btnImgArr) {
        _btnImgArr = @[@"icon_center_1",@"icon_center_2",@"icon_center_3",@"icon_center_4",@"icon_center_5",@"icon_center_6"];
    }
    return _btnImgArr;
}
- (NSArray *)btnTitleArr {
    if (!_btnTitleArr) {
        _btnTitleArr = @[@"量酬",@"指标",@"任务进度",@"任务轨迹",@"网点信息",@"设置"];
    }
    return _btnTitleArr;
}
- (NSMutableDictionary *)vcCacheDict {
    if (!_vcCacheDict) {
        _vcCacheDict = [NSMutableDictionary dictionary];
    }
    return _vcCacheDict;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
