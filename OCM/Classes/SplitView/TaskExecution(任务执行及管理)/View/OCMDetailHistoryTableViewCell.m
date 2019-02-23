//
//  OCMDetailHistoryTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2017/12/7.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMDetailHistoryTableViewCell.h"

@implementation OCMDetailHistoryTableViewCell
{
    UILabel *_titleL; //1
    UILabel *_netWorkL; //2
    UILabel *_netElement; //3
    UILabel *_netNumber; //4
    UILabel *_deadTimeL; //5
    UILabel *_publishL; //6
    UILabel *_finishL; //7
    UIView *_sepV; //8
    UIImageView *_iconV;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleL = [[UILabel alloc] init];
        _netWorkL = [[UILabel alloc] init];
        _netElement = [[UILabel alloc] init];
        _netNumber = [[UILabel alloc] init];
        
        _deadTimeL = [[UILabel alloc] init];
        _publishL = [[UILabel alloc] init];
        _finishL = [[UILabel alloc] init];
        _sepV = [[UIView alloc] init];
        
        _iconV = [[UIImageView alloc] init];
        _iconV.transform = CGAffineTransformRotate(_iconV.transform, -M_PI_2);
        [self addSubview:_titleL];
        [self addSubview:_netWorkL];
        [self addSubview:_netElement];
        [self addSubview:_netNumber];
        
        [self addSubview:_deadTimeL];
        [self addSubview:_publishL];
        [self addSubview:_finishL];
        [self addSubview:_sepV];
        
        [self addSubview:_iconV];
        [self setUpLayout];
    }
    return self;
}
- (void)setUpLayout {
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {//1
        make.left.mas_equalTo(28);
        make.top.mas_equalTo(10);
    }];
    [_netWorkL mas_makeConstraints:^(MASConstraintMaker *make) {//2
        make.left.mas_equalTo(28);
        make.top.mas_equalTo(_titleL.mas_bottom).offset(5);
    }];
    [_netElement mas_makeConstraints:^(MASConstraintMaker *make) {//3
        make.right.mas_equalTo(-180);
        make.top.mas_equalTo(_netWorkL.mas_top);
    }];
    [_netNumber mas_makeConstraints:^(MASConstraintMaker *make) {//4
        make.left.mas_equalTo(28);
        make.top.mas_equalTo(_netWorkL.mas_bottom).offset(5);
    }];
    [_deadTimeL mas_makeConstraints:^(MASConstraintMaker *make) {//5
        make.top.mas_equalTo(_netNumber);
        make.left.mas_equalTo(_netNumber.mas_right).offset(50);
    }];
    [_publishL mas_makeConstraints:^(MASConstraintMaker *make) {//6
        make.top.mas_equalTo(_deadTimeL);
        make.left.mas_equalTo(_deadTimeL.mas_right).offset(50);
    }];
    [_finishL mas_makeConstraints:^(MASConstraintMaker *make) {//7
        make.top.mas_equalTo(_publishL);
        make.right.mas_equalTo(_netElement.mas_right);
    }];
    [_sepV mas_makeConstraints:^(MASConstraintMaker *make) {//8
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-1);
        make.height.mas_equalTo(1);
    }];
    [_iconV mas_makeConstraints:^(MASConstraintMaker *make) {//9
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(20);
        make.right.mas_equalTo(self).offset(-10);
    }];
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
