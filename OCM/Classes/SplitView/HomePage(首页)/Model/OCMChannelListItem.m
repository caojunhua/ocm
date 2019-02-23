//
//  OCMChannelListItem.m
//  OCM
//
//  Created by 曹均华 on 2018/2/2.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMChannelListItem.h"
#import "OCMListItem.h"

@implementation OCMChannelListItem
+ (NSDictionary *)mj_objectClassInArray {
    return  @{
//        @"list" : [OCMListItem class]
              @"data" : [OCMListItem class]
        };
}
@end
