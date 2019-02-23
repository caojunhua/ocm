//
//  OCMDetailNetViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/3/6.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMDetailNetViewController.h"
#import "OCMMoreDetailInfoHeadView.h"
#import "OCMMoreDetailTableViewCell.h"
#import "ModalFirstViewController.h" //测试跳转
#import "OCMNetTaskListModel.h"     //任务列表model
#import "OCMNetTaskListHeader.h"    //头部（button切换tab）


@interface OCMDetailNetViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *datas;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OCMMoreDetailInfoHeadView *headV;
@property (nonatomic, strong) OCMMoreDetailTableViewCell *selectedCell;
@end

static NSString *const ocmMoreDetailTableViewCell = @"OCMMoreDetailTableViewCell";

@implementation OCMDetailNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    datas = (NSMutableArray *)[OCMNetTaskListModel createNetTaskListTest];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    CGFloat w = 0;
    w = screenWidth - kLeftBigWidth;
    [self config];
    [self configTableViewWithWidth:w];
    //    if (self.isBigLeft) {
    //        w = screenWidth - kLeftBigWidth;
    //        [self config];
    //        [self configTableViewWithWidth:w];
    //    } else {
    //        w = screenWidth - kLeftSmallWidth;
    //        [self config];
    //        [self configTableViewWithWidth:w];
    //    }
    //    [self addNotify];
    //    [self layoutUI];
}
- (void)layoutUI {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor colorWithHexString:@"009dec"];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 60, 30)];
    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismssBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
}
- (void)dismssBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addNotify {
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLeftWidth) name:NswipeLeftGes object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRightWidth) name:NswipeRightGes object:nil];
}
- (void)setLeftWidth {
    CGFloat w = screenWidth - kLeftSmallWidth;
    [self configTableViewWithWidth:w];
}
- (void)setRightWidth {
    CGFloat w = screenWidth - kLeftBigWidth;
    [self configTableViewWithWidth:w];
}
- (void)config {
    CGFloat w = screenWidth - kLeftBigWidth;
    OCMMoreDetailInfoHeadView *headV = [[OCMMoreDetailInfoHeadView alloc] initWithFrame:CGRectMake(0, 0, w, 197)];
    //    headV.backgroundColor = [];
    [self.view addSubview:headV];
    _headV = headV;
}
- (void)configTableViewWithWidth:(CGFloat)w {
    //    if (self.tableView) {
    //        [self.tableView removeFromSuperview];
    //    }
    //添加tabelView
    CGFloat y = CGRectGetMaxY(_headV.frame);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, w, screenHeight - 197) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"OCMMoreDetailTableViewCell" bundle:nil]forCellReuseIdentifier:ocmMoreDetailTableViewCell];
    [self.view addSubview:self.tableView];
    //    [self.tableView registerNib:[UINib nibWithNibName:@"OCMMoreDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"OCMMoreDetailTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
//#pragma mark -- 点击事件
//- (void)clickSignBtn:(OCMMoreDetailTableViewCell *)cell {
////    [_selectedCell.signBtn setTitle:@"已签到" forState:UIControlStateNormal];
////    [_selectedCell.signBtn setBackgroundColor:[UIColor RGBColorWithRed:204 withGreen:204 withBlue:204 withAlpha:1]];
//}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NSString *ID = [NSString stringWithFormat:@"OCMMoreDetailTableViewCell%ld%ld",[indexPath section],[indexPath row]];
    //    static NSString *ID = @"cell";
    OCMMoreDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ocmMoreDetailTableViewCell];
    
    //    if (!cell) {
    ////        cell = [[OCMMoreDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    //        cell = [[[NSBundle mainBundle] loadNibNamed:@"OCMMoreDetailTableViewCell" owner:self options:nil] lastObject];
    //    } else {//删除cell的所有子视图
    //        while ([cell.contentView.subviews lastObject] != nil)
    //        {
    //            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
    //        }
    //    }
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    [cell.signBtn addTarget:self action:@selector(clickSignBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    if (indexPath.section == 0 && indexPath.row == 1) {
    //        [cell.taskBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //        cell.taskBtn.layer.borderColor = [UIColor redColor].CGColor;
    //    }
    
    [cell setModel:datas[indexPath.row]];
    [cell clickSignButtonWithHandle:^{
        OCMLog(@"%zd", random()%3);
    }];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //    if (section == 0) {
    //        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 35)];
    //        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, 100, 20)];
    //        label.text = @"未完成任务";
    //        label.textColor = [UIColor colorWithHexString:@"999999"];
    //        label.font = [UIFont systemFontOfSize:14];
    //        [view addSubview:label];
    //        return view;
    //    } else {
    //        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 35)];
    //        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, -10, 100, 20)];
    //        label.text = @"已完成任务";
    //        label.textColor = [UIColor colorWithHexString:@"999999"];
    //        label.font = [UIFont systemFontOfSize:14];
    //        [view addSubview:label];
    //        return view;
    //    }
    return [OCMNetTaskListHeader createHeaderWithDataSource:@[@"未完成任务",@"已完成任务",@"历史任务"] clickButtonWithHandle:^(NSInteger index) {
        OCMLog(@"%ld",index);
        
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //    if (section == 0) {
    //        return 36;
    //    } else {
    //        return 16;
    //    }
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OCMMoreDetailTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    _selectedCell = cell;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ModalFirstViewController *firstVC = [[ModalFirstViewController alloc] init];
    //    firstVC setDetailModel:<#(OCMNetTaskDetailModel *)#>
    [self.navigationController pushViewController:firstVC animated:YES];
    OCMLog(@"点击了选中某个cell");
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

