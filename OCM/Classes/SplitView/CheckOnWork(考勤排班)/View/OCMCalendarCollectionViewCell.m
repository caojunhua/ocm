//
//  OCMCalendarCollectionViewCell.m
//  OCM
//
//  Created by 曹均华 on 2018/4/12.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMCalendarCollectionViewCell.h"
#import "OCMCalendarItem.h"
#import "OCMArrangeView.h"

@interface OCMCalendarCollectionViewCell()

@end

@implementation OCMCalendarCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(8, 4, 28, 28)];
        self.label.textAlignment = NSTextAlignmentCenter;
        
        self.isTodayPoint                     = [[UIView alloc] initWithFrame:CGRectMake(20, 34, 8, 8)];
        self.isTodayPoint.layer.cornerRadius  = 4;
        self.isTodayPoint.layer.masksToBounds = YES;
        self.isTodayPoint.backgroundColor     = KBlueColor;
        
        CGFloat leftDis                       = 4.;
        self.arrangeOneView                   = [[OCMArrangeView alloc] initWithFrame:CGRectMake(leftDis, 40, self.width - 8, 20)];
        self.arrangeTwoView                   = [[OCMArrangeView alloc] initWithFrame:CGRectMake(leftDis, 65, self.width - 8, 20)];
        self.arrangeThreeView                 = [[OCMArrangeView alloc] initWithFrame:CGRectMake(leftDis, 90, self.width - 8, 20)];
        self.arrangeFourView                  = [[OCMArrangeView alloc] initWithFrame:CGRectMake(leftDis, 115, self.width - 8, 20)];
        
        CGFloat labelY                        = (self.height > 135.0) ? 115. : 90. ;
        self.leastSomeArrangeLabel            = [[UILabel alloc] initWithFrame:CGRectMake(14, labelY, self.width - 8, 20)];
        self.leastSomeArrangeLabel.textColor  = [UIColor colorWithHexString:@"999999"];
        self.leastSomeArrangeLabel.font       = self.height < 135 ? [UIFont systemFontOfSize:12] : [UIFont systemFontOfSize:14];
        self.arrangeOneView.timeLabel.font    = self.height < 135 ? [UIFont systemFontOfSize:12] : [UIFont systemFontOfSize:16];
        self.arrangeTwoView.timeLabel.font    = self.height < 135 ? [UIFont systemFontOfSize:12] : [UIFont systemFontOfSize:16];
        self.arrangeThreeView.timeLabel.font  = self.height < 135 ? [UIFont systemFontOfSize:12] : [UIFont systemFontOfSize:16];
        self.arrangeFourView.timeLabel.font   = self.height < 135 ? [UIFont systemFontOfSize:12] : [UIFont systemFontOfSize:16];
        
        self.iconTypeArr                      = [NSMutableArray array];
    }
    return self;
}
- (void)setCalendarItem:(OCMCalendarItem *)calendarItem {
    _calendarItem = calendarItem;
}
- (void)setSelected:(BOOL)selected {
    if (selected) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage createImageWithColor:[UIColor whiteColor]]];
        ViewBorder(imgView, 1, [UIColor colorWithHexString:@"009dec"], 0);
        self.backgroundView  = imgView;
    } else {
        self.backgroundView  = nil;
    }
}
#pragma mark -- 第一种布局  --->考勤布局
- (void)configFirstStylewithItem {
    if (self.view.subviews) {
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
            obj = nil;
        }];
    }
    self.label.text = self.calendarItem.day;
    if ([self.calendarItem.day isEqualToString:@""]) {
        return;
    }
    self.label.layer.cornerRadius  = self.label.width * 0.5;
    self.label.layer.masksToBounds = YES;
    self.label.textColor           = [UIColor whiteColor];
    if (self.calendarItem.isToday) {
        [self addSubview:self.isTodayPoint];
    }
    switch (self.calendarItem.textColor) {
        case textColorNone:
            self.label.backgroundColor     = [UIColor whiteColor];
            self.label.textColor           = [UIColor blackColor];
            break;
        case textColorRed:
            self.label.backgroundColor     = KRedColor;
            break;
        case textColorOrange:
            self.label.backgroundColor     = KOrangeColor;
            break;
        case textColorBlue:
            self.label.backgroundColor     = KBlueColor;
            break;
        default:
            break;
    }
    
    //添加所需要的视图
    [self addSubview:self.label]; //添加label
    [self addAnimaiton];
}
#pragma mark -- 第二种布局   --->排班布局
- (void)configSecondStylewithItem {
    if (self.view.subviews) {
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
            obj = nil;
        }];
    }
    self.label.text = self.calendarItem.day;
    if ([self.calendarItem.day isEqualToString:@""]) {
        return;
    }
    self.label.layer.cornerRadius  = self.label.width * 0.5;
    self.label.layer.masksToBounds = YES;
    self.label.textColor           = [UIColor whiteColor];
    if (self.calendarItem.isToday) {
//        self.isTodayPoint.hidden = NO;
        [self addSubview:self.isTodayPoint];
    }
    switch (self.
            calendarItem.textColor) {
        case textColorNone:
            self.label.backgroundColor     = [UIColor whiteColor];
            self.label.textColor           = [UIColor blackColor];
            break;
        case textColorRed:
            self.label.backgroundColor     = KRedColor;
            break;
        case textColorOrange:
            self.label.backgroundColor     = KOrangeColor;
            break;
        case textColorBlue:
            self.label.backgroundColor     = KBlueColor;
            break;
        default:
            break;
    }
    
    //关于班次
    switch (self.calendarItem.arrangeInToday.count) {
        case 0:
//            self.leastSomeArrangeLabel.text    = @"当前日期没有班次";
//            [self addSubview:self.leastSomeArrangeLabel];
            break;
        case 1:
        {
            self.arrangeOneView.timeLabel.text = self.calendarItem.arrangeInToday[0][0];
            self.arrangeOneView.imgType        = [self.calendarItem.arrangeInToday[0][1] integerValue];
            
            [self addSubview:self.arrangeOneView];
            break;
        }
        case 2:
        {
            self.arrangeOneView.timeLabel.text = self.calendarItem.arrangeInToday[0][0];
            self.arrangeOneView.imgType        = [self.calendarItem.arrangeInToday[0][1] integerValue];
            
            self.arrangeTwoView.timeLabel.text = self.calendarItem.arrangeInToday[1][0];
            self.arrangeTwoView.imgType        = [self.calendarItem.arrangeInToday[1][1] integerValue];
            
            [self addSubview:self.arrangeOneView];
            [self addSubview:self.arrangeTwoView];
            break;
        }
        case 3:
        {
            self.arrangeOneView.timeLabel.text = self.calendarItem.arrangeInToday[0][0];
            self.arrangeOneView.imgType        = [self.calendarItem.arrangeInToday[0][1] integerValue];
            
            self.arrangeTwoView.timeLabel.text = self.calendarItem.arrangeInToday[1][0];
            self.arrangeTwoView.imgType        = [self.calendarItem.arrangeInToday[1][1] integerValue];
            
            self.arrangeThreeView.timeLabel.text = self.calendarItem.arrangeInToday[2][0];
            self.arrangeThreeView.imgType        = [self.calendarItem.arrangeInToday[2][1] integerValue];
            
            [self addSubview:self.arrangeOneView];
            [self addSubview:self.arrangeTwoView];
            [self addSubview:self.arrangeThreeView];
            break;
        }
        case 4:
        {
            self.arrangeOneView.timeLabel.text = self.calendarItem.arrangeInToday[0][0];
            self.arrangeOneView.imgType        = [self.calendarItem.arrangeInToday[0][1] integerValue];
            
            self.arrangeTwoView.timeLabel.text = self.calendarItem.arrangeInToday[1][0];
            self.arrangeTwoView.imgType        = [self.calendarItem.arrangeInToday[1][1] integerValue];
            
            self.arrangeThreeView.timeLabel.text = self.calendarItem.arrangeInToday[2][0];
            self.arrangeThreeView.imgType        = [self.calendarItem.arrangeInToday[2][1] integerValue];
            
            self.arrangeFourView.timeLabel.text = self.calendarItem.arrangeInToday[3][0];
            self.arrangeFourView.imgType        = [self.calendarItem.arrangeInToday[3][1] integerValue];
            
            if (self.height < 135) {
                self.leastSomeArrangeLabel.text    = [NSString stringWithFormat:@"还有%ld个班次",(self.calendarItem.arrangeInToday.count - 2)];
                [self addSubview:self.leastSomeArrangeLabel];
                self.arrangeThreeView.hidden       = YES;
                self.arrangeFourView.hidden        = YES;
            } else {
                
            }
            [self addSubview:self.arrangeOneView];
            [self addSubview:self.arrangeTwoView];
            [self addSubview:self.arrangeThreeView];
            [self addSubview:self.arrangeFourView];
            break;
        }
        case 5:
        {
            self.arrangeOneView.timeLabel.text = self.calendarItem.arrangeInToday[0][0];
            self.arrangeOneView.imgType        = [self.calendarItem.arrangeInToday[0][1] integerValue];
            
            self.arrangeTwoView.timeLabel.text = self.calendarItem.arrangeInToday[1][0];
            self.arrangeTwoView.imgType        = [self.calendarItem.arrangeInToday[1][1] integerValue];
            
            self.arrangeThreeView.timeLabel.text = self.calendarItem.arrangeInToday[2][0];
            self.arrangeThreeView.imgType        = [self.calendarItem.arrangeInToday[2][1] integerValue];
            
            self.arrangeFourView.timeLabel.text = self.calendarItem.arrangeInToday[3][0];
            self.arrangeFourView.imgType        = [self.calendarItem.arrangeInToday[3][1] integerValue];
            
            if (self.height < 135) {
                self.leastSomeArrangeLabel.text    = [NSString stringWithFormat:@"还有%ld个班次",(self.calendarItem.arrangeInToday.count - 2)];
                [self addSubview:self.leastSomeArrangeLabel];
                self.arrangeThreeView.hidden       = YES;
                self.arrangeFourView.hidden        = YES;
            } else {
                self.leastSomeArrangeLabel.text    = [NSString stringWithFormat:@"还有%ld个班次",(self.calendarItem.arrangeInToday.count - 3)];
                self.arrangeFourView.hidden        = YES;
                [self addSubview:self.leastSomeArrangeLabel];
            }
            [self addSubview:self.arrangeOneView];
            [self addSubview:self.arrangeTwoView];
            [self addSubview:self.arrangeThreeView];
            [self addSubview:self.arrangeFourView];
            break;
        }
        default:
            break;
    }
    //添加所需要的视图
    [self addSubview:self.label]; //添加label
    [self addAnimaiton];
}
- (void)layoutUIWith:(OCMCalendarItem *)calendarItem {
    _calendarItem = calendarItem;
    self.label.text = calendarItem.day;
    if ([calendarItem.day isEqualToString:@""]) {
        return;
    }
    if (calendarItem.isSelected) {
        self.label.layer.cornerRadius  = self.label.width * 0.5;
        self.label.layer.masksToBounds = YES;
        self.label.backgroundColor     = [UIColor blueColor];
        self.label.textColor           = [UIColor redColor];
        if (calendarItem.isToday) {
            self.label.backgroundColor = [UIColor greenColor];
        }
        [self addAnimaiton];
    } else {
        self.label.layer.cornerRadius  = self.label.width * 0.5;
        self.label.layer.masksToBounds = YES;
        self.label.backgroundColor     = [UIColor blackColor];
        self.label.textColor           = [UIColor whiteColor];
        if (calendarItem.isToday) {
            self.label.backgroundColor = [UIColor greenColor];
        }
        [self addAnimaiton];
    }
}
- (void)addAnimaiton {
    return; //不要动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.values               = @[@0.6,@1.2,@1.0];
    anim.keyPath              = @"transform.scale";  // transform.scale 表示长和宽都缩放
    anim.calculationMode      = kCAAnimationPaced;
    anim.duration             = 0.25;
    [self.label.layer addAnimation:anim forKey:nil];
}
@end
