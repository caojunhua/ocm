//
//  OCMCalendarHeaderView.m
//  OCM
//
//  Created by 曹均华 on 2018/4/13.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMCalendarHeaderView.h"

@implementation OCMCalendarHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor RGBColorWithRed:249 withGreen:249 withBlue:249 withAlpha:1.0];
        CGFloat w = frame.size.width;
        [self configWithWidth:w];
    }
    return self;
}

- (void)configWithWidth:(CGFloat)width {
    [self addSubview:self.lastBtn];
    [self addSubview:self.yearMonthLabel];
    [self addSubview:self.nextBtn];
    [self addSubview:self.reportBtn];
    [self addSubview:self.arrangeBtn];
    [self addSubview:self.selectShiftBtn];
    [self addSubview:self.daysView];
    
    //layoutUI
    __weak typeof(self) weakSelf = self;
    // 布局--->       " <  xxxx年xx月  > "
    [self.yearMonthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(weakSelf.mas_top).offset(20);
    }];
    [self.lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(9);
        make.height.mas_equalTo(15);
        make.centerY.mas_equalTo(weakSelf.yearMonthLabel.mas_centerY);
        make.right.mas_equalTo(weakSelf.yearMonthLabel.mas_left).offset(-23);
    }];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(9);
        make.height.mas_equalTo(15);
        make.centerY.mas_equalTo(weakSelf.yearMonthLabel.mas_centerY);
        make.left.mas_equalTo(weakSelf.yearMonthLabel.mas_right).offset(23);
    }];
    
    //  班制btn && 选择班制btn
    [self.selectShiftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
        make.centerY.mas_equalTo(weakSelf.yearMonthLabel.mas_centerY);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-25);
        ViewBorder(weakSelf.selectShiftBtn, 1, [UIColor colorWithHexString:@"009dec"], 5);
    }];
    [self.arrangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(25);
        make.centerY.mas_equalTo(weakSelf.yearMonthLabel.mas_centerY);
        make.right.mas_equalTo(weakSelf.selectShiftBtn.mas_left).offset(-15);
        ViewBorder(weakSelf.arrangeBtn, 1, [UIColor colorWithHexString:@"009dec"], 5);
    }];
    
    //申报btn
    [self.reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(25);
        make.centerY.mas_equalTo(weakSelf.yearMonthLabel.mas_centerY);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-25);
        ViewBorder(weakSelf.reportBtn, 1, [UIColor colorWithHexString:@"009dec"], 5);
    }];
    //周1~周7 --->view
    [self.daysView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(weakSelf.width);
        make.height.mas_equalTo(37);
        make.left.mas_equalTo(weakSelf.mas_left);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
    }];
    _lastBtn.hidden = YES;
    _nextBtn.hidden = YES;
}

#pragma mark -- lazyInit
- (UIButton *)lastBtn {
    if (!_lastBtn) {
        _lastBtn = [[UIButton alloc] init];
        _lastBtn.backgroundColor = [UIColor redColor];
    }
    return _lastBtn;
}
- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] init];
        _nextBtn.backgroundColor = [UIColor yellowColor];
    }
    return _nextBtn;
}
- (UILabel *)yearMonthLabel {
    if (!_yearMonthLabel) {
        _yearMonthLabel = [[UILabel alloc] init];
//        _yearMonthLabel.text = @"2018年04月";
        _yearMonthLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _yearMonthLabel;
}
- (UIButton *)reportBtn {
    if (!_reportBtn) {
        _reportBtn = [[UIButton alloc] init];
        [_reportBtn setTitle:@"申报" forState:UIControlStateNormal];
        [_reportBtn setTitleColor:[UIColor colorWithHexString:@"009dec"] forState:UIControlStateNormal];
        [_reportBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    }
    return _reportBtn;
}
- (UIButton *)arrangeBtn {
    if (!_arrangeBtn) {
        _arrangeBtn = [[UIButton alloc] init];
        [_arrangeBtn setTitle:@"排班" forState:UIControlStateNormal];
        [_arrangeBtn setTitleColor:[UIColor colorWithHexString:@"009dec"] forState:UIControlStateNormal];
        [_arrangeBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    }
    return _arrangeBtn;
}
- (UIButton *)selectShiftBtn {
    if (!_selectShiftBtn) {
        _selectShiftBtn = [[UIButton alloc] init];
        [_selectShiftBtn setTitle:@"选择班制" forState:UIControlStateNormal];
        [_selectShiftBtn setTitleColor:[UIColor colorWithHexString:@"009dec"] forState:UIControlStateNormal];
        [_selectShiftBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    }
    return _selectShiftBtn;
}
- (UIView *)daysView {
    if (!_daysView) {
        _daysView = [[UIView alloc] init];
        //根据daysView的frame添加周1~周7
        NSArray *arr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        CGFloat w    = self.width / 7;
        for (int i = 0; i < 7; i ++) {
            UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(i * w, 0, w, 37)];
            if (i == 0 || i == 6) {
                label.textColor = [UIColor colorWithHexString:@"999999"];
            } else {
                label.textColor = [UIColor colorWithHexString:@"333333"];
            }
            label.textAlignment = NSTextAlignmentCenter;
            label.text          = arr[i];
            [self.daysView addSubview:label];
        }
    }
    return _daysView;
}
@end
