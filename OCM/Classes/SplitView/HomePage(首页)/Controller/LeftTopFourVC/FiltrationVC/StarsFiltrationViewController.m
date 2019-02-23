//
//  StarsFiltrationViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/3/19.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "StarsFiltrationViewController.h"
#import "OCMStarFiltrationItem.h"
#import "OCMStarSubItem.h"

@interface StarsFiltrationViewController ()
@property (nonatomic, strong) NSMutableArray *arr;                                  //显示名字
@property (nonatomic, strong) NSMutableArray *paramsArr;                            //用于返回参数条件
@end

@implementation StarsFiltrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr = [NSMutableArray array];
    self.paramsArr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithHexString:@"969696"];
    [self loadData];
}
- (void)loadData {
    __weak typeof(self) weakSelf = self;
    OCMApiRequest *request = [OCMApiRequest sharedOCMApiRequest];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = NULL;
    params[@"size"] = NULL;
    NSString *path = [BaseURL stringByAppendingString:@"/v1/base/channellevel/list"];
    [request POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        OCMLog(@"success--%@", responseObject);
        __strong typeof(self) theSelf = weakSelf;
        OCMStarFiltrationItem *item = [OCMStarFiltrationItem mj_objectWithKeyValues:responseObject[@"data"]];
        NSMutableArray *tempArr = item.list;
        for (OCMStarSubItem *subItem in tempArr) {
            [self.arr addObject:subItem];
        }
        [theSelf initTitle];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        OCMLog(@"failure--%@", error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initTitle {
    NSMutableArray *tempArr = [NSMutableArray array];
    for (OCMStarSubItem *subItem in self.arr) {
        [tempArr addObject:subItem.levelName];
        [self.paramsArr addObject:@(subItem.StarID)];
    }
    self.titleArr = tempArr;
    [self.tableView reloadData];
//    self.titleArr = @[@"1星级",@"2星级",@"3星级",@"4星级",@"5星级",@"6星级",@"7星级",@"8星级"];
}
- (void)clickSure {
    NSMutableArray *temp = [NSMutableArray array];
    NSMutableArray *backTemp = [NSMutableArray array];
    for (NSIndexPath *indexP in self.seletedIndexArr) {
        [temp addObject:@(indexP.row)]; //下标数组
    }
    for (int i = 0; i < temp.count; i++) {
        NSNumber *index = temp[i];
        NSNumber *param = self.paramsArr[[index integerValue]];
        [backTemp addObject:param];
    }
    self.hiddenBlock(backTemp);
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
