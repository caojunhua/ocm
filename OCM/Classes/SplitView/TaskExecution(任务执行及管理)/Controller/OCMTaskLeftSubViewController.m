//
//  OCMTaskLeftSubViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/1.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMTaskLeftSubViewController.h"

@interface OCMTaskLeftSubViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,strong)NSArray *imgArr;
@property (nonatomic,strong)NSArray *selectImgArr;
@property (nonatomic,strong)UITableViewCell *selcetedCell;
@end

@implementation OCMTaskLeftSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
    [self setUpUI];
    [self initData];
    [self setDefaultSelectedCell];
}
- (void)initData {
    self.titleArr = @[@"任务清单",@"计划任务",@"开始任务",@"历史任务"];
    self.imgArr = @[@"taskList",@"planTask",@"startTask",@"historyTask"];
    self.selectImgArr = @[@"taskList-history",@"planTask-selected",@"startTask-selected",@"historyTask-selected"];
}
- (void)setUpUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200, self.view.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [self.view addSubview:self.tableView];
}
- (void)setDefaultSelectedCell {
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:indexP animated:YES scrollPosition:0];
    [self tableView:self.tableView didSelectRowAtIndexPath:indexP];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexP];
    cell.selected = YES;
    _selcetedCell = cell;
}
#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArr.count;
}
static NSString *ID = @"cell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.textLabel.text = _titleArr[indexPath.row];
    cell.tag = indexPath.row;
    if (cell.isSelected) {
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_selectImgArr[indexPath.row]]];
    } else {
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_imgArr[indexPath.row]]];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selcetedCell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_imgArr[_selcetedCell.tag]]];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = YES;
    _selcetedCell = cell;
    _selcetedCell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_selectImgArr[indexPath.row]]];
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return nil;
//}
#pragma mark -- dealloc
- (void)dealloc {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
