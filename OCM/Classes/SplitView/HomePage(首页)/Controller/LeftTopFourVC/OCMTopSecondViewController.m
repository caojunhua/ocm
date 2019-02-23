//
//  OCMTopSecondViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/16.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMTopSecondViewController.h"
#import "OCMLeftTopSecondTableViewCell.h"
#import "OCMChannelListItem.h"
#import "OCMListItem.h"
#import "OCMNetInfoStruct.h"

@interface OCMTopSecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, assign) NSInteger lastPage;        //最大页数
@property (nonatomic, assign) NSInteger currentPage;     //当前页数
@end

#define kMiddleViewHeight 285
@implementation OCMTopSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)config {
    self.view.backgroundColor = [UIColor RGBColorWithRed:241 withGreen:241 withBlue:241 withAlpha:0.8];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 290, kMiddleViewHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.alpha = 0.5;
    [self.view addSubview:self.tableView];
    //默认第一页
    self.arr = [NSMutableArray array];
    self.currentPage = 1;
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        OCMLog(@"下拉一次了");
//        if (self.currentPage >= 2) {
//            self.currentPage -= 1;
//            [weakSelf getDataIsByHead:YES];
//        } else if (self.currentPage == 1) {
//            [weakSelf getDataIsByHead:YES];
//        } else {
//            [weakSelf.tableView.mj_header endRefreshingCompletionBlock];
//        }
        [weakSelf getDataIsByHead:YES];
    }];
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        OCMLog(@"上拉了一次");
//        if (self.currentPage < self.lastPage) {
//            self.currentPage += 1;
//            [weakSelf getDataIsByHead:NO];
//        } else {
//            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
//        }
//        [weakSelf getDataIsByHead:NO];
//    }];
    [self loadData];
}
- (void)loadData {
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark -- 网络请求
int i = 1;
- (void)getDataIsByHead:(BOOL)isHead {
    /**为了测试方便缓存数据**/
    DataBase *db        = [DataBase shareInstance];
    NSMutableArray *arr = [db getAllNetInfo]; //查询
    if (arr.count > 0) {
        self.arr = arr;
        OCMLog(@"有缓存数据");
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        return;
    }
    /****/
    OCMLog(@"请求网络--");
    __weak typeof(self) weakSelf = self;
    OCMApiRequest *request       = [OCMApiRequest sharedOCMApiRequest];
    NSString *url                = @"/v1/channel/nearby";
    NSString *path               = [BaseURL stringByAppendingString:url];
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    params[@"latitude"]          = @23.030657;    // self.currentLocation.latitude;
    params[@"longitude"]         = @113.757424;   // self.currentLocation.longitude;
    [request POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        OCMLog(@"success--%@", responseObject);
        __strong typeof(weakSelf) theSelf = self;
        OCMChannelListItem *channelList = [OCMChannelListItem mj_objectWithKeyValues:responseObject];
        if (isHead) {
            theSelf.arr = channelList.data;
            [theSelf.tableView.mj_header endRefreshing];
        } else {
//            NSMutableArray *tempArr = channelList.data;
//            [theSelf.arr addObjectsFromArray:tempArr];
//            [theSelf.tableView.mj_footer endRefreshing];
//            theSelf.tableView.mj_footer.hidden = YES;
        }
//        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//        NSString *fileName = [path stringByAppendingPathComponent:@ "123.plist" ];
//        OCMLog(@"filename--%@", fileName); /Users/caojunhua/Desktop/未命名文件夹
//        [responseObject writeToFile:@"/Users/caojunhua/Desktop/未命名文件夹/123.plist" atomically:YES];
        //存入数据库
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            DataBase *db = [DataBase shareInstance];
            for (OCMListItem *item in theSelf.arr) {
                [db insertNetInfo:item];
            }
//            NSMutableArray *arr = [db getAllNetInfo]; //查询
//            OCMLog(@"arr--%@", [arr debugDescription]);
        });
        [theSelf.tableView reloadData];
        if (i == 1) {
            OCMLog(@"默认点击");
//            [theSelf tableView:theSelf.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            i -= 1;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        OCMLog(@"failure--%@", error);
    }];
    
}
#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"OCMLeftTopSecondTableViewCell";
    OCMLeftTopSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[OCMLeftTopSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    OCMListItem *list = self.arr[indexPath.row];
    cell.label1.text = [NSString stringWithFormat:@"%@",list.chName];
    cell.label2.text = [NSString stringWithFormat:@"%@",list.bossId];
    cell.label3.text = [NSString stringWithFormat:@"网点联系人 : %@",list.contacts];
    cell.label4.text = [NSString stringWithFormat:@"联系电话 : %@",list.phone];
    cell.label5.text = [NSString stringWithFormat:@"星级 : %@",list.rankCode];
    OCMLog(@"距离--%f\n%@", list.distance,list.phone);
    cell.label6.text = [NSString stringWithFormat:@"距离--%.2f",list.distance];
    cell.chLatitude = list.chLatitude;//纬度
    cell.chLogngitude = list.chLogngitude;//经度
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OCMLeftTopSecondTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    self.netLocation(cell.chLatitude, cell.chLogngitude);
    /*------------------*/
    OCMListItem *list = self.arr[indexPath.row];
    OCMNetInfoStruct *netStruct = [[OCMNetInfoStruct alloc] init];
    const char *chName = [list.chName cStringUsingEncoding:NSUTF8StringEncoding];
    const char *bossId = [list.bossId cStringUsingEncoding:NSUTF8StringEncoding];
    const char *contacts = [list.contacts cStringUsingEncoding:NSUTF8StringEncoding];
    const char *rankCode = [list.rankCode cStringUsingEncoding:NSUTF8StringEncoding];
    const char *phone = [list.phone cStringUsingEncoding:NSUTF8StringEncoding];
    const char *qdid = [list.QDid cStringUsingEncoding:NSUTF8StringEncoding];
    netStruct.netDetailInfo = netInfoMake(chName, bossId, contacts, rankCode, phone, list.chLatitude, list.chLogngitude,list.distance,qdid);
    self.ocmNetInfo(netStruct);
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
