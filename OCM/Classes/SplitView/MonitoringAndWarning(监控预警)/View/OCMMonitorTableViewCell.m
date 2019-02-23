//
//  OCMMonitorTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2018/1/24.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMMonitorTableViewCell.h"

@implementation OCMMonitorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat h = self.height * 0.3;
        CGFloat w = 105;
        __weak typeof(self) weakSelf = self;
        for (int i = 0; i < 5; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor colorWithHexString:@"#333333"];
            label.font = [UIFont systemFontOfSize:15];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            switch (i) {
                case 0:
                    self.label1 = label;
                    break;
                case 1:
                    self.label2 = label;
                    break;
                case 2:
                    self.label3 = label;
                    break;
                case 3:
                    self.label4 = label;
                    break;
                case 4:
                    self.label5 = label;
                    break;
                default:
                    break;
            }
        }
        UIView *sepV = [[UIView alloc] initWithFrame:CGRectMake(0, 49, screenWidth, 1)];
        [self addSubview:sepV];
        sepV.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(w, h));
            make.left.mas_equalTo(weakSelf.left).offset(25);
        }];
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(w, h));
            make.left.mas_equalTo(weakSelf.label1.mas_right);
        }];
        [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(w, h));
            make.left.mas_equalTo(weakSelf.label2.mas_right);
        }];
        [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(w, h));
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
        }];
        [self.label5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
            make.left.mas_equalTo(weakSelf.label4.mas_right);
            make.right.mas_equalTo(weakSelf.mas_right);
            make.height.mas_equalTo(h);
        }];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
