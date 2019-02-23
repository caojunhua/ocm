//
//  OCMCustomArrangeTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2018/4/26.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMCustomArrangeTableViewCell1.h"
#import "CFDynamicLabel.h"
#import "OCMCustomArrangeItem.h"

@implementation OCMCustomArrangeTableViewCell1


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat w     = 700;
        CGFloat h     = 86;
        self.frame    = CGRectMake(0, 0, w, h);
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 0.5)];
        lineV.backgroundColor = [UIColor colorWithHexString:@"666666"];
        [self addSubview:lineV];
        [self config];
    }
    return self;
}
- (void)config {
    __weak typeof(self) weakSelf = self;
    [self.arrangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {            //班次1
        make.top.mas_equalTo(weakSelf.mas_top).offset(15);
        make.left.mas_equalTo(weakSelf.mas_left).offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
    }];
    [self.textField1 mas_makeConstraints:^(MASConstraintMaker *make) {              //开始时间
        make.top.mas_equalTo(weakSelf.arrangeLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(weakSelf.mas_left).offset(20);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(28);
    }];
    [self.sepV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.textField1.mas_right).offset(12);
        make.centerY.mas_equalTo(weakSelf.textField1.mas_centerY);
        make.width.mas_equalTo(17);
        make.height.mas_equalTo(1);
    }];
    [self.textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.sepV.mas_right).offset(12);
        make.centerY.mas_equalTo(weakSelf.textField1.mas_centerY);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(28);
    }];
    
    CGFloat leftDis = 50;
    [self.subTaskL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.mas_right).offset(-leftDis);
        make.centerY.mas_equalTo(weakSelf.textField2.mas_centerY);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(28);
    }];
    [self.superTaskL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.subTaskL.mas_left).offset(-12);
        make.centerY.mas_equalTo(weakSelf.textField2.mas_centerY);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(28);
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.arrangeLabel.mas_centerY);
        make.right.mas_equalTo(weakSelf.subTaskL.mas_right);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.label2.mas_centerY);
        make.right.mas_equalTo(weakSelf.label2.mas_left);
    }];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.label2.mas_centerY);
        make.right.mas_equalTo(weakSelf.timeLabel.mas_left);
    }];
    CGFloat x1 = CGRectGetMaxX(self.textField2.frame);
    CGFloat x2 = CGRectGetMinX(self.superTaskL.frame);
    [self.subTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo((x2 - x1) * 0.5 + x1).offset(-weakSelf.subTitleL.width * 0.5 - 15);
        make.centerY.mas_equalTo(weakSelf.textField2.mas_centerY);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setItem:(OCMCustomArrangeItem *)item {
    _item = item;
    [self.textField1 setTitle:item.beginTime forState:UIControlStateNormal];
    [self.textField2 setTitle:item.endTime forState:UIControlStateNormal];
    self.timeLabel.text = [self caculateWithBeginTime:item.beginTime endTime:item.endTime];
}
- (NSString *)caculateWithBeginTime:(NSString *)beginTime endTime:(NSString *)endTime {
    NSArray *beginArr  = [beginTime componentsSeparatedByString:@":"];
    NSArray *endArr    = [endTime componentsSeparatedByString:@":"];
    NSInteger totalMin = ([endArr[0] integerValue] - [beginArr[0] integerValue]) * 60 + ([endArr[1] integerValue] - [beginArr[1] integerValue]);
    CGFloat time       = totalMin / 60.f;
    NSString *str      = [NSString stringWithFormat:@"%.2f",time];
    return str;
}
#pragma mark -- lazyInit
- (UILabel *)arrangeLabel {
    if (!_arrangeLabel) {
        _arrangeLabel           = [[UILabel alloc] init];
        _arrangeLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _arrangeLabel.font      = [UIFont systemFontOfSize:18];
        [self addSubview:_arrangeLabel];
    }
    return _arrangeLabel;
}
- (UIButton *)textField1 {
    if (!_textField1) {
        _textField1                 = [[UIButton alloc] init];
        ViewBorder(_textField1, 0.5, [UIColor colorWithHexString:@"999999"], 5);
        _textField1.tag             = 101;
        [self.textField1 setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        [self addSubview:_textField1];
    }
    return _textField1;
}
- (UIView *)sepV {
    if (!_sepV) {
        _sepV                 = [[UIView alloc] init];
        _sepV.backgroundColor = [UIColor colorWithHexString:@"999999"];
        [self addSubview:_sepV];
    }
    return _sepV;
}
- (UIButton *)textField2 {
    if (!_textField2) {
        _textField2                 = [[UIButton alloc] init];
        ViewBorder(_textField2, 0.5, [UIColor colorWithHexString:@"999999"], 5);
        _textField2.tag             = 102;
        [self.textField2 setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        [self addSubview:_textField2];
    }
    return _textField2;
}
- (UILabel *)subTitleL {
    if (!_subTitleL) {
        _subTitleL            = [[UILabel alloc] init];
        _subTitleL.width      = 67;
        _subTitleL.height     = 20;
        _subTitleL.text       = @"排班内容";
        _subTitleL.textColor  = [UIColor colorWithHexString:@"666666"];
        _subTitleL.font       = [UIFont systemFontOfSize:17];
        _subTitleL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_subTitleL];
    }
    return _subTitleL;
}
- (UIButton *)superTaskL {
    if (!_superTaskL) {
        _superTaskL                 = [[UIButton alloc] init];
        _superTaskL.backgroundColor = [UIColor whiteColor];
        [self addSubview:_superTaskL];
        ViewBorder(_superTaskL, 1, [UIColor colorWithHexString:@"999999"], 5);
        _superImgV1                 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
        _superLabel1                = [[UILabel alloc] initWithFrame:CGRectMake(31, 6, 72, 16)];
        UIImageView *icon           = [[UIImageView alloc] initWithFrame:CGRectMake(102, 10, 13, 8)];
        icon.image                  = ImageIs(@"btn_task_down");
        [_superTaskL addSubview:_superImgV1];
        [_superTaskL addSubview:_superLabel1];
        _superTaskL.tag             = 103;
        [_superTaskL addSubview:icon];
    }
    return _superTaskL;
}
- (UIButton *)subTaskL {
    if (!_subTaskL) {
        _subTaskL                   = [[UIButton alloc] init];
        _subTaskL.backgroundColor   = [UIColor whiteColor];
        [self addSubview:_subTaskL];
        ViewBorder(_subTaskL, 1, [UIColor colorWithHexString:@"999999"], 5);
        _subLabel2                  = [[UILabel alloc] initWithFrame:CGRectMake(13, 6, 90, 16)];
        UIImageView *icon           = [[UIImageView alloc] initWithFrame:CGRectMake(102, 10, 13, 8)];
        icon.image                  = ImageIs(@"btn_task_down");
        _subTaskL.tag               = 104;
        [_subTaskL addSubview:_subImgV2];
        [_subTaskL addSubview:_subLabel2];
        [_subTaskL addSubview:icon];
    }
    return _subTaskL;
}
- (UILabel *)label1 {
    if (!_label1) {
        _label1                   = [[UILabel alloc] init];
        _label1.font              = [UIFont systemFontOfSize:14];
        _label1.text              = @"时长:";
        _label1.textColor         = [UIColor colorWithHexString:@"333333"];
        [self addSubview:_label1];
    }
    return _label1;
}
- (UILabel *)label2 {
    if (!_label2) {
        _label2                   = [[UILabel alloc] init];
        _label2.font              = [UIFont systemFontOfSize:14];
        _label2.text              = @"小时";
        _label2.textColor         = [UIColor colorWithHexString:@"333333"];
        [self addSubview:_label2];
    }
    return _label2;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel                = [[UILabel alloc] init];
        _timeLabel.font           = [UIFont systemFontOfSize:14];
        _timeLabel.textColor      = KRedColor;
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}
@end

