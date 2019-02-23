//
//  OCMRightBottomFirstViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/20.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMRightBottomFirstViewController.h"

@interface OCMRightBottomFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation OCMRightBottomFirstViewController
static NSString *cellID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, kRightBottomWidth, kRightBottomHeight - 40);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self setData];
    });
//    self.view.backgroundColor = [UIColor RGBColorWithRed:241 withGreen:241 withBlue:241 withAlpha:0.8];
//    self.view.backgroundColor = [UIColor clearColor];
    [self addTableView];
}
- (void)addTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.backgroundColor = [UIColor RGBColorWithRed:241 withGreen:241 withBlue:241 withAlpha:0.8];
    [self.view addSubview:_tableView];
}

#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor RGBColorWithRed:241 withGreen:241 withBlue:241 withAlpha:0.8];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row]];
    return cell;
}
- (void)setData {
    self.dataArr = @[@"任务:从中国移动通信网点到常平网元下发指标",
                     @"任务:从八达卡行到七菱网元下发指标",
                     @"任务:从常平福明木伦市场到指定专营下发指标",
                     @"任务:从中国移动通信网点到谷旭网元下发指标",
                     @"任务:从中国移动通信网点到常平网元下发指标",
                     @"任务:从八达卡行到七菱网元下发指标",
                     @"任务:从常平福明木伦市场到指定专营下发指标",
                     @"任务:从中国移动通信网点到谷旭网元下发指标",
                     @"任务:从中国移动通信网点到常平网元下发指标",
                     @"任务:从八达卡行到七菱网元下发指标",
                     @"任务:从常平福明木伦市场到指定专营下发指标",
                     @"任务:从中国移动通信网点到谷旭网元下发指标"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
