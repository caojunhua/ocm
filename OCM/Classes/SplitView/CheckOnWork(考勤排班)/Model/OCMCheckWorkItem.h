//
//  OCMCheckWorkItem.h
//  OCM
//
//  Created by 曹均华 on 2018/5/11.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCMCheckWorkItem : NSObject

/**
 班次x
 */
@property (nonatomic, copy) NSString        *arrangeStr;

/**
 开始时间-->08:30
 */
@property (nonatomic, copy) NSString        *beginTimeStr;

/**
 结束时间-->12:00
 */
@property (nonatomic, copy) NSString        *endTimeStr;

/**
 图片类型
 */
@property (nonatomic, assign) NSInteger     imgType;

/**
 外出走访(政策宣传)
 */
@property (nonatomic, copy) NSString        *workTypeName;

/**
 上班最开始是正常--还是不正常的
 */
@property (nonatomic, assign) BOOL          isBeginNormal;

/**
 上班最开始是正常--还是不正常的
 */
@property (nonatomic, assign) BOOL          isEndNormal;
/**
 上班的状态 -- 迟到还是正常
 */
@property (nonatomic, copy) NSString        *stateUpStr;

/**
 下班的状态 -- 迟到还是正常
 */
@property (nonatomic, copy) NSString        *stateDownStr;

/**
 上班的审核状态
 */
@property (nonatomic, copy) NSString        *checkUpStr;

/**
 下班的审核状态
 */
@property (nonatomic, copy) NSString        *checkDownStr;
@end
