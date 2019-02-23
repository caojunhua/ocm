//
//  ReadLeftSubItem.m
//  OCM
//
//  Created by 曹均华 on 2017/12/6.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "ReadLeftSubItem.h"

@implementation ReadLeftSubItem
+ (instancetype)itemWithDict:(NSDictionary *)dict {
    ReadLeftSubItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}
@end
