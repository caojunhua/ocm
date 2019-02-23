//
//  OCMSheetArrangeTableViewCell.h
//  OCM
//
//  Created by 曹均华 on 2018/4/23.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OCMSheetArrangeCellItem;
@interface OCMSheetArrangeTableViewCell : UITableViewCell

/**
 班次x
 */
@property (nonatomic, strong) UILabel       *label1;

/**
 08:30-12:00
 */
@property (nonatomic, strong) UILabel       *label2;

@property (nonatomic, strong) UIImageView   *iconImgV;

/**
 外出走访
 */
@property (nonatomic, strong) UILabel       *label3;

/**
 (外出走访)
 */
@property (nonatomic, strong) UILabel       *label4;

/**
 时长:
 */
@property (nonatomic, strong) UILabel       *labelTime;

/**
 3.5
 */
@property (nonatomic, strong) UILabel       *label5;

/**
 小时
 */
@property (nonatomic, strong) UILabel       *label6;

@property (nonatomic, strong) OCMSheetArrangeCellItem *item;
@end
