//
//  OCMNetTaskDetailModel.m
//  OCM
//
//  Created by JianFeng_Ma on 2018/4/13.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMNetTaskDetailModel.h"

@implementation OCMNetTaskDetailModel

+(instancetype)createNetTaskDetailModelWithData:(NSDictionary *)data{
    OCMNetTaskDetailModel *model = [OCMNetTaskDetailModel new];
    
    model.taskId = data[@"taskId"];
    model.taskName = data[@"taskName"];
    model.taskType = data[@"taskType"];
    model.remainDay = data[@"remainDay"];
    model.needSign = data[@"needSign"];
    model.needPhoto = data[@"needPhoto"];
    model.needFeedback = data[@"needFeedback"];
    model.isSign = data[@"isSign"];
    model.signDate = data[@"signDate"];
    model.beginDay = data[@"beginDay"];
    model.endDay = data[@"endDay"];
    model.taskContent = data[@"taskContent"];
    model.taskStatue = data[@"taskStatue"];
    model.chId = data[@"chId"];
    model.chName = data[@"chName"];
    model.chLongitude = data[@"chLongitude"];
    model.chLatitude = data[@"chLatitude"];
    model.fbackContent = data[@"fbackContent"];
    model.fbackDate = data[@"fbackDate"];
    model.photoUrl = data[@"photoUrl"];
    model.preTask = data[@"preTask"];
    model.nextTask = data[@"nextTask"];
    NSMutableArray *attList = [NSMutableArray new];
    for (NSDictionary *dict in data[@"attList"]) {
        [attList addObject:[OCMAttModel createAttWithData:dict]];
    }
    model.attList = attList;
    
    return model;
}

@end

@implementation OCMAttModel

+(instancetype)createAttWithData:(NSDictionary *)data{
    OCMAttModel *model = [OCMAttModel new];
    
    model.attId = data[@"attId"];
    model.attName = data[@"attName"];
    model.attSubtime = data[@"attSubtime"];
    model.attUrl = data[@"attUrl"];
    
    return model;
}

@end
