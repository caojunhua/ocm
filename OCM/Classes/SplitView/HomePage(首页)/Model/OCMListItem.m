//
//  OCMListItem.m
//  OCM
//
//  Created by 曹均华 on 2018/2/2.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMListItem.h"

@implementation OCMListItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"QDid":@"id"
             };
}
@end
