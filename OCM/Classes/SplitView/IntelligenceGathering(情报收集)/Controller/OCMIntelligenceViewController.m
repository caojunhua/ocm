//
//  OCMIntelligenceViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/1.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMIntelligenceViewController.h"
#import "OCMInfoGetTableViewCell.h"

@interface OCMIntelligenceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *nameArr;
@property (nonatomic, strong) NSArray *arr1;
@end

@implementation OCMIntelligenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"信息采集";
    [self setUpUI];
}
- (void)setUpUI {
    self.view.backgroundColor = [UIColor whiteColor];
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
    if (self.view.subviews) {
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, w, 500) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nameArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"OCMInfoGetTableViewCell";
    OCMInfoGetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[OCMInfoGetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.label1.text = self.nameArr[indexPath.row];
    cell.label2.text = self.arr1[indexPath.row];
    cell.label2.hidden = NO;
    if (indexPath.row == 5) {
        cell.annoView.hidden = NO;
    }
    if (indexPath.row == 7) {
        cell.switchBtn.hidden = NO;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
#pragma mark -- data
- (NSArray *)nameArr {
    if (!_nameArr) {
        _nameArr = @[@"类型",@"名称",@"内容",@"经纬度",@"地址",@"图标",@"风格",@"是否显示地图",@"名称位置",@"归属人员",@"状态"];
    }
    return _nameArr;
}
- (NSArray *)arr1 {
    if (!_arr1) {
        _arr1 = @[@"竞争情报",@"信息采集",@"同款手机",@"经度:23.057732 纬度:113.405640",@"广东省广州市番禺区大学城内环东路",@"",@"显示名称",@"",@"自动",@"采集人",@"正常"];
    }
    return _arr1;
}
#pragma mark -- dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
