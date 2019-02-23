//
//  OCMNetTaskListModel.h
//  OCM
//
//  Created by JianFeng_Ma on 2018/4/13.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCMNetTaskListModel : NSObject
/** 任务编号*/
@property (nonatomic,copy)NSString *taskId;
/** 任务主题*/
@property (nonatomic,copy)NSString *taskName;
/** 任务类型*/
@property (nonatomic,copy)NSString *taskType;
/** 任务剩余天数*/
@property (nonatomic,copy)NSString *remainDay;
/** 是否需签到(1：是 0： 否)*/
@property (nonatomic,copy)NSString *needSign;
/** 是否需拍照(1：是 0： 否)*/
@property (nonatomic,copy)NSString *needPhoto;
/** 是否需反馈(1：是 0： 否)*/
@property (nonatomic,copy)NSString *needFeedback;
/** 是否已签到(1：是 0： 否)*/
@property (nonatomic,copy)NSString *isSign;
/** 任务发布时间（YYYY-MM-DD）*/
@property (nonatomic,copy)NSString *beginDay;
/** 任务结束时间（YYYY-MM-DD）*/
@property (nonatomic,copy)NSString *endDay;

+ (NSArray<OCMNetTaskListModel *> *)createNetTaskListTest;

+ (instancetype)createNetListModelWithData:(NSDictionary *)data;

@end
