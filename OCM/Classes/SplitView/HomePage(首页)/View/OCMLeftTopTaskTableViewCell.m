//
//  OCMLeftTopTaskTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2018/3/22.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMLeftTopTaskTableViewCell.h"

@implementation OCMLeftTopTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        OCMLeftTopTaskTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"OCMLeftTopTaskTableViewCell" owner:self options:nil] objectAtIndex:0];
        cell.frame = frame;
        [self addSubview:cell];
    }
    return self;
}
@end
