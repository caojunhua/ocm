//
//  TaskListItem.h
//  OCM
//
//  Created by 曹均华 on 2017/12/7.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskListItem : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *publishTime;
@property (nonatomic,copy)NSString *progress;
@property (nonatomic,copy)NSString *rate;
@property (nonatomic,copy)NSString *taskType;
+ (instancetype)itemWithDict:(NSDictionary *)dict;
@end
