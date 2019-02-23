//
//  ReadLeftTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2017/12/6.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "ReadLeftTableViewCell.h"
#import "ReadLeftSubItem.h"

@interface ReadLeftTableViewCell()
@property (nonatomic,assign)BOOL isOpen;//是否展开
@end

@implementation ReadLeftTableViewCell
{
    //父级cell需要的控件
//    UIImageView *_iconView;
    UILabel *_textL;
    //子级cell需要的控件
    UIImageView *_leftIconView;
    UILabel *_titleL;
    UILabel *_autherL;
    UILabel *_dateL;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        {
            _textL = [[UILabel alloc] init];
            [self addSubview:_textL];
        }
        {
            _iconView = [[UIImageView alloc] init];
            [self addSubview:_iconView];
        }
        /***********************分割线**************************/
        {
            _leftIconView = [[UIImageView alloc] init];
            [self addSubview:_leftIconView];
        }
        {
            _titleL = [[UILabel alloc] init];
            [self addSubview:_titleL];
        }
        {
            _autherL = [[UILabel alloc] init];
            [self addSubview:_autherL];
        }
        {
            _dateL = [[UILabel alloc] init];
            [self addSubview:_dateL];
        }
        [self setUpLayout];
        [self setUpSubLayout];
    }
    return self;
}
- (void)setUpLayout {
    [_textL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(self.contentView.height * 0.8);
    }];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(self.contentView.height * 0.8);
    }];
}
- (void)setUpSubLayout {
    [_leftIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(5);
        make.width.height.mas_equalTo(10);
    }];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_leftIconView.mas_right).offset(5);
        make.top.mas_equalTo(_leftIconView);
        make.right.mas_equalTo(-10);
    }];
    [_autherL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleL.mas_left);
        make.top.mas_equalTo(_titleL.mas_bottom).offset(5);
    }];
    [_dateL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_autherL.mas_bottom).offset(5);
        make.right.mas_equalTo(-5);
    }];
}
- (void)setItem:(ReadLeftSubItem *)item {
    _item = item;
    
    if (!item.isParentCell) {
        _leftIconView.image = [UIImage createImageWithColor:[UIColor blueColor]];
        _titleL.text = item.title;
        _autherL.text = item.auther;
        _dateL.text = item.dateStr;
    } else {
        _textL.text = item.bigTitle;
        _iconView.image = [UIImage imageNamed:@"icon11"];
    }
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    OCMLog(@"点击了setSelected");
//        self.contentView.backgroundColor = [UIColor redColor];
    // Configure the view for the selected state
}
@end
