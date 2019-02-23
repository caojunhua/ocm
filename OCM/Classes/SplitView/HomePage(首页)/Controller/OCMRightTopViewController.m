//
//  OCMRightTopViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/19.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMRightTopViewController.h"

@interface OCMRightTopViewController ()

@end

@implementation OCMRightTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBtn];
}
- (void)addBtn {
    
    
    _switchBtn = [[UIButton alloc] init];
    _switchBtn.frame = CGRectMake(0, 0, 40, 40);
    [_switchBtn setImage:[UIImage imageNamed:@"形状24"] forState:UIControlStateNormal];
    [self.view addSubview:_switchBtn];
    
    _locationBtn = [[UIButton alloc] init];
    _locationBtn.frame = CGRectMake(0, 40, 40, 40);
    [_locationBtn setImage:[UIImage imageNamed:@"形状18"] forState:UIControlStateNormal];
    [self.view addSubview:_locationBtn];
    
    _gouBtn = [[UIButton alloc] init];
    _gouBtn.frame = CGRectMake(0, 80, 40, 40);
    [_gouBtn setImage:[UIImage imageNamed:@"打卡"] forState:UIControlStateNormal];
    [self.view addSubview:_gouBtn];
    
    UIView *sepV1 = [[UIView alloc] initWithFrame:CGRectMake(8, 40, 24, 0.5)];
    sepV1.backgroundColor = [UIColor RGBColorWithRed:161 withGreen:171 withBlue:181 withAlpha:0.8];
    [self.view addSubview:sepV1];
    
    UIView *sepV2 = [[UIView alloc] initWithFrame:CGRectMake(8, 80, 24, 0.5)];
    sepV2.backgroundColor = [UIColor RGBColorWithRed:161 withGreen:171 withBlue:181 withAlpha:0.8];
    [self.view addSubview:sepV2];
    
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
