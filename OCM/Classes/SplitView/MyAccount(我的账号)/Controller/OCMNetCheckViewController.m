//
//  OCMNetCheckViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/27.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMNetCheckViewController.h"
#import "OCMSearchBar.h"
#import "CFDynamicLabel.h"
#import "GrayMidView.h"
#import "OCMNetSearchTableViewCell.h"

@interface OCMNetCheckViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton *btnStar;
@property (nonatomic, strong) CFDynamicLabel *starLabel;
@property (nonatomic, strong) UIButton *btnTown;
@property (nonatomic, strong) CFDynamicLabel *townLabel;
@property (nonatomic, strong) UIButton *btnNet;
@property (nonatomic, strong) CFDynamicLabel *netLabel;
@property (nonatomic, strong) UIButton *btnChannel;
@property (nonatomic, strong) CFDynamicLabel *channelLabel;
@property (nonatomic, strong) OCMSearchBar *ocmSearchBar;
/*灰色view*/
@property (nonatomic, strong) UIView *grayView;
/*tableView相关*/
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation OCMNetCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"网点查询";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNotify];
    [self setUpUI];
}
- (void)setUpUI {
    if (self.isBigLeftWidth) {
        CGFloat width = screenWidth - kLeftBigWidth;
        [self config:width];
    } else {
        CGFloat width = screenWidth - kLeftSmallWidth;
        [self config:width];
    }
}
- (void)addNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRightWidth) name:NswipeLeftGes object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLeftWidth) name:NswipeRightGes object:nil];
}
- (void)setLeftWidth {
    self.isBigLeftWidth = YES;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self setUpUI];
}
- (void)setRightWidth {
    self.isBigLeftWidth = NO;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self setUpUI];
}
- (void)config:(CGFloat)width {
    [self configTop:width];
    [self addGrayView:width];
    [self configTableView:width];
}
- (void)configTableView:(CGFloat)width {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+75+55, width, screenHeight - 64-75-55) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)addGrayView:(CGFloat)width {
    GrayMidView *midV = [[GrayMidView alloc] initWithFrame:CGRectMake(0, 64+75, width, 55)];
    [self.view addSubview:midV];
}
- (void)configTop:(CGFloat)width {
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, width, 75)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"筛选 :";
    label.textColor = [UIColor colorWithHexString:@"#666666"];
    label.font = [UIFont systemFontOfSize:15];
    [view1 addSubview:label];
    
    self.btnStar = [[UIButton alloc] init];
    [self.btnStar.titleLabel setTintColor:[UIColor colorWithHexString:@"009dec"]];
    [view1 addSubview:self.btnStar];
    
    self.btnTown = [[UIButton alloc] init];
    [self.btnTown setTintColor:[UIColor colorWithHexString:@"009dec"]];
    [view1 addSubview:self.btnTown];
    
    self.btnNet = [[UIButton alloc] init];
    [self.btnNet setTintColor:[UIColor colorWithHexString:@"009dec"]];
    [view1 addSubview:self.btnNet];
    
    self.btnChannel = [[UIButton alloc] init];
    [self.btnChannel setTintColor:[UIColor colorWithHexString:@"009dec"]];
    [view1 addSubview:self.btnChannel];
    
    _ocmSearchBar = [[OCMSearchBar alloc] init];//WithFrame:CGRectMake(0, 90, kLeftTopWidth, 38)];
    _ocmSearchBar.contentInset = UIEdgeInsetsMake(6.5, 5, 6.5, 5);
    _ocmSearchBar.delegate = self;
    _ocmSearchBar.placeholder = @"搜索网点编号,名称,联系人,联系方式";
    _ocmSearchBar.barStyle = UISearchBarStyleDefault;
    ViewBorder(_ocmSearchBar, 0, [UIColor clearColor], 3);
    _ocmSearchBar.alpha = 0.7;
    _ocmSearchBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_ocmSearchBar];
    
    CGFloat w = 80;
    CGFloat h = 32;
    CGFloat dis = 15;
    __weak typeof(self) weakSelf = self;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view1.mas_centerY);
        make.left.mas_equalTo(20);
    }];
    [_btnStar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view1.mas_centerY);
        make.left.mas_equalTo(label.mas_right).offset(8);
        make.width.mas_equalTo(w);
        make.height.mas_equalTo(h);
    }];
    [_btnTown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.btnStar.mas_right).offset(dis);
        make.centerY.mas_equalTo(view1.mas_centerY);
        make.width.mas_equalTo(w);
        make.height.mas_equalTo(h);
    }];
    [_btnNet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view1.mas_centerY);
        make.left.mas_equalTo(weakSelf.btnTown.mas_right).offset(dis);
        make.width.mas_equalTo(w);
        make.height.mas_equalTo(h);
    }];
    [_btnChannel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view1.mas_centerY);
        make.left.mas_equalTo(weakSelf.btnNet.mas_right).offset(dis);
        make.width.mas_equalTo(w);
        make.height.mas_equalTo(h);
    }];
    [_ocmSearchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view1.mas_centerY);
        make.right.mas_equalTo(view1.mas_right).offset(-20);
        make.width.mas_equalTo(320);
        make.height.mas_equalTo(40);
    }];
    ViewBorder(self.btnStar, 1, [UIColor colorWithHexString:@"cccccc"], 5);
    ViewBorder(self.btnTown, 1, [UIColor colorWithHexString:@"cccccc"], 5);
    ViewBorder(self.btnNet, 1, [UIColor colorWithHexString:@"cccccc"], 5);
    ViewBorder(self.btnChannel, 1, [UIColor colorWithHexString:@"cccccc"], 5);
    
    self.starLabel = [[CFDynamicLabel alloc] initWithFrame:CGRectMake(15, 8, 35, 20)];
    [_btnStar addSubview:self.starLabel];
    self.starLabel.speed = 0.9;
    self.starLabel.textColor = [UIColor colorWithHexString:@"#009dec"];
    self.starLabel.font = [UIFont systemFontOfSize:14];
    self.starLabel.backgroundColor = [UIColor clearColor];
    self.starLabel.text = @"星级";
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(45, 1, 30, 30)];
    imgV.image = ImageIs(@"xiala");
    [_btnStar addSubview:imgV];
    
    self.townLabel = [[CFDynamicLabel alloc] initWithFrame:CGRectMake(15, 8, 35, 20)];
    [_btnTown addSubview:self.townLabel];
    self.townLabel.speed = 0.9;
    self.townLabel.textColor = [UIColor colorWithHexString:@"#009dec"];
    self.townLabel.font = [UIFont systemFontOfSize:14];
    self.townLabel.backgroundColor = [UIColor clearColor];
    self.townLabel.text = @"镇区";
    UIImageView *imgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(45, 1, 30, 30)];
    imgV1.image = ImageIs(@"xiala");
    [_btnTown addSubview:imgV1];
    
    self.netLabel = [[CFDynamicLabel alloc] initWithFrame:CGRectMake(15, 8, 35, 20)];
    [_btnNet addSubview:self.netLabel];
    self.netLabel.speed = 0.9;
    self.netLabel.textColor = [UIColor colorWithHexString:@"#009dec"];
    self.netLabel.font = [UIFont systemFontOfSize:14];
    self.netLabel.backgroundColor = [UIColor clearColor];
    self.netLabel.text = @"网元";
    UIImageView *imgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(45, 1, 30, 30)];
    imgV2.image = ImageIs(@"xiala");
    [_btnNet addSubview:imgV2];
    
    self.channelLabel = [[CFDynamicLabel alloc] initWithFrame:CGRectMake(15, 8, 35, 20)];
    [_btnChannel addSubview:self.channelLabel];
    self.channelLabel.speed = 0.9;
    self.channelLabel.textColor = [UIColor colorWithHexString:@"#009dec"];
    self.channelLabel.font = [UIFont systemFontOfSize:14];
    self.channelLabel.backgroundColor = [UIColor clearColor];
    self.channelLabel.text = @"渠道";
    UIImageView *imgV3 = [[UIImageView alloc] initWithFrame:CGRectMake(45, 1, 30, 30)];
    imgV3.image = ImageIs(@"xiala");
    [_btnChannel addSubview:imgV3];
}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"OCMNetSearchTableViewCell";
    OCMNetSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[OCMNetSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID width:self.tableView.width];
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
