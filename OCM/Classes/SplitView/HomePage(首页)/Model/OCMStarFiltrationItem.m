//
//  OCMStarFiltrationItem.m
//  OCM
//
//  Created by 曹均华 on 2018/4/3.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMStarFiltrationItem.h"
#import "OCMStarSubItem.h"

@implementation OCMStarFiltrationItem
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"list":[OCMStarSubItem class]
             };
}
@end
