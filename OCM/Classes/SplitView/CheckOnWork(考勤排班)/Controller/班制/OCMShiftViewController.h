//
//  OCMShiftViewController.h
//  OCM
//
//  Created by 曹均华 on 2018/4/12.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCMShiftViewController : UIViewController

@property (nonatomic, strong) UITableView                        *leftTableView;
@property (nonatomic, strong) UITableView                        *rightTableView;
@property (nonatomic, assign) NSInteger                          leftArrCount;                    //班制数据源
//@property (nonatomic, strong) NSMutableArray                     *leftDataSourceArr;            //左侧数据源
@property (nonatomic, strong) NSMutableArray                     *dataSourceArr;                  //右侧数据源
@property (nonatomic, strong) NSMutableArray                     *taskDataArr;
@property (nonatomic, strong) NSMutableArray                     *subTaskTempArr;       //子任务展示的数据
@property (nonatomic, assign) BOOL                               isHaveArrange;         //是否有排班

/**
 根据当前宽度加载view
 
 @param currentW 当前宽度
 */
- (void)loadSubView:(CGFloat)currentW;
+ (instancetype)sharedInstance;
@end
