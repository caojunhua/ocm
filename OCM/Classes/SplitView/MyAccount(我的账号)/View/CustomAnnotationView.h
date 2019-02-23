//
//  CustomAnnotationView.h
//  CustomAnnotationDemo
//
//  Created by songjian on 13-3-11.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@class CustomCalloutView;
typedef void(^clickMoreBlock)(CLLocationCoordinate2D coorinate);
@interface CustomAnnotationView : MAAnnotationView
@property (nonatomic,copy)clickMoreBlock clickMoreBlock;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UIImage *portrait;

//@property (nonatomic, strong) UIView *calloutView;
@property (nonatomic, strong) CustomCalloutView *calloutView;
@property (nonatomic, strong) UILabel *nameLabel;

//callOut

/**
  网点名字
 */
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,copy) NSString *title;

/**
 详细信息按钮
 */
@property (nonatomic,strong) UIButton *moreBtn;

/**
 编号信息
 */
@property (nonatomic,strong) UILabel *numberLabel;
@property (nonatomic,copy) NSString *number;
/**
 网点联系人
 */
@property (nonatomic,strong) UILabel *connetctLabel;
@property (nonatomic,copy) NSString *connectPeople;

/**
 星级信息
 */
@property (nonatomic,strong) UILabel *starsLabel;
@property (nonatomic,copy) NSString *starsInfo;
/**
 联系电话
 */
@property (nonatomic,strong) UILabel *telLabel;
@property (nonatomic,copy) NSString *phoneNumber;
@end
