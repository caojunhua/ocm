//
//  OCMTaskListWorkViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/7.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMTaskListWorkViewController.h"
#import "OCMDetailHistoryTableViewCell.h"
#import "TaskListItem.h"

@interface OCMTaskListWorkViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation OCMTaskListWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self initData];
    
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]init];
    backbutton.title = @"返回列表";
    self.navigationItem.backBarButtonItem = backbutton;
}
- (void)setUpUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth - 200, screenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [self.view addSubview:self.tableView];
}
- (void)initData {
    NSString *str = self.item.title;
    OCMLog(@"str--%@",str);
}
#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
static NSString *ID = @"cell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OCMDetailHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[OCMDetailHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark -- dealloc
- (void)dealloc {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
