
//
//  OCMCheckWorkTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2018/5/11.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMCheckWorkTableViewCell.h"
#import "OCMCheckWorkItem.h"

@implementation OCMCheckWorkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self config];
    }
    return self;
}
- (void)config {
    _arrangeL               = [[UILabel alloc] init];
    _arrangeL.textColor     = [UIColor colorWithHexString:@"666666"];
    [self addSubview:_arrangeL];
    
    _beginTimeL             = [[UILabel alloc] init];
    _beginTimeL.textColor   = [UIColor colorWithHexString:@"333333"];
    _beginTimeL.font        = [UIFont systemFontOfSize:17];
    [self addSubview:_beginTimeL];
    
    UIView *sepV            = [[UIView alloc] init];
    sepV.backgroundColor    = [UIColor colorWithHexString:@"333333"];
    [self addSubview:sepV];
    
    _endTimeL               = [[UILabel alloc] init];
    _endTimeL.textColor     = [UIColor colorWithHexString:@"333333"];
    _endTimeL.font          = [UIFont systemFontOfSize:17];
    [self addSubview:_endTimeL];
    
    _imgV                   = [[UIImageView alloc] init];
    [self addSubview:_imgV];
    
    _workTypeL              = [[UILabel alloc] init];
    _workTypeL.textColor    = [UIColor colorWithHexString:@"666666"];
    [self addSubview:_workTypeL];
    
    UILabel *dakaL          = [[UILabel alloc] init];
    dakaL.text              = @"打卡时间:";
    dakaL.font              = [UIFont systemFontOfSize:17];
    dakaL.textColor         = [UIColor colorWithHexString:@"333333"];
    [self addSubview:dakaL];
    
    UILabel *shangL         = [[UILabel alloc] init];
    shangL.backgroundColor  = [UIColor RGBColorWithRed:207 withGreen:207 withBlue:107 withAlpha:1.0];
    shangL.text             = @"上";
    shangL.textColor        = [UIColor colorWithHexString:@"ffffff"];
    shangL.font             = [UIFont systemFontOfSize:12];
    shangL.textAlignment    = NSTextAlignmentCenter;
    [self addSubview:shangL];
    
    UILabel *xiaL           = [[UILabel alloc] init];
    xiaL.backgroundColor    = [UIColor RGBColorWithRed:207 withGreen:207 withBlue:107 withAlpha:1.0];
    xiaL.text               = @"下";
    xiaL.textColor          = [UIColor colorWithHexString:@"ffffff"];
    xiaL.font               = [UIFont systemFontOfSize:12];
    xiaL.textAlignment      = NSTextAlignmentCenter;
    [self addSubview:xiaL];
    
    UIView *lineV           = [[UIView alloc] init];
    lineV.backgroundColor   = [UIColor RGBColorWithRed:207 withGreen:207 withBlue:107 withAlpha:1.0];
    [self addSubview:lineV];
    
    _checkBeginL            = [[UILabel alloc] init];
    _checkBeginL.textColor  = [UIColor colorWithHexString:@"333333"];
    _checkBeginL.font       = [UIFont systemFontOfSize:17];
    [self addSubview:_checkBeginL];
    
    _checkEndL              = [[UILabel alloc] init];
    _checkEndL.textColor    = [UIColor colorWithHexString:@"333333"];
    _checkEndL.font         = [UIFont systemFontOfSize:17];
    [self addSubview:_checkEndL];
    
    _stateUpL               = [[UILabel alloc] init];
    _stateUpL.font          = [UIFont systemFontOfSize:12];
    _stateUpL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_stateUpL];
    
    _stateDownL             = [[UILabel alloc] init];
    _stateDownL.font        = [UIFont systemFontOfSize:12];
    _stateDownL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_stateDownL];
    
    _stateUpBtn             = [[UIButton alloc] init];
    [_stateUpBtn.titleLabel setTextColor:[UIColor colorWithHexString:@"009dec"]];
    [_stateUpBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_stateUpBtn setTitleColor:[UIColor colorWithHexString:@"009dec"] forState:UIControlStateNormal];
    [_stateUpBtn setImage:ImageIs(@"icon_attence_arrow_pre") forState:UIControlStateNormal];
    [_stateUpBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    [_stateUpBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
    [self addSubview:_stateUpBtn];
    
    _stateDownBtn           = [[UIButton alloc] init];
    [_stateDownBtn.titleLabel setTextColor:[UIColor colorWithHexString:@"009dec"]];
    [_stateDownBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_stateDownBtn setTitleColor:[UIColor colorWithHexString:@"009dec"] forState:UIControlStateNormal];
    [_stateDownBtn setImage:ImageIs(@"icon_attence_arrow_pre") forState:UIControlStateNormal];
    [_stateDownBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    [_stateDownBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
    
    [self addSubview:_stateDownBtn];
    
    CGFloat w                    = 50.f;
    CGFloat h                    = 20.f;
    __weak typeof(self) weakSelf = self;
    [_arrangeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).offset(20);
        make.top.mas_equalTo(weakSelf.mas_top).offset(10);
        make.width.mas_equalTo(w);
        make.height.mas_equalTo(h);
    }];
    [_beginTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.arrangeL.mas_right).offset(13);
        make.centerY.mas_equalTo(weakSelf.arrangeL.mas_centerY);
        make.width.mas_equalTo(w);
        make.height.mas_equalTo(h);
    }];
    [sepV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.beginTimeL.mas_right).offset(2);
        make.centerY.mas_equalTo(weakSelf.arrangeL.mas_centerY);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(1);
    }];
    [_endTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sepV.mas_right).offset(2);
        make.centerY.mas_equalTo(weakSelf.arrangeL.mas_centerY);
        make.width.mas_equalTo(w);
        make.height.mas_equalTo(h);
    }];
    [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.endTimeL.mas_right).offset(20);
        make.centerY.mas_equalTo(weakSelf.arrangeL.mas_centerY);
        make.width.height.mas_equalTo(20);
    }];
    [_workTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.imgV.mas_right).offset(2);
        make.centerY.mas_equalTo(weakSelf.arrangeL.mas_centerY);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(h);
    }];
    [dakaL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.arrangeL.mas_left);
        make.top.mas_equalTo(weakSelf.arrangeL.mas_bottom).offset(14);
        make.width.mas_equalTo(83);
        make.height.mas_equalTo(h);
    }];
    [shangL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dakaL.mas_right).offset(10);
        make.centerY.mas_equalTo(dakaL.mas_centerY);
        make.width.height.mas_equalTo(h);
        ViewBorder(shangL, 1, [UIColor clearColor], h * 0.5);
    }];
    [_checkBeginL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(shangL.mas_right).offset(10);
        make.centerY.mas_equalTo(dakaL.mas_centerY);
        make.width.mas_equalTo(w);
        make.height.mas_equalTo(h);
    }];
    [_stateUpL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.checkBeginL.mas_right).offset(32);
        make.centerY.mas_equalTo(dakaL.mas_centerY);
        make.width.mas_equalTo(w);
        make.height.mas_equalTo(h);
    }];
    [_stateUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.stateUpL.mas_right).offset(40);
        make.centerY.mas_equalTo(dakaL.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(h);
    }];
    [xiaL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(shangL.mas_left);
        make.top.mas_equalTo(shangL.mas_bottom).offset(24);
        make.width.height.mas_equalTo(h);
        ViewBorder(xiaL, 1, [UIColor clearColor], h * 0.5);
    }];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(shangL.mas_left).offset(h * 0.5);
        make.top.mas_equalTo(shangL.mas_bottom);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(24);
    }];
    [_checkEndL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.checkBeginL.mas_left);
        make.centerY.mas_equalTo(xiaL.mas_centerY);
        make.width.mas_equalTo(w);
        make.height.mas_equalTo(h);
    }];
    [_stateDownL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.stateUpL.mas_left);
        make.centerY.mas_equalTo(xiaL.mas_centerY);
        make.width.mas_equalTo(w);
        make.height.mas_equalTo(h);
    }];
    [_stateDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.stateUpBtn.mas_left);
        make.centerY.mas_equalTo(xiaL.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(h);
    }];
}
- (void)setCheckItem:(OCMCheckWorkItem *)checkItem {
    _checkItem              = checkItem;
    _arrangeL.text          = checkItem.arrangeStr;
    _stateUpL.text          = checkItem.stateUpStr;
    _stateDownL.text        = checkItem.stateDownStr;
    UIColor *tempColor      = [checkItem.stateUpStr isEqualToString:@"正常"] ? [UIColor colorWithHexString:@"009dec"] : [UIColor colorWithHexString:@"f95454"];
    _stateUpL.textColor     = tempColor;
    ViewBorder(_stateUpL, 1, tempColor, 5);
    UIColor *tempColor1     = [checkItem.stateDownStr isEqualToString:@"正常"] ? [UIColor colorWithHexString:@"009dec"] : [UIColor colorWithHexString:@"f95454"];
    _stateDownL.textColor   = tempColor1;
    ViewBorder(_stateDownL, 1, tempColor1, 5);
    _beginTimeL.text        = checkItem.beginTimeStr;
    _endTimeL.text          = checkItem.endTimeStr;
    switch (checkItem.imgType) {
        case 1:
            [_imgV setImage:ImageIs(@"icon_attence_office")];
            break;
        case 2:
            [_imgV setImage:ImageIs(@"icon_attence_out")];
            break;
        case 3:
            [_imgV setImage:ImageIs(@"icon_attence_rest")];
            break;
        case 4:
            [_imgV setImage:ImageIs(@"icon_attence_train")];
            break;
        default:
            break;
    }
    _workTypeL.text         = checkItem.workTypeName;
    _checkBeginL.text       = checkItem.beginTimeStr;
    _checkEndL.text         = checkItem.endTimeStr;
    _stateUpBtn.hidden      = checkItem.isBeginNormal ? YES : NO;
    _stateDownBtn.hidden    = checkItem.isEndNormal ? YES : NO;
    [_stateUpBtn setTitle:checkItem.checkUpStr forState:UIControlStateNormal];
    [_stateUpBtn.titleLabel setTintColor:[UIColor colorWithHexString:@"009dec"]];
    [_stateDownBtn setTitle:checkItem.checkDownStr forState:UIControlStateNormal];
    [_stateDownBtn.titleLabel setTintColor:[UIColor colorWithHexString:@"009dec"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma lazyInit

@end
