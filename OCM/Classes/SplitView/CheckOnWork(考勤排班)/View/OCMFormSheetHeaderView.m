//
//  OCMFormSheetHeaderView.m
//  OCM
//
//  Created by 曹均华 on 2018/4/20.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMFormSheetHeaderView.h"

@implementation OCMFormSheetHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        [self config];
    }
    return self;
}
- (void)config {
    self.dateLabel                           = [[UILabel alloc] init];
    [self addSubview: self.dateLabel];
    
    self.statusLabel                         = [[UILabel alloc] init];
    self.statusLabel.textColor               = KRedColor;
    [self addSubview:self.statusLabel];
    
    self.rightV                              = [[UIView alloc] init];
    [self addSubview:self.rightV];
    
    self.label1                              = [[UILabel alloc] init];
    self.label1.text                         = @"总时长:";
    self.label1.font                         = [UIFont systemFontOfSize:12];
    [self.rightV addSubview:self.label1];
    
    self.realityTimeL                        = [[UILabel alloc] init];
    self.realityTimeL.textColor              = KRedColor;
    self.realityTimeL.font                   = [UIFont systemFontOfSize:12];
    [self.rightV addSubview:self.realityTimeL];
    
    self.label2                              = [[UILabel alloc] init];
    self.label2.text                         = @"小时";
    self.label2.font                         = [UIFont systemFontOfSize:12];
    [self.rightV addSubview:self.label2];
    
    CGFloat disX = 20.;
    __weak typeof(self) weakSelf = self;
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(disX);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.dateLabel.mas_right).offset(2);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
    [self.rightV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-disX);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
    
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.rightV.mas_right).offset(-disX);
        make.centerY.mas_equalTo(weakSelf.rightV.mas_centerY);
    }];
    [self.realityTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.label2.mas_left).offset(-1);
        make.centerY.mas_equalTo(weakSelf.rightV.mas_centerY);
    }];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.realityTimeL.mas_left).offset(-1);
        make.centerY.mas_equalTo(weakSelf.rightV.mas_centerY);
    }];
}
@end
