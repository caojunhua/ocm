//
//  OCMNetTaskDetailModel.h
//  OCM
//
//  Created by JianFeng_Ma on 2018/4/13.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCMNetTaskDetailModel : NSObject
/** 任务编号*/
@property (nonatomic,copy)NSString *taskId;
/** 任务主题名称*/
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
/** 签到时间（YYYY-MM-DD hh：mm：ss）*/
@property (nonatomic,copy)NSString *signDate;
/** 任务发布时间（YYYY-MM-DD）*/
@property (nonatomic,copy)NSString *beginDay;
/** 任务结束时间（YYYY-MM-DD）*/
@property (nonatomic,copy)NSString *endDay;
/** 任务内容（html内容）*/
@property (nonatomic,copy)NSString *taskContent;
/** 任务状态（1：已完成 0：未完成）*/
@property (nonatomic,copy)NSString *taskStatue;
/** 网点编号*/
@property (nonatomic,copy)NSString *chId;
/** 网点名称*/
@property (nonatomic,copy)NSString *chName;
/** 网点经度*/
@property (nonatomic,copy)NSString *chLongitude;
/** 网点纬度*/
@property (nonatomic,copy)NSString *chLatitude;
/** 反馈内容*/
@property (nonatomic,copy)NSString *fbackContent;
/** 反馈时间*/
@property (nonatomic,copy)NSString *fbackDate;
/** 拍照上传图片（多图片使用“，”号分隔）*/
@property (nonatomic,copy)NSString *photoUrl;
/** 上一条任务编号*/
@property (nonatomic,copy)NSString *preTask;
/** 下一条任务编号*/
@property (nonatomic,copy)NSString *nextTask;
/** 附件列表*/
@property (nonatomic,strong)NSArray *attList;

+(OCMNetTaskDetailModel *)createDetailTest;

+ (instancetype)createNetTaskDetailModelWithData:(NSDictionary *)data;

@end

@interface OCMAttModel : NSObject;
/** 附件ID*/
@property (nonatomic,copy)NSString *attId;
/** 附件名称*/
@property (nonatomic,copy)NSString *attName;
/** 附件上传时间*/
@property (nonatomic,copy)NSString *attSubtime;
/** 附件文件URL*/
@property (nonatomic,copy)NSString *attUrl;

+ (instancetype)createAttWithData:(NSDictionary *)data;

@end
