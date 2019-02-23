//
//  OCMAllNetItem.m
//  OCM
//
//  Created by 曹均华 on 2018/3/30.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMAllNetItem.h"
#import "OCMAllNetDetailItem.h"

@implementation OCMAllNetItem
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"data" : [OCMAllNetDetailItem class]
             };
}
@end
