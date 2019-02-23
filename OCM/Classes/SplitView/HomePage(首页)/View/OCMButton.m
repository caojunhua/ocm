//
//  OCMButton.m
//  OCM
//
//  Created by 曹均华 on 2017/12/15.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMButton.h"

@interface OCMButton ()
@property (nonatomic,weak)id target;
@property (nonatomic,assign)SEL action;
@end

@implementation OCMButton
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.iconImgV = [[UIImageView alloc] init];
        [self addSubview:self.iconImgV];
        
        self.detailLabel = [[UILabel alloc] init];
//        self.detailLabel.layer.cornerRadius = _detailLabel.width * 0.5;
//        self.detailLabel.layer.masksToBounds = YES;
        [self addSubview:self.detailLabel];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:self.nameLabel];
        
        __weak typeof(self) weakSelf = self;
        [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf);
            make.height.width.mas_equalTo(20);
            make.top.mas_equalTo(weakSelf);
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.iconImgV.mas_top);
            make.centerX.mas_equalTo(weakSelf.iconImgV.mas_right);
            make.height.width.mas_equalTo(10);
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf);
            make.top.mas_equalTo(weakSelf.iconImgV.mas_bottom).offset(4);
        }];
    }
    return self;
}
- (void)setDetailLabel:(UILabel *)detailLabel {
    _detailLabel = detailLabel;
    _detailLabel.font = [UIFont systemFontOfSize:8];
    _detailLabel.backgroundColor = [UIColor colorWithHexString:@"#f64b30"];
    _detailLabel.textAlignment = NSTextAlignmentCenter;
    _detailLabel.layer.cornerRadius = 5;
    _detailLabel.layer.masksToBounds = YES;
}

@end
