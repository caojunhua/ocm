//
//  OCMSubTaskItem.h
//  OCM
//
//  Created by 曹均华 on 2018/3/29.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCMSubTaskItem : NSObject
@property (nonatomic, copy) NSString *chname;                   //网点名字
@property (nonatomic, copy) NSString *chcode;                   //网点编号
@property (nonatomic, assign) NSInteger realityEndTime;         //截止的时间戳
@end
