//
//  OCMCustomArrangeVC.h
//  OCM
//
//  Created by 曹均华 on 2018/4/26.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^dismissBlock)(void);
@interface OCMCustomArrangeVC : UIViewController
@property (nonatomic, strong) NSMutableArray                     *dataSourceArr;
@property (nonatomic, strong) NSMutableArray                     *taskDataArr;                                      //任务数据源
@property (nonatomic, strong) NSMutableDictionary                *taskDict;
@property (nonatomic, copy)   dismissBlock                       dismissBlock;
@end
