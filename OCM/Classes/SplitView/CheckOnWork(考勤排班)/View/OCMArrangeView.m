//
//  OCMArrangeView.m
//  OCM
//
//  Created by 曹均华 on 2018/4/18.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMArrangeView.h"

@implementation OCMArrangeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}
- (void)config {
    self.timeLabel           = [[UILabel alloc] init];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.timeLabel.font      = [UIFont systemFontOfSize:13];
    [self addSubview:self.timeLabel];
    
    self.imgView = [[UIImageView alloc] init];
    
    [self addSubview:self.imgView];
    __weak typeof(self) weakSelf = self;
    CGFloat distanceX = 8.0f;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).offset(distanceX);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(weakSelf.width - 18);
        make.height.mas_equalTo(weakSelf.height);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.mas_right).offset(-distanceX);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
}
- (void)setImgType:(arrangeImgType)imgType {
    switch (imgType) {
        case arrangeImgTypePC://2
            self.imgView.image = ImageIs(@"icon_attence_office");
            break;
        case arrangeImgTypeRun://0
            self.imgView.image = ImageIs(@"icon_attence_out");
            break;
        case arrangeImgTypeLearn://3
            self.imgView.image = ImageIs(@"icon_attence_train");
            break;
        case arrangeImgTypeCoffee://1
            self.imgView.image = ImageIs(@"icon_attence_rest");
            break;
        default:
            break;
    }
}
- (void)setTimeLabel:(UILabel *)timeLabel {
    _timeLabel = timeLabel;
    _timeLabel.text = timeLabel.text;
}
@end
