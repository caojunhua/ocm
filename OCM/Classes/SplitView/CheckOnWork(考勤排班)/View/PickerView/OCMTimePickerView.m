//
//  OCMTimePickerView.m
//  OCM
//
//  Created by 曹均华 on 2018/4/27.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMTimePickerView.h"

@interface OCMTimePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString                *_resStr;
    NSMutableArray          *_dataSourceHour;
    NSMutableArray          *_dataSourceMin;
    UIPickerView            *_pickerView;
    NSString                *_hour;
    NSString                *_min;
    NSInteger               _defaultIndex;// 弹出班制的时候,默认选中第0个
}
@end

@implementation OCMTimePickerView
#define Kheight 250
- (instancetype)initWithFrame:(CGRect)frame mode:(pickerMode)mode {
    if (self = [super initWithFrame:frame]) {
        self.mode        = mode;
        _dataSourceHour  = [NSMutableArray array];
        _dataSourceMin   = [NSMutableArray array];
        _hour            = @"08时";
        _min             = @"00分";
        _resStr          = @"08时:00分";
        _defaultIndex    = 0;
        [self loadData];
        [self configUI];
    }
    return self;
}
- (void)loadData {
    if (self.mode == modeCustom) {
        OCMLog(@"自定义排班");
        [self generateHourAndMinuteDataSource];
    } else {
        OCMLog(@"按照班制排班");
    }
}
- (void)generateHourAndMinuteDataSource {
    for (int i = 0; i <= 59; i++) {
        NSString *minute = [NSString stringWithFormat:@"%02d分", i];
        [_dataSourceMin addObject:minute];
    }
    
    for (int i = 8; i < 23 ; i++) {           // 08:00 ~ 22:00
        NSString *hour      = [NSString stringWithFormat:@"%02d时", i];
        [_dataSourceHour addObject:hour];
    }
}
- (void)configUI {
    _pView                              = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight, screenWidth, Kheight)];
    _pView.backgroundColor              = KBlueColor;
    _pView.userInteractionEnabled       = YES;
    [self addSubview:_pView];
    
    UIView *bgView                      = [[UIView alloc] initWithFrame:CGRectMake(0, 50, screenWidth, Kheight - 50)];
    bgView.backgroundColor              = [UIColor whiteColor];
    [_pView addSubview:bgView];
    
    UIButton *cancelBtn                 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_pView addSubview:cancelBtn];
    
    UIButton *sureBtn                   = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - 100, 0, 100, 50)];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_pView addSubview:sureBtn];
    
