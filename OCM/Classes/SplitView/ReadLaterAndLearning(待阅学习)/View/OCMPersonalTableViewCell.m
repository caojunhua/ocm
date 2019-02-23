//
//  OCMPersonalTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2018/1/29.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMPersonalTableViewCell.h"

@implementation OCMPersonalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bluePointImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 5, 5)];
        UIImage *image = [UIImage createImageWithColor:[UIColor blueColor]];
        self.bluePointImg.image = image;
        ViewBorder(self.bluePointImg, 1, [UIColor clearColor], 2.5);
        [self addSubview:self.bluePointImg];
        
        self.titleLabel = [[UILabel alloc] init];
        [self addSubview:self.titleLabel];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        
        self.nameLabel = [[UILabel alloc] init];
        [self addSubview:self.nameLabel];
        self.nameLabel.textColor = [UIColor colorWithHexString:@"999999"];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        
        self.timeLabel = [[UILabel alloc] init];
        [self addSubview:self.timeLabel];
        self.timeLabel.textColor = [UIColor colorWithHexString:@"999999"];
        self.timeLabel.font = [UIFont systemFontOfSize:15];
        
        self.detailLabel = [[UILabel alloc] init];
        [self addSubview:self.detailLabel];
        self.detailLabel.textColor = [UIColor colorWithHexString:@"999999"];
        self.detailLabel.font = [UIFont systemFontOfSize:15];
        self.detailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        __weak typeof(self) weakSelf = self;
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.bluePointImg.mas_centerY);
            make.left.mas_equalTo(weakSelf.bluePointImg).offset(5);
//            make.size.mas_equalTo(CGSizeMake(500, 20));
        }];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.bluePointImg.mas_centerY);
            make.right.mas_equalTo(weakSelf.right).offset(-15);
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.bluePointImg.mas_centerY);
            make.right.mas_equalTo(weakSelf.timeLabel.mas_left).offset(-50);
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.bluePointImg.mas_left);
            make.right.mas_equalTo(weakSelf).offset(-15);
            make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(10);
        }];
        ViewBorder(self, 1, [UIColor clearColor], 5);
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
