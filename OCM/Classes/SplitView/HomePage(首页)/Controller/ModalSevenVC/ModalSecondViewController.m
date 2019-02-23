//
//  ModalSecondViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/3/12.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "ModalSecondViewController.h"
#import "OCMMoreDetailInfoHeadView.h"
#import "ModalSecondMidView.h"
#import "rightMidDetailItem.h"

@interface ModalSecondViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) OCMMoreDetailInfoHeadView *headV;
@property (nonatomic, strong) UIButton *checkBtn;                               //网点考核
@property (nonatomic, strong) UIButton *VIBtn;                                  //更新门头VI
@property (nonatomic, strong) UIButton *pictureBtn;                             //更新照片
@property (nonatomic, strong) UIButton *locationBtn;                            //更新位置
@property (nonatomic, strong) UIScrollView *scrollView;                         //展示图片的scrollView
@property (nonatomic, strong) ModalSecondMidView *midView;                      //中间展示网点信息详情view
@property (nonatomic, strong) UIView *firstFooterView;                            //
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ModalSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor]; //基础信息
    [self LayoutUI];
}
- (void)LayoutUI {
    [self config];
    [self addImgScrollV:7];
    [self addQDLabel];
    [self addMidView];
    [self configTableView];
}
- (void)config {
    CGFloat w = screenWidth - kLeftBigWidth;
    OCMMoreDetailInfoHeadView *headV = [[OCMMoreDetailInfoHeadView alloc] initWithFrame:CGRectMake(0, 0, w, 177)];
    [self.view addSubview:headV];
    _headV = headV;
    [_headV.netCheckBtn setHidden:YES];
    [_headV.signBtn setTitle:@"网点考核" forState:UIControlStateNormal];
    [_headV.signBtn setTintColor:[UIColor colorWithHexString:@"009dec"]];
    [_headV.signBtn.layer setBorderColor:[UIColor colorWithHexString:@"009dec"].CGColor];
    //增加分割线以及3个按钮
    UIView *bottomV = [[UIView alloc] initWithFrame:CGRectMake(0, 177, w, 37)];
    bottomV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomV];
    
    UIView *sepV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 1)];
    sepV.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    [bottomV addSubview:sepV];
    
    _VIBtn = [[UIButton alloc] init];
    [_VIBtn setTitle:@"更新门头VI" forState:UIControlStateNormal];
    ViewBorder(_VIBtn, 1, [UIColor colorWithHexString:@"009dec"], 5);
    [_VIBtn setTitleColor:[UIColor colorWithHexString:@"009dec"] forState:UIControlStateNormal];
    [_VIBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [bottomV addSubview:_VIBtn];
    
    _pictureBtn = [[UIButton alloc] init];
    [_pictureBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [_pictureBtn setTitleColor:[UIColor colorWithHexString:@"009dec"] forState:UIControlStateNormal];
    [_pictureBtn setTitle:@"更新照片" forState:UIControlStateNormal];
    ViewBorder(_pictureBtn, 1, [UIColor colorWithHexString:@"009dec"], 5);
    [bottomV addSubview:_pictureBtn];
    
    _locationBtn = [[UIButton alloc] init];
    [_locationBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [_locationBtn setTitleColor:[UIColor colorWithHexString:@"009dec"] forState:UIControlStateNormal];
    [_locationBtn setTitle:@"更新位置" forState:UIControlStateNormal];
    ViewBorder(_locationBtn, 1, [UIColor colorWithHexString:@"009dec"], 5);
    [bottomV addSubview:_locationBtn];
    
    __weak typeof(self) weakSelf = self;
    [_VIBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(sepV.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(bottomV.mas_right).offset(-20);
    }];
    [_pictureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(sepV.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(weakSelf.VIBtn.mas_left).offset(-20);
    }];
    [_locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(sepV.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(weakSelf.pictureBtn.mas_left).offset(-20);
    }];
}
- (void)addImgScrollV:(NSInteger)imgCounts {
    CGFloat w = screenWidth - kLeftBigWidth;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 214, w, 163)];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    [self.view addSubview:self.scrollView];
    
    CGFloat width;
    if ((int)imgCounts <= 1) {
        width = 185;
    } else {
        width = 185 * imgCounts + 20;
    }
    self.scrollView.contentSize = CGSizeMake(width, 80);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i < imgCounts; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(185 * i + 10, 20, 175, 125)];
        imageV.image = [UIImage createImageWithColor:[UIColor randomColor]];
        [self.scrollView addSubview:imageV];
        imageV.tag = i;
        ViewBorder(imageV, 0, [UIColor clearColor], 5);
    }
}
- (void)addQDLabel {
//    CGFloat y = CGRectGetMaxY(self.scrollView.frame);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth - kLeftBigWidth, 25)];
    _firstFooterView = view;
    view.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 90, 15)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"渠道信息概况";
    label.textColor = [UIColor colorWithHexString:@"999999"];
    [view addSubview:label];
}
- (void)addMidView {
//    CGFloat y = CGRectGetMaxY(self.scrollView.frame) + 25;
    self.midView = [[ModalSecondMidView alloc] initWithFrame:CGRectMake(0, 0, screenWidth - kLeftBigWidth, 188)];
//    [self.view addSubview:self.midView];
}
- (void)configTableView {
    CGFloat y = CGRectGetMaxY(self.scrollView.frame);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, screenWidth - kLeftBigWidth, screenHeight - y) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 10;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, screenWidth - kLeftBigWidth, 188)];
        [cell addSubview:self.midView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        static NSString *ID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 188;
    } else {
        return 50;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return _firstFooterView;
    } else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth - kLeftBigWidth, 45)];
        view.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, 70, 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"网友评论";
        label.textColor = [UIColor colorWithHexString:@"999999"];
        [view addSubview:label];
        return view;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 25;
    } else {
        return 35;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