//    _pickerView                         = [[UIPickerView alloc] initWithFrame:
//                                           CGRectMake(0, sureBtn.bottom + 5, screenWidth, Kheight - sureBtn.height - 5)];
    _pickerView                         = [[UIPickerView alloc] initWithFrame:
                                           CGRectMake(screenWidth * 0.25, sureBtn.bottom + 5, screenWidth * 0.5, Kheight - sureBtn.height - 5)];
    _pickerView.delegate                = self;
    _pickerView.dataSource              = self;
    _pickerView.backgroundColor         = [UIColor whiteColor];
    _pickerView.showsSelectionIndicator = YES;
    [_pView addSubview:_pickerView];
}
- (void)dismiss {
    [UIView animateWithDuration:0.5 animations:^{
        self.pView.top = screenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)show {
    self.frame         = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.pView.top = screenHeight - Kheight;
    }];
}
//设置班制数据源
- (void)setAttendaceArr:(NSMutableArray *)attendaceArr {
    _attendaceArr = attendaceArr;
    [_pickerView reloadAllComponents];
}
#pragma mark -- 点击事件
- (void)clickBtn:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"取消"]) {
        [self dismiss];
    } else {
        if (self.mode == modeCustom) {
            if (self.clickBtnBlock) {
                self.clickBtnBlock(_resStr);
            }
        } else {
            if (self.indexBlock) {
                self.indexBlock(_defaultIndex);
            }
        }
        
        [self dismiss];
    }
}
#pragma mark -- UIPickerViewDataSource
- (CGSize)rowSizeForComponent:(NSInteger)component {
    return CGSizeMake(100, 100);
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.mode == modeCustom)        return 2;
    else                                return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.mode == modeCustom) {
        if (component == 0)     return _dataSourceHour.count;
        else                    return _dataSourceMin.count;
    } else {
        return self.attendaceArr.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = nil;
    if (self.mode == modeCustom) {
        if (component == 0)         title = _dataSourceHour[row];
        else                        title = _dataSourceMin[row];
    } else {
                                    title = self.attendaceArr[row];
    }
    return title;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    UIView *view = [pickerView viewForRow:row forComponent:component];
    if (component == 0) {
        view.frame   = CGRectMake(25, 0, screenWidth/2., 20.);
        _defaultIndex = row;
    } else {
        view.frame   = CGRectMake(-25, 0, screenWidth/2., 20.);
    }
    [self setResult:row component:component];
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    if (!view) {
//        view = [[UIView alloc] init];
//        for (UIView *sepV in pickerView.subviews) {
//            if (sepV.height < 1) {
//                sepV.backgroundColor = [UIColor blackColor];
//            }
//        }
//    }
//    if (self.mode == modeCustom) {
//        if (component == 0) {
//            UILabel *myView        = nil;
//            myView                 = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, screenWidth/2., 20.)];
//            myView.textAlignment   = NSTextAlignmentCenter;
//            myView.text            = [_dataSourceHour objectAtIndex:row];
//            myView.font            = [UIFont systemFontOfSize:18];         //用label来设置字体大小
//            myView.backgroundColor = [UIColor clearColor];
//            [view addSubview:myView];
//        } else {
//            UILabel *myView         = nil;
//            myView                  = [[UILabel alloc] initWithFrame:CGRectMake(-25, 0, screenWidth/2., 20.)];
//            myView.textAlignment    = NSTextAlignmentCenter;
//            myView.text             = [_dataSourceMin objectAtIndex:row];
//            myView.font             = [UIFont systemFontOfSize:18];         //用label来设置字体大小
//            myView.backgroundColor  = [UIColor clearColor];
//            [view addSubview:myView];
//        }
//    } else {
//        UILabel *myView        = nil;
//        myView                 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 20.)];
//        myView.textAlignment   = NSTextAlignmentCenter;
//        myView.text            = [self.attendaceArr objectAtIndex:row];
//        myView.font            = [UIFont systemFontOfSize:18];         //用label来设置字体大小
//        myView.backgroundColor = [UIColor redColor];
//        [view addSubview:myView];
//    }
//
//    return view;
//}
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    if (self.mode == modeCustom) {
//        return screenWidth / 2.;
//    } else {
//        return screenWidth;
//    }
//}
- (void)setDefaultPosition:(NSString *)time {
    if ([time isEqualToString:@"00:00"]) {
        return;
    }
    NSArray *temp  = [time componentsSeparatedByString:@":"];
    NSInteger hour = [temp[0] integerValue];
    NSInteger min  = [temp[1] integerValue];
    [_pickerView selectRow:(hour - 8) inComponent:0 animated:NO];
    [_pickerView selectRow:min inComponent:1 animated:NO];
    [self setResult:min row2:(hour - 8)];
}
#pragma mark -- 设置最后选择的时间
- (void)setResult:(NSInteger)row component:(NSInteger)component {
    if (self.mode     == modeCustom) {
        if (component == 0)       _hour     = _dataSourceHour[row];
        else                      _min      = _dataSourceMin[row];
        _resStr                             = [NSString stringWithFormat:@"%@:%@",_hour,_min];
    }
}
- (void)setResult:(NSInteger)row1 row2:(NSInteger)row2 {
    if (self.mode     == modeCustom) {
                                  _hour     = _dataSourceHour[row2];
                                  _min      = _dataSourceMin[row1];
        _resStr                             = [NSString stringWithFormat:@"%@:%@",_hour,_min];
    }
}
@end
