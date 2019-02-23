//
//  OCMSettingTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2018/1/2.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMSettingTableViewCell.h"

@implementation OCMSettingTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat dis = 50;
        __weak typeof(self) weakSelf = self;
        self.titleL = [[UILabel alloc] init];
        self.titleL.centerY = self.centerY;
        self.titleL.font = [UIFont systemFontOfSize:17];
        self.titleL.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:self.titleL];
        [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(dis);
            make.centerY.mas_equalTo(weakSelf);
        }];
        
        self.switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.switchBtn.onTintColor = [UIColor colorWithHexString:@"#009dec"];
        self.switchBtn.hidden = YES;
        [self addSubview:self.switchBtn];
        
        [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
            make.right.mas_equalTo(weakSelf.mas_right).offset(-50);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(30);
        }];
        
        self.textL = [[UILabel alloc] init];
        self.textL.hidden = YES;
        [self.contentView addSubview:self.textL];
        [self.textL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
            make.right.mas_equalTo(weakSelf.mas_right).offset(-50);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(30);
        }];
        
        _sepV = [[UIView alloc] init];
        _sepV.hidden = YES;
        _sepV.backgroundColor = [UIColor colorWithHexString:@"#999999"];
        [self addSubview:_sepV];
        [_sepV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(weakSelf);
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(weakSelf).offset(1);
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
