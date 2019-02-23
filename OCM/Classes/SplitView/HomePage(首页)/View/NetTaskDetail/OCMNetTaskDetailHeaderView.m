//
//  OCMNetTaskDetailHeaderView.m
//  OCM
//
//  Created by JianFeng_Ma on 2018/4/17.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMNetTaskDetailHeaderView.h"
#import "OCMNetTaskDetailModel.h"
#import "Helper.h"
@interface OCMNetTaskDetailHeaderView()
/** 网点名称*/
@property (nonatomic,strong)UILabel *netNameLab;
/** 网元暂不使用*/
@property (nonatomic,strong)UILabel *netElementNameLab;
/** 任务类型*/
@property (nonatomic,strong)UILabel *taskTypeLab;
/** 是否需要签到*/
@property (nonatomic,strong)UILabel *signInLab;
/** 是否需要拍照*/
@property (nonatomic,strong)UILabel *photoLab;
/** 是否需要反馈*/
@property (nonatomic,strong)UILabel *feedBackLab;
/** 上一任务*/
@property (nonatomic,strong)UIButton *preButton;
/** 下一任务*/
@property (nonatomic,strong)UIButton *nextButton;
/** 状态图标*/
@property (nonatomic,strong)UIImageView *statusImageView;
/** 完成时间*/
@property (nonatomic,strong)UILabel *finishTimeLab;
/** 任务主题*/
@property (nonatomic,strong)UILabel *themeLab;
/** 任务开始时间*/
@property (nonatomic,strong)UILabel *startTimeLab;
/** 任务结束时间*/
@property (nonatomic,strong)UILabel *endTimeLab;

/** model*/
@property (nonatomic,strong)OCMNetTaskDetailModel *model;

@end

@implementation OCMNetTaskDetailHeaderView

- (void)setModel:(OCMNetTaskDetailModel *)model{
    _model = model;
    self.themeLab.text = model.taskName;
    self.startTimeLab.text = model.beginDay;
    self.endTimeLab.text = model.endDay;
    self.taskTypeLab.text = model.taskType;
    self.netNameLab.text = [NSString stringWithFormat:@"%@(%@)",model.chName,model.chId];
    
    if (![model.needSign boolValue]) {
        [self.signInLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, 25));
        }];
    }
    if (![model.needPhoto boolValue]) {
        [self.photoLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, 25));
        }];
    }
    if (![model.needFeedback boolValue]) {
        [self.feedBackLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, 25));
        }];
    }
    
    /** 重新设置frame*/
    self.frame = CGRectMake(0, 0, screenWidth - kLeftBigWidth, 200+[Helper heightOfString:model.taskName font:[UIFont systemFontOfSize:20] width:458]);
}

