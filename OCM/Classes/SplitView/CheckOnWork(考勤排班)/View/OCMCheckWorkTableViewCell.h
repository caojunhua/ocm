//
//  OCMCheckWorkTableViewCell.h
//  OCM
//
//  Created by 曹均华 on 2018/5/11.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OCMCheckWorkItem;
@interface OCMCheckWorkTableViewCell : UITableViewCell
@property (nonatomic, strong) OCMCheckWorkItem      *checkItem;
/**
 班次x
 */
@property (nonatomic, strong) UILabel               *arrangeL;

/**
 开始时间 08:30
 */
@property (nonatomic, strong) UILabel               *beginTimeL;

/**
 结束时间  12:00
 */
@property (nonatomic, strong) UILabel               *endTimeL;

/**
 图片
 */
@property (nonatomic, strong) UIImageView           *imgV;

/**
 工作类型
 */
@property (nonatomic, strong) UILabel               *workTypeL;

/**
 打卡开始时间
 */
@property (nonatomic, strong) UILabel               *checkBeginL;

/**
 打卡开始时间
 */
@property (nonatomic, strong) UILabel               *checkEndL;

/**
 上班  迟到  正常
 */
@property (nonatomic, strong) UILabel               *stateUpL;

/**
 下班  迟到  正常
 */
@property (nonatomic, strong) UILabel               *stateDownL;


/**
 上班 已审批 & 待审批 & 去申报
 */
@property (nonatomic, strong) UIButton              *stateUpBtn;

/**
 下班 已审批 & 待审批 & 去申报
 */
@property (nonatomic, strong) UIButton              *stateDownBtn;

@end
