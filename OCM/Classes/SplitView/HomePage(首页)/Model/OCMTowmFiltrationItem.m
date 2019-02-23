//
//  OCMTowmFiltrationItem.m
//  OCM
//
//  Created by 曹均华 on 2018/4/3.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMTowmFiltrationItem.h"
#import "OCMTownItem.h"

@implementation OCMTowmFiltrationItem
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"list":[OCMTownItem class]
             };
}
@end
