//
//  OCMNearbyNetTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2017/12/25.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMNearbyNetTableViewCell.h"

@implementation OCMNearbyNetTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleL = [UILabel new];
        _titleL.font = [UIFont systemFontOfSize:12];
        _titleL.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:_titleL];
        
        _detailL = [UILabel new];
        _detailL.font = [UIFont systemFontOfSize:10];
        _detailL.textColor = [UIColor colorWithHexString:@"#666666"];
        [self addSubview:_detailL];
        
        _distanceL = [UILabel new];
        _distanceL.font = [UIFont systemFontOfSize:10];
        _distanceL.textColor = [UIColor colorWithHexString:@"666666"];
        [self addSubview:_distanceL];
        
        _numberL = [UILabel new];
        _numberL.font = [UIFont systemFontOfSize:10];
        _numberL.textColor = [UIColor colorWithHexString:@"#999999"];
        [self addSubview:_numberL];
        
        _warningBtn = [UIButton new];
        _warningBtn.tag = 1;
        [_warningBtn setTitle:@"预警" forState:UIControlStateNormal];
        [_warningBtn setTitleColor:[UIColor colorWithHexString:@"#ed1e1e"] forState:UIControlStateNormal];
        _warningBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        ViewBorder(_warningBtn, 1, [UIColor colorWithHexString:@"#ed1e1e"], 3);
        [self addSubview:_warningBtn];
        
        _checkBtn = [UIButton new];
        _checkBtn.tag = 2;
        [_checkBtn setTitle:@"考核" forState:UIControlStateNormal];
        [_checkBtn setTitleColor:[UIColor colorWithHexString:@"#ed891e"] forState:UIControlStateNormal];
        _checkBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        ViewBorder(_checkBtn, 1, [UIColor colorWithHexString:@"#ed891e"], 3);
        [self addSubview:_checkBtn];
        
        _taskBtn = [UIButton new];
        _taskBtn.tag = 3;
        [_taskBtn setTitle:@"任务" forState:UIControlStateNormal];
        [_taskBtn setTitleColor:[UIColor colorWithHexString:@"#05a805"] forState:UIControlStateNormal];
        _taskBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        ViewBorder(_taskBtn, 1, [UIColor colorWithHexString:@"#05a805"], 3);
        [self addSubview:_taskBtn];
        
        _signBtn = [UIButton new];
        _signBtn.tag = 4;
//        _signBtn.backgroundColor = [UIColor colorWithHexString:@"#009dec"]; // #b7b7b7
        ViewBorder(_signBtn, 1, [UIColor clearColor], 3);
        _signBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:_signBtn];
        
        [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(14);
            make.left.mas_equalTo(10);
        }];
        [_detailL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleL.mas_bottom).offset(8);
            make.left.mas_equalTo(10);
        }];
        [_distanceL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_detailL);
            make.left.mas_equalTo(_detailL.mas_right);
        }];
        [_numberL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_detailL.mas_bottom).offset(10);
            make.left.mas_equalTo(10);
        }];
        
        [_signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_numberL.mas_centerY);
            make.right.mas_equalTo(-8);
            make.width.mas_equalTo(35);
            make.height.mas_equalTo(15);
        }];
        [_taskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_signBtn.mas_centerY);
            make.right.mas_equalTo(_signBtn.mas_left).offset(-8);
            make.width.mas_equalTo(35);
            make.height.mas_equalTo(15);
        }];
        [_checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_taskBtn.mas_centerY);
            make.right.mas_equalTo(_taskBtn.mas_left).offset(-8);
            make.width.mas_equalTo(35);
            make.height.mas_equalTo(15);
        }];
        [_warningBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_checkBtn.mas_centerY);
            make.right.mas_equalTo(_checkBtn.mas_left).offset(-8);
            make.width.mas_equalTo(35);
            make.height.mas_equalTo(15);
        }];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
