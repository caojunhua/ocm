//
//  OCMInfoGetTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2018/1/26.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMInfoGetTableViewCell.h"

@implementation OCMInfoGetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label1 = [[UILabel alloc] init];
        self.label1.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.label1];
        
        self.label2 = [[UILabel alloc] init];
        self.label2.textAlignment = NSTextAlignmentRight;
        self.label2.hidden = YES;
        [self addSubview:self.label2];
        
        self.iconView = [[UIImageView alloc] initWithImage:ImageIs(@"icon_inforeward_right")];
        [self addSubview:self.iconView];
        
        self.annoView = [[UIImageView alloc] initWithImage:ImageIs(@"hollow_red_net")];
        self.annoView.hidden = YES;
        [self addSubview:self.annoView];
        
        self.switchBtn = [[UISwitch alloc] init];
        self.switchBtn.onTintColor = [UIColor colorWithHexString:@"009dec"];
        self.switchBtn.hidden = YES;
        [self addSubview:self.switchBtn];
        
        __weak typeof(self) weakSelf = self;
        CGFloat Dis = 30.;
        CGFloat Dis1 = 15.;
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
            make.left.mas_equalTo(Dis);
        }];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
            make.right.mas_equalTo(weakSelf.mas_right).offset(-Dis);
        }];
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.iconView.mas_left).offset(-Dis1);
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
        }];
        [self.annoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
            make.right.mas_equalTo(weakSelf.iconView.mas_left).offset(-Dis1);
        }];
        [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
            make.right.mas_equalTo(weakSelf.iconView.mas_left).offset(-Dis1);
        }];
        //分割线
        UIView *sepV = [[UIView alloc] initWithFrame:CGRectMake(0, 49, 1000, 1)];
        sepV.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        [self addSubview:sepV];
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
