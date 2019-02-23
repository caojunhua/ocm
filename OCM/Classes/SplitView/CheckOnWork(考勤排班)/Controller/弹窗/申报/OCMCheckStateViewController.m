//
//  OCMCheckStateViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/5/14.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMCheckStateViewController.h"
#import "OCMCheckWorkItem.h"
#import "OCMCalendarItem.h"
#import "OCMCheckResView.h"
#import "OCMCheckHeaderView.h"

@interface OCMCheckStateViewController ()
@property (nonatomic, strong) OCMCheckHeaderView        *headerView;
@property (nonatomic, strong) UILabel                   *labelReason;
@property (nonatomic, strong) OCMCheckResView           *checkResView;
//@property (nonatomic, strong) UITextField               *textF;
@property (nonatomic, strong) UITextView                *textF;
@property (nonatomic, strong) UIButton                  *submitBtn;
@end

@implementation OCMCheckStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configHeaderView];
    
}
- (void)configHeaderView {
    _headerView                     = [[OCMCheckHeaderView alloc] initWithFrame:CGRectMake(0, 44, 400, 110)];
    _headerView.item                = self.item;
    _headerView.calendarItem        = self.calendarItem;
    _headerView.isUp                = self.isUp;
    [self.view addSubview:_headerView];
    
    
    CGFloat y                       = CGRectGetMaxY(_headerView.frame);
    UILabel *reasonL                = [[UILabel alloc] initWithFrame:CGRectMake(20, y, 85, 20)];
    reasonL.font                    = [UIFont systemFontOfSize:14];
    reasonL.text                    = @"申报原因:";
    reasonL.textColor               = [UIColor colorWithHexString:@"999999"];
    [self.view addSubview:reasonL];
    
    _labelReason                    = [[UILabel alloc] init];
    _labelReason.text               = @"网络原因";
    _labelReason.font               = [UIFont systemFontOfSize:14];
    _labelReason.textColor          = [UIColor colorWithHexString:@"333333"];
    [self.view addSubview:_labelReason];
    
    [_labelReason mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(reasonL.mas_centerY);
        make.left.mas_equalTo(reasonL.mas_right);
    }];
    
    _checkResView                   = [[OCMCheckResView alloc] initWithFrame:CGRectMake(0, y + 30, 400, 50)];
    UILabel *label1                 = [[UILabel alloc] init];
    label1.textColor                = KBlueColor;
    label1.text                     = @"已同意";
    label1.font                     = [UIFont systemFontOfSize:15];
    [_checkResView addSubview:label1];
    [self.view addSubview:_checkResView];
    __weak typeof(self) weakSelf    = self;
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.checkResView.checkerLabel.mas_right).offset(5);
        make.centerY.mas_equalTo(weakSelf.checkResView.checkerLabel.mas_centerY);
    }];
    
    _textF                          = [[UITextView alloc] init];
    _textF.font                     = [UIFont systemFontOfSize:14];

    _textF.hidden                   = YES;
    [self.view addSubview:_textF];
    
    _submitBtn                      = [[UIButton alloc] init];
    _submitBtn.backgroundColor      = KBlueColor;
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_submitBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [_submitBtn addTarget:self action:@selector(clickSubmitBtn) forControlEvents:UIControlEventTouchUpInside];
    _submitBtn.hidden               = YES;
    [self.view addSubview:_submitBtn];
    
    [_textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(reasonL.mas_bottom).offset(5);
        make.right.mas_equalTo(weakSelf.view.mas_right).offset(-20);
        make.height.mas_equalTo(110);
        ViewBorder(weakSelf.textF, 1, [UIColor lightGrayColor], 5);
    }];
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.textF.mas_bottom).offset(50);
        make.centerX.mas_equalTo(weakSelf.textF.mas_centerX);
        make.width.mas_equalTo(170);
        make.height.mas_equalTo(35);
        ViewBorder(weakSelf.submitBtn, 1, [UIColor clearColor], 5);
    }];
    //根据不同数据源显示或隐藏
    if ([self.item.checkUpStr isEqualToString:@"去申报"]) {
        _headerView.imgV.hidden = YES;
        _checkResView.hidden    = YES;
        _labelReason.hidden     = YES;
        
        _textF.hidden           = NO;
        _submitBtn.hidden       = NO;
    } else {
        _headerView.imgV.hidden = NO;
        _checkResView.hidden    = NO;
        _labelReason.hidden     = NO;
        
        _textF.hidden           = YES;
        _submitBtn.hidden       = YES;
    }
}
#pragma mark -- 点击事件
- (void)clickSubmitBtn {
    OCMLog(@"内容--%@", self.textF.text);
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc {
    OCMLog(@"释放");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
