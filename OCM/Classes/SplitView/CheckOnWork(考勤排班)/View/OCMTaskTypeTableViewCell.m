//
//  OCMTaskTypeTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2018/5/7.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMTaskTypeTableViewCell.h"
#import "OCMTaskTypeItem.h"

@implementation OCMTaskTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self config];
    }
    return self;
}
- (void)config {
    _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 20, 20)];
    [self addSubview:_imgV];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(32, 14, 72, 16)];
    [self addSubview:_label];
}
- (void)setItem:(OCMTaskTypeItem *)item {
    _item = item;
    switch (item.imgType) {
        case 1:
            [_imgV setImage:ImageIs(@"icon_attence_office")];
            break;
        case 2:
            [_imgV setImage:ImageIs(@"icon_attence_out")];
            break;
        case 3:
            [_imgV setImage:ImageIs(@"icon_attence_rest")];
            break;
        case 4:
            [_imgV setImage:ImageIs(@"icon_attence_train")];
            break;
        default:
            break;
    }
    _label.text = item.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