- (void)setUp{
    __weak typeof(self) weakSelf = self;
    [self.netNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.top.offset(25);
        make.height.mas_equalTo(19);
    }];
    
    [self.taskTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.netNameLab.mas_right).offset(10);
        make.centerY.mas_equalTo(weakSelf.netNameLab);
        make.height.mas_equalTo(22);
    }];
    
    [self.signInLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.top.equalTo(weakSelf.netNameLab.mas_bottom).offset(45);
        make.size.mas_equalTo(CGSizeMake(52, 25));
    }];
    
    [self.photoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.signInLab.mas_right).offset(10);
        make.centerY.mas_equalTo(weakSelf.signInLab);
        make.size.mas_equalTo(CGSizeMake(52, 25));
    }];
    
    [self.feedBackLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.photoLab.mas_right).offset(10);
        make.centerY.mas_equalTo(weakSelf.signInLab);
        make.size.mas_equalTo(CGSizeMake(52, 25));
    }];
    
    [self.statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(25);
        make.right.offset(-25);
        make.size.mas_equalTo(CGSizeMake(55, 46));
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(25);
        make.centerY.mas_equalTo(weakSelf.signInLab);
        make.size.mas_equalTo(CGSizeMake(65, 25));
    }];
    
    [self.preButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.nextButton.mas_left).offset(-15);
        make.centerY.mas_equalTo(weakSelf.signInLab);
        make.size.mas_equalTo(CGSizeMake(65, 25));
    }];
    
    [self.themeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nextButton.mas_bottom).offset(30);
        make.centerX.mas_equalTo(weakSelf);
        make.width.mas_equalTo(458);
    }];
    
    [self.startTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leftMargin.mas_equalTo(weakSelf.themeLab.mas_leftMargin);
        make.height.mas_equalTo(18);
        make.top.equalTo(weakSelf.themeLab.mas_bottom).offset(15);
        make.left.offset(80);
    }];
    
    [self.endTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(18);
//        make.top.equalTo(weakSelf.themeLab.mas_bottom).offset(15);
        make.centerY.mas_equalTo(weakSelf.startTimeLab);
        make.right.offset(-80);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

#pragma mark --
#pragma mark 懒加载

- (UILabel *)netNameLab{
    if (!_netNameLab) {
        _netNameLab = [UILabel new];
        _netNameLab.textColor = UIColorFromRGB(0x333333);
        _netNameLab.font = [UIFont systemFontOfSize:17];
        [self addSubview:_netNameLab];
    }
    return _netNameLab;
}

- (UILabel *)taskTypeLab{
    if (!_taskTypeLab) {
        _taskTypeLab = [UILabel new];
        _taskTypeLab.textColor = UIColorFromRGB(0x009dec);
        _taskTypeLab.font = [UIFont systemFontOfSize:12];
        _taskTypeLab.layer.borderWidth = 0.5;
        _taskTypeLab.layer.borderColor = UIColorFromRGB(0x009dec).CGColor;
        _taskTypeLab.layer.masksToBounds = YES;
        _taskTypeLab.layer.cornerRadius = 3;
        [self addSubview:_taskTypeLab];
    }
    return _taskTypeLab;
}

- (UILabel *)signInLab{
    if (!_signInLab) {
        _signInLab = [UILabel new];
        _signInLab.font = [UIFont systemFontOfSize:15];
        _signInLab.textColor = UIColorFromRGB(0xf9f9f9);
        _signInLab.textAlignment = NSTextAlignmentCenter;
        _signInLab.layer.masksToBounds = YES;
        _signInLab.backgroundColor = UIColorFromRGB(0xf3f2f2);
        _signInLab.layer.cornerRadius = 3;
        _signInLab.text = @"签到";
        [self addSubview:_signInLab];
    }
    return _signInLab;
}

- (UILabel *)photoLab{
    if (!_photoLab) {
        _photoLab = [UILabel new];
        _photoLab.font = [UIFont systemFontOfSize:15];
        _photoLab.textColor = UIColorFromRGB(0xf9f9f9);
        _photoLab.textAlignment = NSTextAlignmentCenter;
        _photoLab.layer.masksToBounds = YES;
        _photoLab.backgroundColor = UIColorFromRGB(0xf3f2f2);
        _photoLab.layer.cornerRadius = 3;
        _photoLab.text = @"拍照";
        [self addSubview:_photoLab];
    }
    return _photoLab;
}

- (UILabel *)feedBackLab{
    if (!_feedBackLab) {
        _feedBackLab = [UILabel new];
        _feedBackLab.font = [UIFont systemFontOfSize:15];
        _feedBackLab.textColor = UIColorFromRGB(0xf9f9f9);
        _feedBackLab.textAlignment = NSTextAlignmentCenter;
        _feedBackLab.layer.masksToBounds = YES;
        _feedBackLab.backgroundColor = UIColorFromRGB(0xf3f2f2);
        _feedBackLab.layer.cornerRadius = 3;
        _feedBackLab.text = @"反馈";
        [self addSubview:_feedBackLab];
    }
    return _feedBackLab;
}

- (UIButton *)preButton{
    if (!_preButton) {
        _preButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _preButton.backgroundColor = UIColorFromRGB(0x13adec);
        [_preButton setTitle:@"上一任务" forState:UIControlStateNormal];
        _preButton.layer.masksToBounds = YES;
        _preButton.layer.cornerRadius = 3;
        _preButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_preButton];
    }
    return _preButton;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.backgroundColor = UIColorFromRGB(0x13adec);
        [_nextButton setTitle:@"下一任务" forState:UIControlStateNormal];
        _nextButton.layer.masksToBounds = YES;
        _nextButton.layer.cornerRadius = 3;
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_nextButton];
    }
    return _nextButton;
}

- (UIImageView *)statusImageView{
    if (!_statusImageView) {
        _statusImageView = [UIImageView new];
        [self addSubview:_statusImageView];
    }
    return _statusImageView;
}

- (UILabel *)finishTimeLab{
    if (!_finishTimeLab) {
        _finishTimeLab = [UILabel new];
        [self addSubview:_finishTimeLab];
    }
    return _finishTimeLab;
}

- (UILabel *)themeLab{
    if (!_themeLab) {
        _themeLab = [UILabel new];
        _themeLab.textColor = UIColorFromRGB(0x333333);
        _themeLab.textAlignment = NSTextAlignmentCenter;
        _themeLab.numberOfLines = 0;
        _themeLab.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:_themeLab];
    }
    return _themeLab;
}

- (UILabel *)startTimeLab{
    if (!_startTimeLab) {
        _startTimeLab = [UILabel new];
        _startTimeLab.textColor = UIColorFromRGB(0x999999);
        _startTimeLab.font = [UIFont systemFontOfSize:16];
        [self addSubview:_startTimeLab];
    }
    return _startTimeLab;
}

- (UILabel *)endTimeLab{
    if (!_endTimeLab) {
        _endTimeLab = [UILabel new];
        _endTimeLab.textColor = UIColorFromRGB(0x999999);
        _endTimeLab.font = [UIFont systemFontOfSize:16];
        [self addSubview:_endTimeLab];
    }
    return _endTimeLab;
}
@end
