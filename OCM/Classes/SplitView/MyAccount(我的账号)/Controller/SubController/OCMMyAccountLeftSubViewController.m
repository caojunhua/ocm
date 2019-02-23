//
//  OCMHomeLeftSubViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/1.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMMyAccountLeftSubViewController.h"
#import "OCMMasterViewController.h"

@interface OCMMyAccountLeftSubViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listArr;
@end

@implementation OCMMyAccountLeftSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self config];
}
- (void)config {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 200, self.view.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.listArr[indexPath.row];
    return cell;
}
#pragma mark -- data
- (NSArray *)listArr {
    if (!_listArr) {
        _listArr = @[@"任务清单",@"基础信息",@"业务发展",@"酬金账单",@"业务质量",@"走访记录",@"异动预警"];
    }
    return _listArr;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    OCMLog(@"viewWill");
    [self.navigationController.navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == 100) {
            obj.hidden = NO;
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
