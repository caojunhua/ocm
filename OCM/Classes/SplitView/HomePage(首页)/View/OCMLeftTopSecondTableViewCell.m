//
//  OCMLeftTopSecondTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2018/2/2.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMLeftTopSecondTableViewCell.h"

@implementation OCMLeftTopSecondTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self congfig];
    }
    return self;
}
- (void)congfig {
    self.label1 = [[UILabel alloc] init];
    [self addSubview:self.label1];
    self.label1.textColor = [UIColor colorWithHexString:@"333333"];
    self.label1.font = [UIFont systemFontOfSize:14];
    
    self.label2 = [[UILabel alloc] init];
    [self addSubview:self.label2];
    self.label2.textColor = [UIColor colorWithHexString:@"666666"];
    self.label2.font = [UIFont systemFontOfSize:12];
    
    self.label3 = [[UILabel alloc] init];
    [self addSubview:self.label3];
    self.label3.textColor = [UIColor colorWithHexString:@"666666"];
    self.label3.font = [UIFont systemFontOfSize:12];
    
    self.label4 = [[UILabel alloc] init];
    [self addSubview:self.label4];
    self.label4.textColor = [UIColor colorWithHexString:@"666666"];
    self.label4.font = [UIFont systemFontOfSize:12];
    
    self.label5 = [[UILabel alloc] init];
    [self addSubview:self.label5];
    self.label5.textColor = [UIColor colorWithHexString:@"666666"];
    self.label5.font = [UIFont systemFontOfSize:12];
    
    self.label6 = [[UILabel alloc] init];
    [self addSubview:self.label6];
    self.label6.textColor = [UIColor colorWithHexString:@"666666"];
    self.label6.font = [UIFont systemFontOfSize:12];
    
    [self addCons];
}
- (void)addCons {
    __weak typeof(self) weakSelf = self;
    CGFloat leftDis = 15;
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftDis);
        make.top.mas_equalTo(18);
        make.width.mas_equalTo(260);
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftDis);
        make.top.mas_equalTo(weakSelf.label1.mas_bottom).offset(7);
    }];
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.mas_right).offset(-leftDis);
        make.top.mas_equalTo(weakSelf.label2.mas_top);
    }];
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).offset(leftDis);
        make.top.mas_equalTo(weakSelf.label2.mas_bottom).offset(7);
    }];
    [self.label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.label3.mas_left);
        make.top.mas_equalTo(weakSelf.label4.mas_top);
    }];
    [self.label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftDis);
        make.top.mas_equalTo(weakSelf.label4.mas_bottom).offset(7);
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
