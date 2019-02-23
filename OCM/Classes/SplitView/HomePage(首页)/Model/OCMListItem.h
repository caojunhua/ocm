//
//  OCMListItem.h
//  OCM
//
//  Created by 曹均华 on 2018/2/2.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCMListItem : NSObject

/**
 代理点名字
 */
@property (nonatomic, copy) NSString *chName;
/**
 网点编号
 */
@property (nonatomic, copy) NSString *bossId;

/**
 联系人名字
 */
@property (nonatomic, copy) NSString *contacts;

/**
 联系电话
 */
@property (nonatomic, copy) NSString *phone;

/**
 经度
 */
@property (nonatomic, assign) CGFloat chLatitude;

/**
 经度
 */
@property (nonatomic, assign) CGFloat chLogngitude;

/**
 星级
 */
@property (nonatomic, copy) NSString *rankCode;

/**
 距离
 */
@property (nonatomic, assign) double distance;

/**
 渠道id
 */
@property (nonatomic, copy) NSString *QDid;
@end
