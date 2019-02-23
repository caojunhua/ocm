//
//  OCMLeftTopSecondTableViewCell.h
//  OCM
//
//  Created by 曹均华 on 2018/2/2.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCMLeftTopSecondTableViewCell : UITableViewCell

/**
 代理点名字
 */
@property (nonatomic, strong) UILabel *label1;

/**
 编号
 */
@property (nonatomic, strong) UILabel *label2;

/**
 联系人
 */
@property (nonatomic, strong) UILabel *label3;

/**
 电话
 */
@property (nonatomic, strong) UILabel *label4;

/**
 星级
 */
@property (nonatomic, strong) UILabel *label5;

/**
 距离
 */
@property (nonatomic, strong) UILabel *label6;
/**
 经度
 */
@property (nonatomic, assign) CGFloat chLatitude;

/**
 经度
 */
@property (nonatomic, assign) CGFloat chLogngitude;
@end
