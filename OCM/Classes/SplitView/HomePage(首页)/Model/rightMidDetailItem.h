//
//  rightMidDetailItem.h
//  OCM
//
//  Created by 曹均华 on 2018/3/2.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface rightMidDetailItem : NSObject

/**
 渠道代码
 */
@property (nonatomic, copy) NSString *ID;

/**
 渠道状态
 */
@property (nonatomic, copy) NSString *chStatus;

/**
 镇区
 */
@property (nonatomic, copy) NSString *townName;

/**
 总店名称
 */
@property (nonatomic, copy) NSString *storeAccountName;

/**
 班组
 */
@property (nonatomic, copy) NSString *chainLevel;

/**
 渠道户名
 */
@property (nonatomic, copy) NSString *chName;


/**
 合作年限
 */
@property (nonatomic, copy) NSString *cooperStartTime;

/**
 商圈
 */
@property (nonatomic, copy) NSString *bussAreaId;

/**
 渠道经理
 */
@property (nonatomic, copy) NSString *mngrId;

/**
 渠道地址
 */
@property (nonatomic, copy) NSString *chAddr;

/**
 连锁属性
 */
@property (nonatomic, copy) NSString *chainProperties;

/**
 渠道经理电话
 */
@property (nonatomic, copy) NSString *mngrPhone;

/**
 星级
 */
@property (nonatomic, copy) NSString *rankCode;
@end
