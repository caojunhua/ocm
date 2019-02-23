//
//  OCMCustomArrngeTableViewCell1.h
//  OCM
//
//  Created by 曹均华 on 2018/5/8.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CFDynamicLabel,OCMCustomArrangeItem;
@interface OCMCustomArrangeTableViewCell1 : UITableViewCell
@property (nonatomic, strong) UILabel           *arrangeLabel;                  //班次x
@property (nonatomic, strong) UIButton          *textField1;                    //开始时间
@property (nonatomic, strong) UIView            *sepV;                          //分隔线  --
@property (nonatomic, strong) UIButton          *textField2;                    //结束时间
@property (nonatomic, strong) UILabel           *subTitleL;                     //文本-->"排班内容"
@property (nonatomic, strong) UIButton          *superTaskL;                    //父任务
@property (nonatomic, strong) UIImageView       *superImgV1;
@property (nonatomic, strong) UILabel           *superLabel1;
@property (nonatomic, strong) UIButton          *subTaskL;                      //子任务
@property (nonatomic, strong) UIImageView       *subImgV2;
@property (nonatomic, strong) UILabel           *subLabel2;
@property (nonatomic, strong) UILabel           *timeLabel;                     //时长
@property (nonatomic, strong) UILabel           *label1;
@property (nonatomic, strong) UILabel           *label2;

@property (nonatomic, strong) OCMCustomArrangeItem *item;
@end
