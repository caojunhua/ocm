//
//  OCMRightBottomSecondViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/20.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMRightBottomSecondViewController.h"
#import "OCMNearbyNetTableViewCell.h"

@interface OCMRightBottomSecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)  UITableView    *tableView;
@property (nonatomic,copy)    NSIndexPath    *curIndexPath;
@property (nonatomic,strong ) NSMutableArray *isSignArr;
@end

@implementation OCMRightBottomSecondViewController

static NSString *cellID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, kRightBottomWidth, kRightBottomHeight - 40);
    [self  addTableView];
    [self addData];
}
- (void)addData {
    _isSignArr = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
}
- (void)addTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OCMNearbyNetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[OCMNearbyNetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleL.text = @"常平-木伦网元";
    cell.detailL.text = [NSString stringWithFormat:@"常平--%ldxxx指定网元",indexPath.row];
    cell.numberL.text = [NSString stringWithFormat:@"编号--%ld",indexPath.row];
    cell.distanceL.text = [NSString stringWithFormat:@"(距离%.2f千米)",indexPath.row * 0.4];
    if ([_isSignArr[indexPath.row] isEqualToString:@"0"]) {
        [cell.signBtn setTitle:@"签到" forState:UIControlStateNormal];
        cell.signBtn.backgroundColor = [UIColor colorWithHexString:@"#009dec"];
    } else {
        [cell.signBtn setTitle:@"已签到" forState:UIControlStateNormal];
        cell.signBtn.backgroundColor = [UIColor colorWithHexString:@"#b7b7b7"];
//        cell.signBtn.userInteractionEnabled = NO;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OCMLog(@"点击了-- %ld行", indexPath.row);
    OCMNearbyNetTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    _curIndexPath = indexPath;
    [cell.warningBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.checkBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.taskBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.signBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -- 按钮点击事件
- (void)clickBtn:(UIButton *)sender {
    OCMLog(@"点击的indexPath--%ld", _curIndexPath.row);
    OCMNearbyNetTableViewCell *cell = [_tableView cellForRowAtIndexPath:_curIndexPath];
    switch (sender.tag) {
        case 1:
            OCMLog(@"1--预警");
            break;
        case 2:
            OCMLog(@"2--考核");
            break;
        case 3:
            OCMLog(@"3--任务");
            break;
        case 4:
            OCMLog(@"4--签到");
            if ([_isSignArr[_curIndexPath.row] isEqualToString:@"0"] && _curIndexPath.row * 0.4 <= 1.2) {
                [cell.signBtn setTitle:@"已签到" forState:UIControlStateNormal];
                cell.signBtn.backgroundColor = [UIColor colorWithHexString:@"#b7b7b7"];
                [_isSignArr replaceObjectAtIndex:_curIndexPath.row withObject:@"1"];
                [self.tableView reloadData];
            } else if (([_isSignArr[_curIndexPath.row] isEqualToString:@"0"] && _curIndexPath.row * 0.4 > 1.2)) {
                OCMLog(@"不能签到,太远了");
            } else {
                OCMLog(@"不能签到,已经签过了");
            }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
