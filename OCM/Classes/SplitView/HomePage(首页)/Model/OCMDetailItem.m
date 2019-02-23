//
//  OCMDetailItem.m
//  OCM
//
//  Created by 曹均华 on 2018/3/29.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMDetailItem.h"
#import "OCMSubTaskItem.h"

@implementation OCMDetailItem
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"taskdetaillist" : [OCMSubTaskItem class]
             };
}
@end
