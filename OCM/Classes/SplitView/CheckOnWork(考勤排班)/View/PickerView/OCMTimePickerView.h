//
//  OCMTimePickerView.h
//  OCM
//
//  Created by 曹均华 on 2018/4/27.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickBtnBlock)(NSString *str);
typedef void(^clickIndexBlock)(NSInteger index);
typedef NS_ENUM(NSInteger, pickerMode) {
    modeCustom,
    modeAttendace
};

@interface OCMTimePickerView : UIView
@property (nonatomic, strong) UIView         *pView;
@property (nonatomic, copy)   clickBtnBlock  clickBtnBlock;
@property (nonatomic, copy)   clickIndexBlock indexBlock;
@property (nonatomic, copy)   NSString       *timeUp;                           //时间左区间
@property (nonatomic, copy)   NSString       *timeDown;                         //时间右区间
@property (nonatomic, assign) pickerMode     mode;
@property (nonatomic, strong) NSMutableArray *attendaceArr;                     //班制数组数据源
- (instancetype)initWithFrame:(CGRect)frame mode:(pickerMode)mode;
- (void)show;
- (void)setDefaultPosition:(NSString *)time;
@end
