//
//  OCMCalendarCollectionViewCell.h
//  OCM
//
//  Created by 曹均华 on 2018/4/12.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OCMArrangeView,OCMCalendarItem;
typedef NS_ENUM(NSInteger,OCMCalendarCollectionViewCellStyle) {
    OCMCalendarCollectionViewCellStyleOne,
    OCMCalendarCollectionViewCellStyleTwo
};

@interface OCMCalendarCollectionViewCell : UICollectionViewCell
@property (nonatomic, assign) OCMCalendarCollectionViewCellStyle style;

/*UI相关*/
@property (nonatomic, strong) UIView                     *view;
@property (nonatomic, strong) UILabel                    *label;                                //展示当前日
@property (nonatomic, strong) UIView                     *isTodayPoint;                         //是否今日的标记点
@property (nonatomic, strong) OCMArrangeView             *arrangeOneView;                       //第一个排班
@property (nonatomic, strong) OCMArrangeView             *arrangeTwoView;                       //第二个排班
@property (nonatomic, strong) OCMArrangeView             *arrangeThreeView;                     //第三个排班
@property (nonatomic, strong) OCMArrangeView             *arrangeFourView;                      //第四个排班
@property (nonatomic, strong) UILabel                    *leastSomeArrangeLabel;                //剩余多少个排班

@property (nonatomic, strong) OCMCalendarItem            *calendarItem;                         //数据模型
@property (nonatomic, strong) NSMutableArray             *iconTypeArr;
//排班布局
- (void)configFirstStylewithItem;
//考勤布局
- (void)configSecondStylewithItem;
@end
