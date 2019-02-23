//
//  RightBaseNavigationViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/8.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMRightBaseNavigationViewController.h"

@interface OCMRightBaseNavigationViewController ()

@end

@implementation OCMRightBaseNavigationViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor colorWithHexString:@"009dec"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff"]}];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count >= 1) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.bounds = CGRectMake(0, 0, 60, 30);
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"icon_leftbar_return"] forState:UIControlStateNormal]; 
        [backButton setImage:[UIImage imageNamed:@"icon_leftbar_return"] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    [super pushViewController:viewController animated:YES];
}
- (void)backView {
    [self popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
