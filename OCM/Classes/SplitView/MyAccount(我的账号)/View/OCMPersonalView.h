//
//  OCMPersonalView.h
//  OCM
//
//  Created by 曹均华 on 2018/1/15.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OCMPersonalView : UIView

@property (nonatomic,copy)NSString *teamName;//班组名称
@property (nonatomic,copy)NSString *personName;//个人的名字
@property (nonatomic,strong)NSArray *completeArr;//完成任务的数据数组
@property (nonatomic,strong)NSArray *planArr;//计划的任务数据数组
@property (nonatomic,strong)NSArray *taskArr;//任务的名字

@property (nonatomic,strong)UIScrollView *scrollV;
- (instancetype)initWithTeamName:(NSString *)teamName person:(NSString *)personName completedArr:(NSArray *)compArr planArr:(NSArray *)planArr taskArr:(NSArray *)taskArr frame:(CGRect)frame;
@end
