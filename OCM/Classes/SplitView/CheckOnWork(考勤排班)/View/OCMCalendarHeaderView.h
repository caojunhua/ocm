//
//  OCMCalendarHeaderView.h
//  OCM
//
//  Created by 曹均华 on 2018/4/13.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCMCalendarHeaderView : UIView
@property (nonatomic, strong) UIButton *lastBtn;                                                //上一个月
@property (nonatomic, strong) UIButton *nextBtn;                                                //下一个月
@property (nonatomic, strong) UILabel *yearMonthLabel;                                          //年月label

/**
 申报按钮
 */
@property (nonatomic, strong) UIButton *reportBtn;                                              //申报

/**
 排班
 */
@property (nonatomic, strong) UIButton *arrangeBtn;                                             //排班

/**
 选择班制
 */
@property (nonatomic, strong) UIButton *selectShiftBtn;                                         //选择班制
@property (nonatomic, strong) UIView *daysView;                                                 //周1~周7

@end
