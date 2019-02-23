//
//  OCMSheetArrangeViewController.h
//  OCM
//
//  Created by 曹均华 on 2018/4/20.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OCMCalendarItem;
@interface OCMSheetArrangeViewController : UIViewController
@property (nonatomic, strong) NSArray          *arrangeArr;                              //今日排班数组
@property (nonatomic, strong) OCMCalendarItem  *calendarItem;                            //日历模型
@property (nonatomic, strong) NSMutableArray   *iconArr;
@end
