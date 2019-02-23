//
//  ModalFirstViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/3/12.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "ModalFirstViewController.h"
#import "OCMNetTaskDetailModel.h"

#import "OCMNetTaskDetailHeaderView.h"
#import "OCMNetTaskDetailEditView.h"

@interface ModalFirstViewController ()

@property (nonatomic,strong)OCMNetTaskDetailModel *detailModel;

@end

@implementation ModalFirstViewController

- (void)setDetailModel:(OCMNetTaskDetailModel *)detailModel{
    self.detailModel = detailModel;
    [self loadData];
}
/** 获取网络数据，任务详情*/
- (void)loadData{
    OCMLog(@"ajfhfjhgjkdjfk");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    OCMLog(@"hello world");
    // Do any additional setup after loading the view.
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

