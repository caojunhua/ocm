//
//  OCMMasterViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/11/30.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMLeftBaseNavigationController.h"

@interface OCMLeftBaseNavigationController ()

@end

@implementation OCMLeftBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor colorWithHexString:@"009dec"];
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
