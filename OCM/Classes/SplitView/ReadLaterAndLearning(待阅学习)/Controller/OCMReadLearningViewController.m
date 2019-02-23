//
//  OCMReadLearningViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/1.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMReadLearningViewController.h"
#import "OCMPersonalTableViewCell.h"

@interface OCMReadLearningViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *nameView;
@property (nonatomic, assign) NSInteger selectedTag;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIView *sepView;
@property (nonatomic, assign) CGFloat w;

//暂时的UI添加
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tempArr;
@end

@implementation OCMReadLearningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"待阅学习";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
- (void)setSubViews:(CGFloat)w {
    if (_nameView.subviews) {
        [_nameView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    if (self.view.subviews) {
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    _nameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w - 50, 44)];
    _nameView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = _nameView;
    
    CGFloat w1 = 120;
    CGFloat h = 44;
    CGFloat w2 = w - 50;
    NSArray *nameArr = @[@"渠道政策",@"早会概要",@"个人进度"];
    CGFloat x = 0.;
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        x = (1.0/3 * w2) * i + (1.0/3 * w2) * 0.5 - w1 * 0.5;
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
    _sepView = [[UIView alloc] initWithFrame:CGRectMake((1.0/3 * w2) * _selectedTag + (1.0/3 * w2) * 0.5 - w1 * 0.5, 42, w1, 2)];
    _sepView.backgroundColor = [UIColor whiteColor];
    [_nameView addSubview:_sepView];
    
    UIImageView *imgeView = [[UIImageView alloc] initWithImage:ImageIs(@"noInfo")];
    imgeView.centerY = self.view.centerY;
    imgeView.centerX = w * 0.5;
    [self.view addSubview:imgeView];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithHexString:@"e5e5e5"];
    label.text = @"暂无相关信息";
    label.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgeView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(imgeView.mas_centerX).offset(10);
        make.size.mas_equalTo(CGSizeMake(171, 28));
    }];
    
    [self addTableView:w];//添加tableView
}
- (void)addTableView:(CGFloat)w {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 64, w - 20, screenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tempArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"";
    OCMPersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[OCMPersonalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.titleLabel.text = @"2017社会营销政策详解";
    cell.nameLabel.text = @"陈晓峰";
    cell.timeLabel.text = @"2017-06-15 12:30";
    cell.detailLabel.text = self.tempArr[indexPath.section];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    tableView.sectionHeaderHeight = (section == 0 ? 10 : 0);
//    return tableView.sectionHeaderHeight;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    tableView.sectionFooterHeight = (section == 0 ? 20 : 4);
//    return tableView.sectionFooterHeight;
//}

#pragma mark -- 点击事件
- (void)clickBtn:(UIButton *)sender {
    NSInteger tag = sender.tag;
    _selectedTag = tag;
    _selectedBtn.selected = NO;
    sender.selected = YES;
    _selectedBtn = sender;
    CGFloat w1 = 120;
    [UIView animateWithDuration:0.5 animations:^{
        _sepView.frame = CGRectMake((1.0/3 * (_w - 50)) * _selectedTag + (1.0/3 * (_w - 50)) * 0.5 - w1 * 0.5, 42, w1, 2);
    }];
}
#pragma mark -- data
- (NSArray *)tempArr {
    if (!_tempArr) {
        _tempArr = @[@"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创     造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创     造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创     造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创     造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创     造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创造......",
                     @"当下无论是企业人力资源管理对岗位及员工的价值评价,还是企业文化的升级导向,还是组织变革的指向,都强调来自于市场认可和客户价值的创造......"];
    }
    return _tempArr;
}
#pragma mark -- dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
