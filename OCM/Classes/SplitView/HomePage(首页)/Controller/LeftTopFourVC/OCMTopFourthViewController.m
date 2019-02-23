//
//  OCMFourthViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/16.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMTopFourthViewController.h"

@interface OCMTopFourthViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;
@end

@implementation OCMTopFourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.3 green:0.4 blue:0.5 alpha:0.5];
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
