//
//  FiltrationTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2018/3/19.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "FiltrationTableViewCell.h"

@implementation FiltrationTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView = [[UIImageView alloc] init];
        self.imgView.image = ImageIs(@"btn_task_right");
        [self addSubview:self.imgView];
        self.imgView.hidden = YES;
        
        __weak typeof(self) weakSelf = self;
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(13);
            make.height.mas_equalTo(10);
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
            make.right.mas_equalTo(weakSelf.mas_right).offset(-14);
        }];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    if (selected) {
//        self.imgView.hidden = NO;
//    }
//    else {
//        self.imgView.hidden = YES;
//    }
}

@end
