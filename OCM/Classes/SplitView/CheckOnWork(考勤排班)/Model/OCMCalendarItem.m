//
//  OCMCalendarItem.m
//  OCM
//
//  Created by 曹均华 on 2018/4/16.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMCalendarItem.h"
#import "OCMCheckerItem.h"

@implementation OCMCalendarItem
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"auditList":[OCMCheckerItem class]
             };
}
//替换属性名字
//+ (NSDictionary *)mj_replacedKeyFromPropertyName {
//
//}
@end
