//
//  OCMMonitoringViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/1.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMMonitoringViewController.h"
#import "OCMButton.h"
#import "OCMMonitorTableViewCell.h"
#import "OCMSearchBar.h"

@interface OCMMonitoringViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;

@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OCMSearchBar *ocmSearchBar;
@end

@implementation OCMMonitoringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"监控预警";
    if (self.isStretch) {
        [self addTableView:screenWidth - kLeftBigWidth];
    } else {
        [self addTableView:screenWidth - kLeftSmallWidth];
    }
    [self addNotify];
}
- (void)addNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLeftWidth) name:NswipeLeftGes object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRightWidth) name:NswipeRightGes object:nil];
}
- (void)setLeftWidth {
    [self addTableView:screenWidth - kLeftSmallWidth];
}
- (void)setRightWidth {
    [self addTableView:screenWidth - kLeftBigWidth];
}
- (void)addTableView:(CGFloat)w {
    if (self.view.subviews) {
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    __weak typeof(self) weakSelf = self;
    CGRect rect = CGRectMake(0, 193, w, screenHeight - 193);
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, w, 121)];
    [self.view addSubview:_view2];
    _view2.backgroundColor = [UIColor whiteColor];
    _ocmSearchBar = [[OCMSearchBar alloc] init];
    _ocmSearchBar.placeholder = @"搜索预警信息";
    UITextField *searchField=[_ocmSearchBar valueForKey:@"_searchField"];
    searchField.backgroundColor = [UIColor RGBColorWithRed:247 withGreen:247 withBlue:247 withAlpha:1.0];
    [_view2 addSubview:_ocmSearchBar];
    [_ocmSearchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(weakSelf.view2.mas_right).offset(-25);
        make.width.mas_equalTo(315);
        make.height.mas_equalTo(40);
    }];
    
    _label1 = [[UILabel alloc] init];
    _label1.text = @"终端常规异常总计 : 20";
    [_view2 addSubview:_label1];
    _label2.font = [UIFont systemFontOfSize:15];
    _label1.textColor = [UIColor colorWithHexString:@"333333"];
    
    _label2 = [[UILabel alloc] init];
    _label2.text = @"白色预警 : 4";
    [_view2 addSubview:_label2];
    _label2.font = [UIFont systemFontOfSize:14];
    _label2.textColor = [UIColor colorWithHexString:@"009dec"];
    
    _label3 = [[UILabel alloc] init];
    _label3.text = @"红色预警 : 4";
    [_view2 addSubview:_label3];
    _label3.font = [UIFont systemFontOfSize:14];
    _label3.textColor = [UIColor colorWithHexString:@"f64b30"];
    
    _label4 = [[UILabel alloc] init];
    _label4.text = @"黄色预警 : 4";
    [_view2 addSubview:_label4];
    _label4.font = [UIFont systemFontOfSize:14];
    _label4.textColor = [UIColor colorWithHexString:@"eea338"];
    
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(185, 20));
    }];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(weakSelf.label1.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(110, 20));
    }];
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.label2.mas_right);
        make.top.mas_equalTo(weakSelf.label2.mas_top);
        make.size.mas_equalTo(CGSizeMake(110, 20));
    }];
    [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.label3.mas_right);
        make.top.mas_equalTo(weakSelf.label3.mas_top);
        make.size.mas_equalTo(CGSizeMake(110, 20));
    }];
    [self addTypeView:w];
}
- (void)addTypeView:(CGFloat)width {
    UIView *typeView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, width, 50)];
    typeView.backgroundColor = [UIColor RGBColorWithRed:247 withGreen:247 withBlue:247 withAlpha:1.0];
    [self.view2 addSubview:typeView];
    UIView *sep1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
    sep1.backgroundColor = [UIColor RGBColorWithRed:234 withGreen:234 withBlue:234 withAlpha:1];
    [typeView addSubview:sep1];
    UIView *sep2 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, width, 1)];
    sep2.backgroundColor = [UIColor RGBColorWithRed:234 withGreen:234 withBlue:234 withAlpha:1];
    [typeView addSubview:sep2];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    [typeView addSubview:label1];
    label1.textColor = [UIColor colorWithHexString:@"666666"];
    label1.text = @"预警业务";
    
    UILabel *label2 = [[UILabel alloc] init];
    [typeView addSubview:label2];
    label2.textColor = [UIColor colorWithHexString:@"666666"];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"预警级别";
    
    UILabel *label3 = [[UILabel alloc] init];
    [typeView addSubview:label3];
    label3.textColor = [UIColor colorWithHexString:@"666666"];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = @"发生时间";
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.textColor = [UIColor colorWithHexString:@"666666"];
    label4.textAlignment = NSTextAlignmentCenter;
    [typeView addSubview:label4];
    label4.text = @"网点编码";
    
    UILabel *label5 = [[UILabel alloc] init];
    [typeView addSubview:label5];
    label5.textColor = [UIColor colorWithHexString:@"666666"];
    label5.textAlignment = NSTextAlignmentCenter;
    label5.text = @"网点名称";
    CGFloat w = 105;
    CGFloat h = 20;
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(w, h));
        make.left.mas_equalTo(25);
        make.centerY.mas_equalTo(typeView.mas_centerY);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(w, h));
        make.left.mas_equalTo(label1.mas_right);
        make.centerY.mas_equalTo(typeView.mas_centerY);
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(w, h));
        make.left.mas_equalTo(label2.mas_right);
        make.centerY.mas_equalTo(typeView.mas_centerY);
    }];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(w, h));
        make.centerY.mas_equalTo(typeView.mas_centerY);
        make.centerX.mas_equalTo(typeView.mas_centerX);
    }];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label4.mas_right);
        make.right.mas_equalTo(typeView.mas_right);
        make.height.mas_equalTo(h);
        make.centerY.mas_equalTo(typeView.mas_centerY);
    }];
    
}
#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"OCMMonitorTableViewCell";
    OCMMonitorTableViewCell *cell = [[OCMMonitorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    if (!cell) {
        cell = [[OCMMonitorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.label1.text = @"常规终端预警";
    cell.label2.text = @"橙色";
    cell.label3.text = @"2017-05-06";
    cell.label4.text = @"QD78945";
    cell.label5.text = @"南城长岭路指定专营店";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
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
