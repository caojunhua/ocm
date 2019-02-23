//
//  BaseFiltrationViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/3/19.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "BaseFiltrationViewController.h"
#import "FiltrationTableViewCell.h"

@interface BaseFiltrationViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseFiltrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 36, 290, 185);
    [self config];
    [self initTitle];
//    self.view.alpha = 0.75;
    self.seletedIndexArr = [NSMutableArray new];
}
- (void)config {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 290, 150) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 150, 290./2, 35)];
    self.resetBtn.backgroundColor = [UIColor whiteColor];
    [self.resetBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.resetBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:self.resetBtn];
    [self.resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [self.resetBtn addTarget:self action:@selector(clickRest) forControlEvents:UIControlEventTouchUpInside];
    
    self.sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(290./2, 150, 290./2, 35)];
    [self.view addSubview:self.sureBtn];
    [self.sureBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [self.sureBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    self.sureBtn.backgroundColor = [UIColor colorWithHexString:@"009dec"];
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureBtn addTarget:self action:@selector(clickSure) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -- 点击事件
- (void)clickRest {
    [self.seletedIndexArr removeAllObjects];
    [self.tableView reloadData];
}
- (void)clickSure {
    OCMLog(@"父类的");
    self.hiddenBlock(self.seletedIndexArr);
}
#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FiltrationTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell.imgView.hidden == NO) {
        cell.imgView.hidden = YES;
        [cell.textLabel setTextColor:[UIColor blackColor]];
        [self.seletedIndexArr removeObject:indexPath];
    } else {
        cell.imgView.hidden = NO;
        [cell.textLabel setTextColor:[UIColor colorWithHexString:@"009dec"]];
        [self.seletedIndexArr addObject:indexPath];
    }
}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"cell";
    FiltrationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[FiltrationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
//    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.imgView.hidden = YES;
    [cell.textLabel setTextColor:[UIColor blackColor]];
    for (NSIndexPath *index in self.seletedIndexArr) {
        if (indexPath == index) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.imgView.hidden = NO;
            [cell.textLabel setTextColor:[UIColor colorWithHexString:@"009dec"]];
            break;
        }
    }
    return cell;
}
- (void)initTitle {
    
}
@end
