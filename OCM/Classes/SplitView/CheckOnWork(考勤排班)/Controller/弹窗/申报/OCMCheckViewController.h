//
//  OCMCheckViewController.h
//  OCM
//
//  Created by 曹均华 on 2018/5/11.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^dismissBlock)(void);

@class OCMCalendarItem;
@interface OCMCheckViewController : UIViewController
@property (nonatomic, copy) dismissBlock                    dismissBlock;
@property (nonatomic, strong) OCMCalendarItem               *calendarItem;
@property (nonatomic, strong) NSMutableArray                *dataSourceArr;
@end
