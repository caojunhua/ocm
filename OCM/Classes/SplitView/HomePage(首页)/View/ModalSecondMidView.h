//
//  ModalSecondMidView.h
//  OCM
//
//  Created by 曹均华 on 2018/3/14.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class rightMidDetailItem;
@interface ModalSecondMidView : UIView
@property (nonatomic, strong) rightMidDetailItem *item;

@property (weak, nonatomic) IBOutlet UILabel *QDNumberL;
@property (weak, nonatomic) IBOutlet UILabel *QDTypeL;
@property (weak, nonatomic) IBOutlet UILabel *QDStateL;
@property (weak, nonatomic) IBOutlet UILabel *TownAreaL;
@property (weak, nonatomic) IBOutlet UILabel *QDManagerL;
@property (weak, nonatomic) IBOutlet UILabel *BusinessCycleL;

/**
 物流属性
 */
@property (weak, nonatomic) IBOutlet UILabel *LogisticsPropertyL;
@property (weak, nonatomic) IBOutlet UILabel *QDTeamL;

/**
 合作权限
 */
@property (weak, nonatomic) IBOutlet UILabel *CooperateL;
@property (weak, nonatomic) IBOutlet UILabel *QDManagerPhoneL;

/**
 总店户名
 */
@property (weak, nonatomic) IBOutlet UILabel *ShopNameL;

/**
 销售属性
 */
@property (weak, nonatomic) IBOutlet UILabel *SellPropertyL;

/**
 连锁属性
 */
@property (weak, nonatomic) IBOutlet UILabel *ChainPropertyL;
@property (weak, nonatomic) IBOutlet UILabel *QDAddress;

/**
 渠道户名
 */
@property (weak, nonatomic) IBOutlet UILabel *ChainNameL;

@end
