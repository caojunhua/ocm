//
//  OCMCheckResView.m
//  OCM
//
//  Created by 曹均华 on 2018/4/25.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMCheckResView.h"

@implementation OCMCheckResView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}
- (void)config {
    CGFloat disX = 20.;
    CGFloat topY = 10.;
    
    __weak typeof(self) weakSelf = self;
    [self.pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).offset(disX);
        make.top.mas_equalTo(weakSelf.mas_top).offset(topY);
        make.width.height.mas_equalTo(4);
        ViewBorder(weakSelf.pointView, 1, [UIColor clearColor], 2);
    }];
    [self.checkerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.pointView.mas_right).offset(5);
        make.centerY.mas_equalTo(weakSelf.pointView.mas_centerY);
    }];
    [self.checkTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.mas_right).offset(-disX);
//        make.left.mas_equalTo(weakSelf.mas_left).offset(220);
        make.centerY.mas_equalTo(weakSelf.checkerLabel.mas_centerY);
    }];
    [self.suggestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.checkerLabel.mas_left);
        make.top.mas_equalTo(weakSelf.checkerLabel.mas_bottom).offset(topY);
        make.width.mas_equalTo(350);
        make.height.mas_equalTo(20);
    }];
}
#pragma mark -- lazyInit
- (UIImageView *)pointView {
    if (!_pointView) {
        _pointView       = [[UIImageView alloc] init];
        _pointView.image = [UIImage createImageWithColor:[UIColor randomColor]];
        [self addSubview:_pointView];
    }
    return _pointView;
}
- (UILabel *)checkerLabel {
    if (!_checkerLabel) {
        _checkerLabel           = [[UILabel alloc] init];
        _checkerLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _checkerLabel.font      = [UIFont systemFontOfSize:15];
        _checkerLabel.text      = @"张三";
        [self addSubview:_checkerLabel];
    }
    return _checkerLabel;
}
- (UILabel *)checkTimeLabel {
    if (!_checkTimeLabel) {
        _checkTimeLabel           = [[UILabel alloc] init];
        _checkTimeLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _checkTimeLabel.font      = [UIFont systemFontOfSize:15];
        _checkTimeLabel.text        = @"2017-07-29 13:23:45";
        [self addSubview:_checkTimeLabel];
    }
    return _checkTimeLabel;
}
- (UILabel *)suggestLabel {
    if (!_suggestLabel) {
        _suggestLabel           = [[UILabel alloc] init];
        _suggestLabel.textColor = [UIColor colorWithHexString:@"666666"];
        _suggestLabel.font      = [UIFont systemFontOfSize:15];
        _suggestLabel.text      = @"原因: 排班时间不够";
        [self addSubview:_suggestLabel];
    }
    return _suggestLabel;
}
@end
