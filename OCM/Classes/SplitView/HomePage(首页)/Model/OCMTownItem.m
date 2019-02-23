//
//  OCMTownItem.m
//  OCM
//
//  Created by 曹均华 on 2018/4/3.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMTownItem.h"

@implementation OCMTownItem
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"TownID":@"id"
             };
}
@end
