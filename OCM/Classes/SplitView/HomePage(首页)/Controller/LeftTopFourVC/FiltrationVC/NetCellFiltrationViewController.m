//
//  NetCellFiltrationViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/3/19.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "NetCellFiltrationViewController.h"

@interface NetCellFiltrationViewController ()

@end

@implementation NetCellFiltrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor yellowColor];
//    self.view.backgroundColor = [UIColor lightGrayColor];
    self.view.backgroundColor = [UIColor colorWithHexString:@"969696"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initTitle {
    self.titleArr = @[@"网元1",@"网元2",@"网元3",@"网元4",@"网元5",@"网元6",@"网元7",@"网元8"];
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
