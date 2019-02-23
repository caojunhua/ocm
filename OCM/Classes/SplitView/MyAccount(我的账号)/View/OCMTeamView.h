//
//  OCMTeamView.h
//  OCM
//
//  Created by 曹均华 on 2018/1/10.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CFDynamicLabel;
@interface OCMTeamView : UIView
@property (nonatomic,strong)UIView *topV;
@property (nonatomic,strong)UIButton *taskBtn;
@property (nonatomic,strong)UIButton *areaBtn;
@property (nonatomic,strong)CFDynamicLabel *taskLabel;
@property (nonatomic,strong)CFDynamicLabel *areaLabel;

@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UIButton *rightBtn;

@property (nonatomic,strong)UIView *midV;
@property (nonatomic,strong)UIView *bottomV;

@property (nonatomic,strong)UIScrollView *scrollView1;
@property (nonatomic,strong)UIScrollView *scrollView2;
//data
@property (nonatomic,strong)NSMutableArray<NSMutableArray *> *completeArr;
@property (nonatomic,strong)NSMutableArray<NSMutableArray *> *planArr;
@property (nonatomic,strong)NSMutableArray *teamNameArr;
@property (nonatomic,strong)NSMutableArray *taskNameArr;
@property (nonatomic,assign)NSInteger currentIndex;//当前选中展示哪组数据
@property (nonatomic,assign)CGFloat curX1;

- (instancetype)initWithFrame:(CGRect)frame planData:(NSMutableArray<NSMutableArray*> *)planArr completedData:(NSMutableArray<NSMutableArray*> *)completedArr teamName:(NSMutableArray *)teamNameArr taskName:(NSMutableArray *)taskNameArr sepWidth:(CGFloat)sepWidth selectedData:(NSInteger)sel curX1:(CGFloat)curX1;
@end
