//
//  OCMPersonalRateViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/1/9.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMPersonalRateViewController.h"
#import "OCMPersonalView.h"

@interface OCMPersonalRateViewController ()
@property (nonatomic,strong)OCMPersonalView *personalView;

//data
@property (nonatomic,copy)NSString *teamName;//班组名称
@property (nonatomic,copy)NSString *personName;//个人的名字
@property (nonatomic,strong)NSArray *completeArr;//完成任务的数据数组
@property (nonatomic,strong)NSArray *planArr;//计划的任务数据数组
@property (nonatomic,strong)NSArray *taskArr;//任务的名字

@end

@implementation OCMPersonalRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setData];
    [self config];
}
- (void)config {
    CGRect rect = CGRectMake(28, 25, _showWidth - 56, self.view.height - 50 - 64);
    _personalView = [[OCMPersonalView alloc] initWithTeamName:_teamName person:_personName completedArr:_completeArr planArr:_planArr taskArr:_taskArr frame:rect];
    [self.view addSubview:_personalView];
}
#pragma mark -- 数据
- (void)setData {
    _teamName = @"茶山组";
    _personName = @"张三";
    _completeArr = @[@"40",@"25",@"84",@"44",@"58",@"57",@"68",@"90"];
    _planArr = @[@"100",@"200",@"100",@"300",@"120",@"130",@"140",@"110"];
    _taskArr = @[@"日常走访",@"常规走访",@"测试下发任务",@"测试下发任务2",@"110走访",@"6月宣传覆盖",@"8月宣传覆盖",@"10月宣传覆盖"];
}
#pragma mark -- dealloc
- (void)dealloc {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
