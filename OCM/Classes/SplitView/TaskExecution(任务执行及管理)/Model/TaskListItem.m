//
//  TaskListItem.m
//  OCM
//
//  Created by 曹均华 on 2017/12/7.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "TaskListItem.h"

@implementation TaskListItem
+ (instancetype)itemWithDict:(NSDictionary *)dict {
    TaskListItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}
@end
