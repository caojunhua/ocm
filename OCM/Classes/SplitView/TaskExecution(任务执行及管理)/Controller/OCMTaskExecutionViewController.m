//
//  OCMTaskExecutionViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/1.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMTaskExecutionViewController.h"
#import "OCMTaskListTableViewCell.h"
#import "TaskListItem.h"
#import "OCMTaskListWorkViewController.h"

@interface OCMTaskExecutionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)OCMTaskListTableViewCell *taskListCell;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *testDataArr;
@property (nonatomic,assign)CGFloat currentWidth;
@end

@implementation OCMTaskExecutionViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpUI];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"任务执行及管理";
    [self initData];
    [self setNotification];
    _currentWidth = screenWidth - kLeftBigWidth;
}
- (void)setNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetLeft) name:NswipeLeftGes object:nil];//向左
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetRight) name:NswipeRightGes object:nil];//向右
}
- (void)resetLeft {
    if (!(_currentWidth == screenWidth - kLeftSmallWidth)) {
        _currentWidth = screenWidth - kLeftSmallWidth;
        [self setUpUI];
    }
}
- (void)resetRight {
    if (!(_currentWidth == screenWidth - kLeftBigWidth)) {
        _currentWidth = screenWidth - kLeftBigWidth;
        [self setUpUI];
    }
}
- (void)setUpUI {
    NSMutableArray<UIView*> *arr = self.view.subviews.mutableCopy;
    [arr enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITableView class]]) {
            [obj removeFromSuperview];
        }
    }];
    CGRect rect = CGRectMake(0, 0, _currentWidth, screenHeight);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [self.view addSubview:self.tableView];
    UIView *sepV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, screenHeight)];
    sepV.backgroundColor = [UIColor blueColor];
    [self.tableView addSubview:sepV];
    OCMLog(@"co---%ld\n-%@", self.view.subviews.count,[self.view.subviews debugDescription]);
}
- (void)initData {
    NSArray *arr = @[@{
                       @"title":@"2017年第一批已完成VI门头建设网点的门头照片更新工作",@"publishTime":@"2017-11-30",@"progress":@"2/2",@"rate":@"100%",@"taskType":@"常规任务"
                         },
                     @{
                       @"title":@"【政策宣贯】关于12月渠道网点营销政策宣贯的工作",@"publishTime":@"2017-12-05",@"progress":@"12/61",@"rate":@"19.67%",@"taskType":@"常规任务"
                     }];
    NSMutableArray *mutableArr = [NSMutableArray new];
    for (NSDictionary *dict in arr) {
        TaskListItem *item = [TaskListItem itemWithDict:dict];
        [mutableArr addObject:item];
    }
    _testDataArr = mutableArr.mutableCopy;
}
#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _testDataArr.count;
}
static NSString *ID = @"cell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OCMTaskListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[OCMTaskListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.item = _testDataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskListItem *item = _testDataArr[indexPath.row];
    OCMTaskListWorkViewController *workVC = [[OCMTaskListWorkViewController alloc] init];
    workVC.item = item;
    [self.navigationController pushViewController:workVC animated:YES];
}
#pragma mark -- dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
