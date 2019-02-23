//
//  OCMSheetArrangeTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2018/4/23.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMSheetArrangeTableViewCell.h"
#import "OCMSheetArrangeCellItem.h"

@implementation OCMSheetArrangeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self config];
    }
    return self;
}
- (void)config {
    self.label1 = [[UILabel alloc] init];                               //班次x
    [self addSubview:self.label1];
    self.label1.font = [UIFont systemFontOfSize:17];
    self.label1.textColor = [UIColor colorWithHexString:@"666666"];
    
    self.label2 = [[UILabel alloc] init];                               //08:30-12:00
    [self addSubview:self.label2];
    self.label2.textColor = [UIColor colorWithHexString:@"333333"];
    
    self.iconImgV = [[UIImageView alloc] init];                         //图标
    [self addSubview:self.iconImgV];
    
    self.label3 = [[UILabel alloc] init];                               //外出走访
    [self addSubview:self.label3];
    self.label3.textColor = [UIColor colorWithHexString:@"666666"];
    self.label3.text = @"外出走访(政策宣传)";
    
    self.label4 = [[UILabel alloc] init];                               //(政策宣传)
    [self addSubview:self.label4];
    self.label4.textColor = [UIColor colorWithHexString:@"666666"];
    
    self.labelTime = [[UILabel alloc] init];                            //时长:
    [self addSubview:self.labelTime];
    self.labelTime.text = @"时长:";
    self.labelTime.textColor = [UIColor colorWithHexString:@"666666"];
    
    self.label5 = [[UILabel alloc] init];                               //3.5
    [self addSubview:self.label5];
    self.label5.textColor = KRedColor;
    
    self.label6 = [[UILabel alloc] init];                               //小时
    [self addSubview:self.label6];
    self.label6.text = @"小时";
    self.label6.textColor = [UIColor colorWithHexString:@"333333"];
    
    __weak typeof(self) weakSelf = self;
    CGFloat disX = 20.f;
    CGFloat disY = 10.f;
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).offset(disX);
        make.top.mas_equalTo(weakSelf.mas_top).offset(disY);
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).offset(disX);
        make.top.mas_equalTo(weakSelf.label1.mas_bottom).offset(disY);
        make.width.mas_equalTo(104);
        make.height.mas_equalTo(16);
    }];
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.label2.mas_right).offset(disX);
        make.centerY.mas_equalTo(weakSelf.label2.mas_centerY);
        make.width.height.mas_equalTo(20);
    }];
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.iconImgV.mas_right).offset(2);
        make.centerY.mas_equalTo(weakSelf.iconImgV.mas_centerY);
        make.width.mas_equalTo(100);
    }];
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.label3.mas_right).offset(2);
        make.centerY.mas_equalTo(weakSelf.label3.mas_centerY);
    }];
    //布局右侧部分
    [self.label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.mas_right).offset(-disX);
        make.centerY.mas_equalTo(weakSelf.label4.mas_centerY);
    }];
    [self.label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.label6.mas_left);
        make.centerY.mas_equalTo(weakSelf.label6.mas_centerY);
    }];
    [self.labelTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.label5.mas_left);
        make.centerY.mas_equalTo(weakSelf.label5.mas_centerY);
    }];
}
- (void)setItem:(OCMSheetArrangeCellItem *)item {
    _item            = item;
    self.label1.text = [NSString stringWithFormat:@"班次%ld",item.arrangeNumber];
    self.label2.text = [NSString stringWithFormat:@"%@",item.timeStr];
    switch (item.iconType) {
        case 0:
            self.iconImgV.image = ImageIs(@"icon_attence_out");
            break;
        case 1:
            self.iconImgV.image = ImageIs(@"icon_attence_rest");
            break;
        case 2:
            self.iconImgV.image = ImageIs(@"icon_attence_office");
            break;
        case 3:
            self.iconImgV.image = ImageIs(@"icon_attence_train");
            break;
        default:
            break;
    }
    self.label5.text = [self currentArrangeTimeByTimeStr:item.timeStr today:item.today];
}
- (NSString *)currentArrangeTimeByTimeStr:(NSString *)str today:(NSString *)today{
    NSArray      *arr             = [str componentsSeparatedByString:@"-"];
    NSString     *timeStr1        = [NSString stringWithFormat:@"%@ %@:00",today,arr[0]];
    NSString     *timeStr2        = [NSString stringWithFormat:@"%@ %@:00",today,arr[1]];
    NSInteger    timeInt1         = [OCMDate timeSwitchTimestamp:timeStr1 andFormatter:@"YYYY-MM-dd HH:mm:ss"];
    NSInteger    timeInt2         = [OCMDate timeSwitchTimestamp:timeStr2 andFormatter:@"YYYY-MM-dd HH:mm:ss"];
    CGFloat      res              = (timeInt2 - timeInt1) / 3600.f;
    return [NSString stringWithFormat:@"%0.2f",res];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
