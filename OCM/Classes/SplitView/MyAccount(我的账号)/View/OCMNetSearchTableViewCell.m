//
//  OCMNetSearchTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2018/3/1.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMNetSearchTableViewCell.h"

@implementation OCMNetSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(CGFloat)width {
//    
//}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(CGFloat)width{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.width = width;
        [self config];
    }
    return self;
}
- (void)config {
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor clearColor];
    [self addSubview:view1];
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    [self addSubview:view2];
    
    for (int i = 0; i < 7; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor colorWithHexString:@"666666"];
        if (i == 0) {
            self.label1 = label;
            self.label1.text = @"网点编号";
        }
        if (i == 1) {
            self.label2 = label;
            self.label2.text = @"网点名称";
        }
        if (i == 2) {
            self.label3 = label;
            self.label3.text = @"星级";
        }
        if (i == 3) {
            self.label4 = label;
            self.label4.text = @"所属镇区";
        }
        if (i == 4) {
            self.label5 = label;
            self.label5.text = @"所属网元";
        }
        if (i == 5) {
            self.label6 = label;
            self.label6.text = @"联系人";
        }
        if (i == 6) {
            self.label7 = label;
            self.label7.text = @"联系方式";
        }
        [self addSubview:label];
    }
    
    
    __weak typeof(self) weakSelf = self;
    CGFloat w1 = 70;
    CGFloat h = 20;
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.top.mas_equalTo(weakSelf.mas_top);
        make.height.mas_equalTo(1);
    }];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(w1);
        make.height.mas_equalTo(h);
    }];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.centerX.mas_equalTo(weakSelf.mas_left).offset(55);
        make.width.mas_equalTo(w1);
        make.height.mas_equalTo(h);
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.centerX.mas_equalTo(weakSelf.mas_left).offset(0.25 * self.width);
        make.width.mas_equalTo(w1);
        make.height.mas_equalTo(h);
    }];
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.centerX.mas_equalTo(weakSelf.mas_left).offset(17.0/40 * self.width);
        make.width.mas_equalTo(w1 * 0.5);
        make.height.mas_equalTo(h);
    }];
    [self.label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.centerX.mas_equalTo(weakSelf.mas_right).offset(-75);
        make.width.mas_equalTo(w1);
        make.height.mas_equalTo(h);
    }];
    [self.label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.centerX.mas_equalTo(weakSelf.label4.mas_right).offset(0.1 * self.width);
        make.width.mas_equalTo(w1);
        make.height.mas_equalTo(h);
    }];
    [self.label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.centerX.mas_equalTo(weakSelf.label4.mas_right).offset(0.25 * self.width);
        make.width.mas_equalTo(w1 * 0.75);
        make.height.mas_equalTo(h);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
