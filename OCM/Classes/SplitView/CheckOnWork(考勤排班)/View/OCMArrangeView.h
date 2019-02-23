//
//  OCMArrangeView.h
//  OCM
//
//  Created by 曹均华 on 2018/4/18.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,arrangeImgType) {
    arrangeImgTypeRun,                      //0
    arrangeImgTypeCoffee,                   //1
    arrangeImgTypePC,                       //2
    arrangeImgTypeLearn                     //3
};
@interface OCMArrangeView : UIView
@property (nonatomic, strong) UILabel        *timeLabel;                       //时间label
@property (nonatomic, strong) UIImageView    *imgView;                         //图标
@property (nonatomic, assign) arrangeImgType imgType;                          //图片类型
@end
