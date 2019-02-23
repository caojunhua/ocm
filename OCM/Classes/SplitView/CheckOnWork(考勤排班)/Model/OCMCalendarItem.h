//
//  OCMCalendarItem.h
//  OCM
//
//  Created by 曹均华 on 2018/4/16.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,textColorType){
    textColorNone,
    textColorOrange,
    textColorRed,
    textColorBlue
};

@class  OCMCheckerItem;
@interface OCMCalendarItem : NSObject
@property (nonatomic, assign) NSInteger                 year;
@property (nonatomic, assign) NSInteger                 month;
@property (nonatomic, copy)   NSString                  *day;
@property (nonatomic, assign) BOOL                      isSelected;

@property (nonatomic, strong) UIColor                   *activityColor;
@property (nonatomic, assign) BOOL                      isToday;
@property (nonatomic, assign) textColorType             textColor;              //颜色类型
//当前班次内容数组
@property (nonatomic, strong) NSArray                   *arrangeInToday;
//审核人意见数组
@property (nonatomic, strong) NSMutableArray            *auditList;

@end
