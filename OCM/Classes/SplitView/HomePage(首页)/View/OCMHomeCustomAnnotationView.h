//
//  CustomAnnotationView.h
//  CustomAnnotationDemo
//
//  Created by songjian on 13-3-11.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@class OCMHomeCustomCalloutView;
@interface OCMHomeCustomAnnotationView : MAAnnotationView

@property (nonatomic, strong) UIImage *portrait;
@property (nonatomic, strong) OCMHomeCustomCalloutView *calloutView;
/**
 网点名字
 */
@property (nonatomic,strong) UILabel *titleLabel;
//@property (nonatomic,copy) NSString *title;

/**
 详细信息按钮
 */
@property (nonatomic,strong) UIButton *moreBtn;

/**
 编号信息
 */
@property (nonatomic,strong) UILabel *numberLabel;
//@property (nonatomic,copy) NSString *number;
/**
 网点联系人
 */
@property (nonatomic,strong) UILabel *connetctLabel;
//@property (nonatomic,copy) NSString *connectPeople;

/**
 星级信息
 */
@property (nonatomic,strong) UILabel *starsLabel;
//@property (nonatomic,copy) NSString *starsInfo;
/**
 联系电话
 */
@property (nonatomic,strong) UILabel *telLabel;
//@property (nonatomic,copy) NSString *phoneNumber;

/**
 网点信息按钮
 */
@property (nonatomic, strong) UIButton *netInfoBtn;

/**
 导航按钮
 */
@property (nonatomic, strong) UIButton *naviBtn;

@property (nonatomic, strong) UIButton *warningBtn;
@property (nonatomic, strong) UIButton *checkBtn;
@property (nonatomic, strong) UIButton *taskBtn;
@property (nonatomic, strong) UIButton *signBtn;
@end


