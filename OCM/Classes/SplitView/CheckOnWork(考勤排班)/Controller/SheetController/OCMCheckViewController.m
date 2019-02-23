//
//  OCMCheckViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/5/11.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMCheckViewController.h"
#import "OCMCheckWorkItem.h"
#import "OCMCheckWorkTableViewCell.h"

@interface OCMCheckViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView           *tableView;
@end

@implementation OCMCheckViewController
#define KWidth              400
#define KHeight             400
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.view.frame           = CGRectMake(0, 0, KWidth, KHeight);
    [self setNavi];
    [self configTableView];
}
- (void)configTableView {
    self.tableView              = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, KWidth, KHeight) style:UITableViewStylePlain];
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
    [self.view addSubview:self.tableView];
}
- (void)setNavi {
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    UILabel *titleL                        = [[UILabel alloc] init];
    titleL.text                            = @"申报详情";
    titleL.textColor                       = [UIColor colorWithHexString:@"333333"];
    titleL.font                            = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView          = titleL;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}
#pragma mark -- 点击事件
- (void)dismiss {
    self.dismissBlock();
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDCell = @"cell";
    OCMCheckWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!cell) {
        cell = [[OCMCheckWorkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
    }
    OCMCheckWorkItem *item = [OCMCheckWorkItem mj_objectWithKeyValues:self.dataSourceArr[indexPath.row]];
    cell.checkItem         = item;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}
#pragma mark -- dealloc
- (void)dealloc {
    OCMLog(@"ocmcheckvc -- 释放");
}
#pragma mark -- data
- (NSMutableArray *)dataSourceArr {
    if (!_dataSourceArr) {
        NSArray *tempArr = [NSArray arrayWithObjects:@{
                                                       @"arrangeStr":       @"班次1",
                                                       @"beginTimeStr":     @"08:30",
                                                       @"endTimeStr":       @"12:00",
                                                       @"imgType":          @1,
                                                       @"workTypeName":     @"外出走访(政策宣传)",
                                                       @"isBeginNormal":    @NO,
                                                       @"isEndNormal":      @YES,
                                                       @"stateUpStr":       @"正常",
                                                       @"stateDownStr":     @"正常",
                                                       @"checkUpStr":       @"已通过",
                                                       @"checkDownStr":     @"已通过"
                                                       },
                                                    @{
                                                      @"arrangeStr":       @"班次2",
                                                      @"beginTimeStr":     @"14:30",
                                                      @"endTimeStr":       @"16:00",
                                                      @"imgType":          @2,
                                                      @"workTypeName":     @"休假(无)",
                                                      @"isBeginNormal":    @YES,
                                                      @"isEndNormal":      @NO,
                                                      @"stateUpStr":       @"正常",
                                                      @"stateDownStr":     @"正常",
                                                      @"checkUpStr":       @"",
                                                      @"checkDownStr":     @"已审核"
                                                      },
                                                    @{
                                                      @"arrangeStr":       @"班次3",
                                                      @"beginTimeStr":     @"18:30",
                                                      @"endTimeStr":       @"20:00",
                                                      @"imgType":          @3,
                                                      @"workTypeName":     @"后台办公(电脑办公)",
                                                      @"isBeginNormal":    @NO,
                                                      @"isEndNormal":      @NO,
                                                      @"stateUpStr":       @"正常",
                                                      @"stateDownStr":     @"异常",
                                                      @"checkUpStr":       @"待审批",
                                                      @"checkDownStr":     @"待审核"
                                                      },
                            nil
                            ];
        _dataSourceArr = [NSMutableArray arrayWithArray:tempArr];
    }
    return _dataSourceArr;
}
@end
