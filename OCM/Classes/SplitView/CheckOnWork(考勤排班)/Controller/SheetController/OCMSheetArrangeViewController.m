//
//  OCMSheetArrangeViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/4/20.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMSheetArrangeViewController.h"
#import "OCMSheetArrangeSecondViewController.h"
#import "OCMCalendarItem.h"
#import "OCMFormSheetHeaderView.h"
#import "OCMSheetArrangeTableViewCell.h"
#import "OCMSheetArrangeCellItem.h"
#import "OCMCheckResView.h"

@interface OCMSheetArrangeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView          *tableView;
@property (nonatomic, strong) OCMCheckResView      *checkResView1;            //审核结果view
@property (nonatomic, strong) OCMCheckResView      *checkResView2;            //审核结果view
@end

@implementation OCMSheetArrangeViewController
#define kHeight 443
#define kWidth  420
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor             = [UIColor whiteColor];
    self.view.frame                       = CGRectMake(0, 0, kWidth, kHeight);
    
    [self setHeaderView];
    [self config];
}
- (void)setHeaderView {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    UILabel *titleL                       = [[UILabel alloc] init];
    titleL.text                           = @"详情";
    titleL.textColor                      = [UIColor colorWithHexString:@"999999"];
    titleL.font                           = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView         = titleL;
}
- (void)config {
    self.tableView                = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 370) style:UITableViewStylePlain];
    self.tableView.dataSource     = self;
    self.tableView.delegate       = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
//    _tableView.backgroundColor    = [UIColor orangeColor];
    [self addCheckView];
}
- (void)addCheckView {
    CGFloat y                     = CGRectGetMaxY(self.tableView.frame);
    self.checkResView1            = [[OCMCheckResView alloc] initWithFrame:CGRectMake(0, y + 10, kWidth, 50)];
    self.checkResView2            = [[OCMCheckResView alloc] initWithFrame:CGRectMake(0, y + 60, kWidth, 50)];
    [self.view addSubview:self.checkResView1];
    [self.view addSubview:self.checkResView2];
}
#pragma mark -- 点击事件
- (void)nextVC {
    [self.navigationController pushViewController:[[OCMSheetArrangeSecondViewController alloc] init] animated:YES];
}
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrangeArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID            = @"cellID";
    OCMSheetArrangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[OCMSheetArrangeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    OCMSheetArrangeCellItem *item = [[OCMSheetArrangeCellItem alloc] init];
    item.arrangeNumber            = indexPath.row;
    item.timeStr                  = self.arrangeArr[indexPath.row][0];
    item.iconType                 = [self.arrangeArr[indexPath.row][1] integerValue];
    item.today                    = [NSString stringWithFormat:@"%ld-%02ld-%02ld",
                                     self.calendarItem.year,self.calendarItem.month,[self.calendarItem.day integerValue]];
    cell.item                     = item;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    OCMFormSheetHeaderView *view = [[OCMFormSheetHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    view.dateLabel.text          = [NSString stringWithFormat:@"%ld-%02ld-%02ld",
                                    self.calendarItem.year,self.calendarItem.month,[self.calendarItem.day integerValue]];
    switch (self.calendarItem.textColor) {
        case 0:
            view.statusLabel.text      = [NSString stringWithFormat:@"(通过)"];
            view.statusLabel.textColor = KBlueColor;
            break;
        case 1:
            view.statusLabel.text      = [NSString stringWithFormat:@"(未审核)"];
            view.statusLabel.textColor = KOrangeColor;
            break;
        case 2:
            view.statusLabel.text      = [NSString stringWithFormat:@"(不通过)"];
            break;
        default:
            break;
    }
    view.realityTimeL.text             = [self caculateTotalTime];
    return view;
}
#pragma mark -- data
- (void)setCalendarItem:(OCMCalendarItem *)calendarItem {
    _calendarItem                     = calendarItem;
    _arrangeArr                       = calendarItem.arrangeInToday;
    [self.tableView reloadData];
}
- (NSString *)caculateTotalTime {
    NSString         *today           = [NSString stringWithFormat:@"%ld-%02ld-%02ld",
                                         self.calendarItem.year,self.calendarItem.month,[self.calendarItem.day integerValue]];
    NSArray          *arr1            = self.calendarItem.arrangeInToday;
    NSMutableArray *arr2              = [NSMutableArray array];
    for (NSArray *tempArr in arr1) {
        NSString     *timeStr         = tempArr[0];
        NSArray      *arr3            = [timeStr componentsSeparatedByString:@"-"];
        NSString     *timeStr1        = [NSString stringWithFormat:@"%@ %@:00",today,arr3[0]];
        NSInteger    timeInt1         = [OCMDate timeSwitchTimestamp:timeStr1 andFormatter:@"YYYY-MM-dd HH:mm:ss"];
        NSString     *timeStr2        = [NSString stringWithFormat:@"%@ %@:00",today,arr3[1]];
        NSInteger    timeInt2         = [OCMDate timeSwitchTimestamp:timeStr2 andFormatter:@"YYYY-MM-dd HH:mm:ss"];
        NSInteger    detalTime        = timeInt2 - timeInt1;
        [arr2 addObject:@(detalTime)];
    }
    NSInteger totalTime               = 0;
    for (NSNumber *time in arr2) {
        totalTime                     += [time integerValue];
    }
    CGFloat res                       = totalTime / 3600.f;
    return [NSString stringWithFormat:@"%0.2f",res];
}
#pragma mark -- lazyInit
- (NSMutableArray *)iconArr {
    if (!_iconArr) {
        _iconArr = [NSMutableArray array];
    }
    return _iconArr;
}
#pragma mark -- dealloc
- (void)dealloc {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
