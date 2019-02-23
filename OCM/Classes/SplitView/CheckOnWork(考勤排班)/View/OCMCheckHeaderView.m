//
//  OCMCheckHeaderView.m
//  OCM
//
//  Created by 曹均华 on 2018/5/15.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMCheckHeaderView.h"
#import "OCMCalendarItem.h"
#import "OCMCheckWorkItem.h"

@implementation OCMCheckHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}
- (void)config {
    self.dateL                          = [[UILabel alloc] init];
    self.dateL.textColor                = [UIColor colorWithHexString:@"999999"];
    self.dateL.font                     = [UIFont systemFontOfSize:16];
    [self addSubview:self.dateL];
    
    self.arrangeL                       = [[UILabel alloc] init];
    self.arrangeL.textColor             = [UIColor colorWithHexString:@"333333"];
    self.arrangeL.font                  = [UIFont systemFontOfSize:14];
    [self addSubview:self.arrangeL];
    
    self.timeL                          = [[UILabel alloc] init];
    self.timeL.textColor                = [UIColor colorWithHexString:@"333333"];
    self.timeL.font                     = [UIFont systemFontOfSize:14];
    [self addSubview:self.timeL];
    
    UILabel *dakaL                      = [[UILabel alloc] init];
    dakaL.textColor                     = [UIColor colorWithHexString:@"999999"];
    dakaL.text                          = @"打卡时间:";
    dakaL.font                          = [UIFont systemFontOfSize:14];
    [self addSubview:dakaL];
    
    self.circleL                        = [[UILabel alloc] init];
    self.circleL.backgroundColor        = [UIColor RGBColorWithRed:207 withGreen:207 withBlue:107 withAlpha:1.0];
    self.circleL.textColor              = [UIColor whiteColor];
    self.circleL.font                   = [UIFont systemFontOfSize:12];
    self.circleL.textAlignment          = NSTextAlignmentCenter;
    [self addSubview:self.circleL];
    
    self.beginTimeL                     = [[UILabel alloc] init];
    self.beginTimeL.font                = [UIFont systemFontOfSize:14];
    self.beginTimeL.textColor           = [UIColor colorWithHexString:@"333333"];
    [self addSubview:self.beginTimeL];
    
    self.stateL                         = [[UILabel alloc] init];
    self.stateL.textAlignment           = NSTextAlignmentCenter;
    self.stateL.font                    = [UIFont systemFontOfSize:12];
    [self addSubview:self.stateL];
    
    self.imgV                           = [[UIImageView alloc] init];
    [self addSubview:self.imgV];
    __weak typeof(self) weakSelf        = self;
    CGFloat w                           = 50;
    CGFloat h                           = 20;
    [self.dateL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(20);
    }];
    [self.arrangeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.dateL.mas_left);
        make.top.mas_equalTo(weakSelf.dateL.mas_bottom).offset(14);
        make.width.mas_equalTo(w);
        make.height.mas_equalTo(h);
    }];
    [self.timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.arrangeL.mas_centerY);
        make.left.mas_equalTo(weakSelf.arrangeL.mas_right).offset(2);
    }];
    [dakaL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.arrangeL.mas_bottom).offset(14);
        make.left.mas_equalTo(weakSelf.arrangeL.mas_left);
    }];
    [self.circleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(dakaL.mas_centerY);
        make.left.mas_equalTo(dakaL.mas_right).offset(2);
        make.width.height.mas_equalTo(20);
        ViewBorder(weakSelf.circleL, 1, [UIColor clearColor], 10);
    }];
    [self.beginTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.circleL.mas_centerY);
        make.left.mas_equalTo(weakSelf.circleL.mas_right).offset(2);
        make.width.mas_equalTo(w);
        make.height.mas_equalTo(h);
    }];
    [self.stateL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.beginTimeL.mas_centerY);
        make.left.mas_equalTo(weakSelf.beginTimeL.mas_right).offset(20);
        make.width.mas_equalTo(w);
        make.height.mas_equalTo(h);
    }];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-20);
        make.width.height.mas_equalTo(64);
    }];
    
}
- (void)setItem:(OCMCheckWorkItem *)item {
    _item                   = item;
    self.arrangeL.text      = item.arrangeStr;
    self.timeL.text         = [NSString stringWithFormat:@"%@-%@",item.beginTimeStr,item.endTimeStr];
}
- (void)setIsUp:(BOOL)isUp { //需要先设置item,再来设置这个
    _isUp                                   = isUp;
    if (isUp) {
        self.circleL.text                   = @"上";
        self.beginTimeL.text                = self.item.beginTimeStr;
        self.stateL.text                    = self.item.stateUpStr;
        if ([self.stateL.text isEqualToString:@"正常"]) {
            ViewBorder(self.stateL, 1, [UIColor colorWithHexString:@"009dec"], 5);
            self.stateL.textColor           = KBlueColor;
        } else {
            ViewBorder(self.stateL, 1, [UIColor colorWithHexString:@"f95454"], 5);
            self.stateL.textColor           = KRedColor;
        }
        if ([self.item.checkUpStr isEqualToString:@"已审批"]) {
            self.imgV.image                 = ImageIs(@"icon_attence_pass");
        } else {
            self.imgV.image                 = ImageIs(@"icon_attence_refer");
        }
    } else {
        self.circleL.text   = @"下";
        self.beginTimeL.text = self.item.endTimeStr;
        self.stateL.text                    = self.item.stateDownStr;
        if ([self.stateL.text isEqualToString:@"正常"]) {
            ViewBorder(self.stateL, 1, [UIColor colorWithHexString:@"009dec"], 5);
            self.stateL.textColor           = KBlueColor;
        } else {
            ViewBorder(self.stateL, 1, [UIColor colorWithHexString:@"f95454"], 5);
            self.stateL.textColor           = KRedColor;
        }
        if ([self.item.checkDownStr isEqualToString:@"已审批"]) {
            self.imgV.image                 = ImageIs(@"icon_attence_pass");
        } else {
            self.imgV.image                 = ImageIs(@"icon_attence_refer");
        }
    }
}
- (void)setCalendarItem:(OCMCalendarItem *)calendarItem {
    _calendarItem           = calendarItem;
    NSString *currentDate   = [NSString stringWithFormat:@"%ld-%ld-%@",calendarItem.year,calendarItem.month,calendarItem.day];
    self.dateL.text         = currentDate;
}
@end
