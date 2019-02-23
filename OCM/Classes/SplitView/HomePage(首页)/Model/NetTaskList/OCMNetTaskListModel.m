//
//  OCMNetTaskListModel.m
//  OCM
//
//  Created by JianFeng_Ma on 2018/4/13.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMNetTaskListModel.h"

@implementation OCMNetTaskListModel

/** 产生测试数据*/
+ (NSArray <OCMNetTaskListModel *>*)createNetTaskListTest{

    NSMutableArray *datas = [NSMutableArray new];
    /** 随机数组>=3*/
    for(int i = 0;i<random()%30+3;i++){
        
        NSDictionary *testData = @{@"taskId":[NSString stringWithFormat:@"%zd",
                                              random()%10086+10086],
                                   @"taskName":[NSString stringWithFormat:@"hello%zd",random()%3],
                                   @"taskType":[NSString stringWithFormat:@"%zd",random()%3],
                                   @"remainDay":[NSString stringWithFormat:@"%zd",random()%3+1],
                                   @"needSign":[NSString stringWithFormat:@"%zd",random()%3>1?1:0],
                                   @"needPhoto":[NSString stringWithFormat:@"%zd",random()%3>1?1:0],
                                   @"needFeedback":[NSString stringWithFormat:@"%zd",random()%3>1?1:0],
                                   @"isSign":[NSString stringWithFormat:@"%zd",random()%3>1?1:0],
                                   @"beginDay":@"2018-12-11",
                                   @"endDay":@"2018-12-12"
                                   };
        
        OCMNetTaskListModel *model = [OCMNetTaskListModel createNetListModelWithData:testData];
        
        [datas addObject:model];
    }
    
    return datas;
}

+ (instancetype)createNetListModelWithData:(NSDictionary *)data{
    OCMNetTaskListModel *model = [OCMNetTaskListModel new];
///** 任务编号*/
    model.taskId = data[@"taskId"];
///** 任务主题*/
    model.taskName = data[@"taskName"];
///** 任务类型*/
    model.taskType = data[@"taskType"];
///** 任务剩余天数*/
    model.remainDay = data[@"remainDay"];
///** 是否需签到(1：是 0： 否)*/
    model.needSign = data[@"needSign"];
///** 是否需拍照(1：是 0： 否)*/
    model.needPhoto = data[@"needPhoto"];
///** 是否需反馈(1：是 0： 否)*/
    model.needFeedback = data[@"needFeedback"];
///** 是否已签到(1：是 0： 否)*/
    model.isSign = data[@"isSign"];
///** 任务发布时间（YYYY-MM-DD）*/
    model.beginDay = data[@"beginDay"];
///** 任务结束时间（YYYY-MM-DD）*/
    model.endDay = data[@"endDay"];
    return model;
}
    
@end
