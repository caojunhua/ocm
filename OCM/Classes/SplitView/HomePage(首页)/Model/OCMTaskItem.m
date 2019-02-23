//
//  OCMTaskItem.m
//  OCM
//
//  Created by 曹均华 on 2018/3/29.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMTaskItem.h"
#import "OCMDetailItem.h"

@implementation OCMTaskItem
+ (NSDictionary *)mj_objectClassInArray {
    return @{
        @"data" :[OCMDetailItem class]
        };
}
@end
