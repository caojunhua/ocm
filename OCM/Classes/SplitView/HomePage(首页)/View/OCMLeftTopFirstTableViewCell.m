//
//  OCMLeftTopFirstTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2017/12/18.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMLeftTopFirstTableViewCell.h"

@implementation OCMLeftTopFirstTableViewCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        _titleL = [UILabel new];
//        _titleL.font = [UIFont systemFontOfSize:14];
//        [self addSubview:_titleL];
//        
//        _detailL = [UILabel new];
//        _detailL.font = [UIFont systemFontOfSize:14];
//        [self addSubview:_detailL];
//        
//        __weak typeof(self) weakSelf = self;
//        [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.mas_equalTo(weakSelf).mas_offset(5);
//            make.width.mas_equalTo(kLeftTopWidth - 20);
//        }];
//        [_detailL mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(weakSelf.titleL.mas_bottom).mas_offset(5);
//            make.left.mas_equalTo(weakSelf).mas_offset(10);
//            make.width.mas_equalTo(kLeftTopWidth - 20);
//        }];
//    }
//    return self;
//}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        OCMLeftTopFirstTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"OCMLeftTopFirstTableViewCell" owner:self options:nil] objectAtIndex:0];
        cell.frame = frame;
        [self addSubview:cell];
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
