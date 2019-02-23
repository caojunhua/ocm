//
//  OCMTaskListCellTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2017/12/7.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMTaskListTableViewCell.h"
#import "TaskListItem.h"

@implementation OCMTaskListTableViewCell
{
    UILabel *_titleL;
    UILabel *_publishL;
    UILabel *_progressL;
    UILabel *_rateL;
    UILabel *_taskTypeL;
    UIImageView *_iconV;
    UIView *_sepV;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        {
            _titleL = [[UILabel alloc] init];
            [self addSubview:_titleL];
        }
        {
            _publishL = [[UILabel alloc] init];
            [self addSubview:_publishL];
        }
        {
            _progressL = [[UILabel alloc] init];
            [self addSubview:_progressL];
        }
        {
            _rateL = [[UILabel alloc] init];
            [self addSubview:_rateL];
        }
        {
            _taskTypeL = [[UILabel alloc] init];
            _taskTypeL.textColor = [UIColor randomColor];
            ViewBorder(_taskTypeL, 0.5, [UIColor grayColor], 3);
            [self addSubview:_taskTypeL];
        }
        {
            _iconV = [[UIImageView alloc] init];
            _iconV.image = [UIImage imageNamed:@"xiala"];
            _iconV.transform = CGAffineTransformRotate(_iconV.transform, -M_PI_2);
            [self addSubview:_iconV];
        }
        {
            _sepV = [[UIView alloc] init];
            _sepV.backgroundColor = [UIColor grayColor];
            [self addSubview:_sepV];
        }
        [self setUpLayout];
    }
    return self;
}
- (void)setUpLayout {
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(25);
    }];
    [_publishL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(_titleL.mas_bottom).offset(10);
    }];
    [_progressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(220);
        make.top.mas_equalTo(_titleL.mas_bottom).offset(10);
    }];
    [_rateL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-180);
    }];
    [_taskTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-50);
    }];
    [_iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-10);
    }];
    [_sepV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(self);
    }];
}
- (void)setItem:(TaskListItem *)item {
    _item = item;
    _titleL.text = item.title;
    _publishL.text = [NSString stringWithFormat:@"发布时间:%@",item.publishTime];
    _progressL.text = [NSString stringWithFormat:@"完成进度:%@",item.progress];
    _rateL.text = [NSString stringWithFormat:@"完成率:%@",item.rate];
    _taskTypeL.text = item.taskType;
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
