//
//  MasterTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2017/11/30.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMMasterTableViewCell.h"

@implementation OCMMasterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        {
            self.imgView = [[UIImageView alloc] init];
            [self addSubview:self.imgView];
        }
        
        {
            self.label = [[UILabel alloc] init];
            self.label.textColor = [UIColor RGBColorWithRed:254 withGreen:254 withBlue:254 withAlpha:1.0];
            [self addSubview:self.label];
        }
        
        {
            self.sepView = [[UIView alloc] init];
            self.sepView.backgroundColor = [UIColor clearColor];
            [self addSubview:self.sepView];
        }
        [self setUpLayout];
    }
//    self.selectionStyle = UITableViewCellSelectionStyleGray;
    return self;
}
- (void)setUpLayout {
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.mas_equalTo(0);
//        make.width.height.mas_equalTo(self.contentView.height );
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView.mas_right).offset(25);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(self.contentView.height * 0.8);
    }];
    [self.sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    self.contentView.backgroundColor = [UIColor whiteColor];
    // Configure the view for the selected state
}

@end
