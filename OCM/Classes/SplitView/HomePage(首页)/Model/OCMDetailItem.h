//
//  OCMDetailItem.h
//  OCM
//
//  Created by 曹均华 on 2018/3/29.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCMDetailItem : NSObject

@property (nonatomic, copy) NSString *taskType;                 //任务类型
@property (nonatomic, copy) NSString *taskTheme;                //任务主题
@property (nonatomic, strong) NSMutableArray *taskdetaillist;          //子级任务数组信息
@end
