//
//  OCMIndicatorView.h
//  OCM
//
//  Created by 曹均华 on 2018/1/2.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBPopOverView,CFDynamicLabel;
@interface OCMIndicatorView : UIView
///top
@property (nonatomic,strong)UIView *topV;
@property (nonatomic,strong)UIButton *lookMineBtn;
///mid
@property (nonatomic,strong)UIView *midV;

/**
 显示柱状图的scrollV
 */
@property (nonatomic,strong)UIScrollView *barScrollV;
@property (nonatomic,strong)UIButton *btnTask;
@property (nonatomic,strong)CFDynamicLabel *taskLabel;
@property (nonatomic,strong)UIButton *btnArea;
@property (nonatomic,strong)CFDynamicLabel *areaLabel;
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UIButton *rightBtn;

@property (nonatomic,strong)WBPopOverView *view;
@property (nonatomic,strong)CAShapeLayer *mineLayer;
/**
 显示班组名字view
 */
@property (nonatomic,strong)UIView *teamNameView;
///bottom
@property (nonatomic,strong)UIView *bottomV;
//数据
/**
 包含3个数组的数组,其中每个数组里面装的数据分别代表  1 组完成量 2 指标值 3 挑战值
 */
@property (nonatomic,strong)NSArray<NSArray *> *dataArrs;
@property (nonatomic,strong)NSArray *teamsNameArr;
@property (nonatomic,strong)NSDictionary *myPerformance;
/**
 当前所有数组里的最大值
 */
@property (nonatomic,assign)CGFloat maxV;

/**
 每3组柱状图直接的间隙
 */
@property (nonatomic,assign)CGFloat disX;

- (instancetype)initWithData:(NSArray<NSArray *> *)dataArr frame:(CGRect)frame teamsViewNameArr:(NSArray *)teamsArr myData:(NSDictionary *)myPerformance;
@end
