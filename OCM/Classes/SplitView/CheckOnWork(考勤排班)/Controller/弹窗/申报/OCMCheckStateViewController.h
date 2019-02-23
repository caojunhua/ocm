//
//  OCMCheckStateViewController.h
//  OCM
//
//  Created by 曹均华 on 2018/5/14.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OCMCheckWorkItem,OCMCalendarItem;
@interface OCMCheckStateViewController : UIViewController
@property (nonatomic, strong) OCMCheckWorkItem          *item;
@property (nonatomic, strong) OCMCalendarItem           *calendarItem;
@property (nonatomic, assign) BOOL                      isUp;
@property (nonatomic, assign) BOOL                      isReport;//是否申报原因编辑
@end
