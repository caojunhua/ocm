//
//  OCMShiftViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/4/12.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMShiftViewController.h"
#import "OCMCustomArrangeTableViewCell1.h"
#import "OCMTaskTypeTableViewCell.h"
#import "OCMCustomArrangeItem.h"
#import "OCMTaskTypeTableViewController.h"
#import "WBPopOverView.h"
#import "OCMSubTaskTableViewController.h"
#import "OCMTimePickerView.h"
#import "OCMTaskTypeItem.h"

@interface OCMShiftViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView                             *leftTopView;
@property (nonatomic, strong) UIView                             *rightTopView;
@property (nonatomic, strong) UILabel                            *titleL;
/** 右侧头部相关*/
@property (nonatomic, assign) CGFloat                            totoalHour;
@property (nonatomic, strong) UILabel                            *totoalL;
@property (nonatomic, strong) UIButton                           *rightEditBtn;
@property (nonatomic, strong) UIButton                           *rightAddBtn;
@property (nonatomic, strong) UIButton                           *rightSaveBtn;

@property (nonatomic, strong) UIButton                           *selectedBtn;
@property (nonatomic, assign) BOOL                               canAddFlag;            //当前能否继续添加班次
@property (nonatomic, copy)   NSString                           *beginTemp;            //开始计算时间
@property (nonatomic, copy)   NSString                           *endTemp;              //结束计算时间
@property (nonatomic, assign) BOOL                               isRightCanEdit;        //右侧是否能编辑
@property (nonatomic, assign) BOOL                               isRightSaved;          //右侧是否保存了

/**
 左侧列表选中的下标,默认选中第一个
 */
@property (nonatomic, assign) NSInteger                          leftSelectedIndex;
@end

@implementation OCMShiftViewController
#define kLeftWidth 225
#define kTopViewH  50
#define kTime           @"00:00"
#define kBeginTime      @"beginTime"
#define kEndTime        @"endTime"
#define kArrangeStr     @"arrangeStr"
#define kShiftName      @"shiftName"
#define kID             @"ID"
#define kList           @"list"
#define kImgType        @"imgType"
#define kSuperworkType  @"superworkType"
#define kSubWorkType    @"subWorkType"

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.leftSelectedIndex    = 0;          //默认选中左侧  第0个
    self.isRightCanEdit       = NO;
    self.isRightSaved         = NO;
    self.isHaveArrange        = NO;
}
+ (instancetype)sharedInstance {
    static OCMShiftViewController *_shiftVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shiftVC = [[OCMShiftViewController alloc] init];
    });
    return _shiftVC;
}

- (void)viewDidLoad {
    [super viewDidLoad]; //班制
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)loadSubView:(CGFloat)currentW {
    [self configTableView:currentW];
}
- (void)configTableView:(CGFloat)width {
    __weak typeof(self) weakSelf = self;
    if (self.view.subviews) {
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
            obj = nil;
        }];
    }
    //左边布局
    self.leftTopView                    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLeftWidth, kTopViewH)];
    [self.view addSubview:self.leftTopView];
    self.leftTopView.backgroundColor    = [UIColor colorWithHexString:@"f0f0f0"];
    UIButton *addBtn                    = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kTopViewH, kTopViewH)];
    [addBtn setImage:ImageIs(@"icon_attence_add") forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(leftClickAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.leftTopView addSubview:addBtn];
    
    UILabel *titleL                     = [[UILabel alloc] initWithFrame:CGRectMake(62, 0, 100, 50)];
    titleL.textAlignment                = NSTextAlignmentCenter;
    _titleL                             = titleL;
    titleL.text                         = [NSString stringWithFormat:@"班制(1)"];
    [self.leftTopView addSubview:titleL];
    
    UIButton *editBtn                   = [[UIButton alloc] initWithFrame:CGRectMake(kLeftWidth - kTopViewH, 0, kTopViewH, kTopViewH)];
    [editBtn addTarget:self action:@selector(leftClickEdit) forControlEvents:UIControlEventTouchUpInside];
    [editBtn setImage:ImageIs(@"icon_attence_edit") forState:UIControlStateNormal];
    [self.leftTopView addSubview:editBtn];
    
    self.leftTableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopViewH, kLeftWidth, self.view.height - 64) style:UITableViewStylePlain];
    self.leftTableView.dataSource       = self;
    self.leftTableView.delegate         = self;
    self.leftTableView.separatorStyle   = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.leftTableView];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionBottom];
    UIView *sepV                        = [[UIView alloc] initWithFrame:CGRectMake(kLeftWidth - 1, 0, 0.5, self.view.height)];
    sepV.backgroundColor                = [UIColor colorWithHexString:@"999999"];
    [self.view addSubview:sepV];
    
    /*----------------------------------------------我是分割线-------------------------------------------------*/
    //右边布局
    self.rightTopView                   = [[UIView alloc] initWithFrame:CGRectMake(kLeftWidth, 0, width - kLeftWidth, kTopViewH)];
    [self.view addSubview:self.rightTopView];
    
    UILabel *label1                     = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 110, kTopViewH)];
    label1.textAlignment                = NSTextAlignmentCenter;
    label1.text                         = @"排班时长合计:";
    [self.rightTopView addSubview:label1];
    
    _totoalL                            = [[UILabel alloc] initWithFrame:CGRectMake(118, 0, 40, kTopViewH)];
    _totoalL.textColor                  = KRedColor;
    _totoalL.textAlignment              = NSTextAlignmentCenter;
    _totoalL.text                       = @"0.00";
    [self.rightTopView addSubview:_totoalL];
    
    CGFloat x                           = CGRectGetMaxX(_totoalL.frame);
    UILabel *label2                     = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, 35, 50)];
    label2.text                         = @"小时";
    [self.rightTopView addSubview:label2];
    
    self.rightEditBtn                   = [[UIButton alloc] init];
    [self.rightEditBtn setImage:ImageIs(@"icon_attence_edit") forState:UIControlStateNormal];
    [self.rightEditBtn addTarget:self action:@selector(rightClickEdit) forControlEvents:UIControlEventTouchUpInside];
    [self.rightTopView addSubview:self.rightEditBtn];
    [self.rightEditBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(kTopViewH);
        make.right.mas_equalTo(weakSelf.rightTopView.mas_right).offset(-kTopViewH);
        make.top.mas_equalTo(weakSelf.rightTopView.mas_top);
    }];
    
    self.rightSaveBtn                   = [[UIButton alloc] init];
    self.rightSaveBtn.hidden            = YES;
    [self.rightSaveBtn setImage:ImageIs(@"icon_attence_save") forState:UIControlStateNormal];
    [self.rightSaveBtn addTarget:self action:@selector(rightClickSave) forControlEvents:UIControlEventTouchUpInside];
    [self.rightTopView addSubview:self.rightSaveBtn];
    [self.rightSaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(kTopViewH);
        make.right.mas_equalTo(weakSelf.rightTopView.mas_right).offset(-kTopViewH);
        make.top.mas_equalTo(weakSelf.rightTopView.mas_top);
    }];
    
    self.rightAddBtn                    = [[UIButton alloc] init];
    self.rightAddBtn.hidden             = YES;
    [self.rightAddBtn setImage:ImageIs(@"icon_attence_add") forState:UIControlStateNormal];
    [self.rightAddBtn addTarget:self action:@selector(rightClickAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.rightTopView addSubview:self.rightAddBtn];
    [self.rightAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(kTopViewH);
        make.top.mas_equalTo(weakSelf.rightTopView.mas_top);
        make.right.mas_equalTo(weakSelf.rightSaveBtn.mas_left).offset(-5);
    }];
    
    self.rightTableView                 = [[UITableView alloc] initWithFrame:CGRectMake(kLeftWidth, kTopViewH, width - kLeftWidth, self.view.height - 64) style:UITableViewStylePlain];
    self.rightTableView.delegate        = self;
    self.rightTableView.dataSource      = self;
    self.rightTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.rightTableView reloadData];
    [self.view addSubview:self.rightTableView];
}
#pragma mark -- 时间相关算法
//1.计算起始时间是否大于60分钟
- (BOOL)arrangeIsLegalWithBeginTime:(NSString *)beginTime endTime:(NSString *)endTime {
    NSArray *beginArr  = [beginTime componentsSeparatedByString:@":"];
    NSArray *endArr    = [endTime componentsSeparatedByString:@":"];
    NSInteger totalMin = ([endArr[0] integerValue] - [beginArr[0] integerValue]) * 60 + ([endArr[1] integerValue] - [beginArr[1] integerValue]);
    OCMLog(@"totalMin-->%ld", totalMin);
    if (totalMin >= 60)             return YES;
    else                            return NO;
}
//2.两个班次的时间区间间隔是否大于60分钟  && 下个时间区间在上个时间区间之后
- (BOOL)compareBeginTimeIsLegalWithBeginTime:(NSString *)beginTime lastFlagTime:(NSString *)lastFlagTime {
    NSArray *beginArr  = [lastFlagTime componentsSeparatedByString:@":"];
    NSArray *endArr    = [beginTime componentsSeparatedByString:@":"];
    NSInteger totalMin = ([endArr[0] integerValue] - [beginArr[0] integerValue]) * 60 + ([endArr[1] integerValue] - [beginArr[1] integerValue]);
    OCMLog(@"间隔时间-->%ld", totalMin);
    if (totalMin >= 60)             return YES;
    else                            return NO;
    return YES;
}
/**
 *  1. 如果是新增的班次,则需要比较    ①开始时间与上一个班次的开始时间间隔是否大于60分钟
 *                               ②开始时间与结束时间间隔是否大于60分钟
 *  2. 如果是修改之前的班次,则需要比较 ①修改后的开始时间与结束时间是否合法
 *                               ②修改后的结束时间与下一个班次的开始时间间隔是否大于60分钟
 *  3. 需要参数   >开始时间
 *              >结束时间
 *              >当前按钮所在的index,获取上一个区间的时间,获取下一个区间的时间,如果index是0,则不需要与别的区间作比较
 *
 */
- (BOOL)timeIsLegalWithBeginTime:(NSString *)beginTime endTime:(NSString *)endTime index:(NSInteger)index {
    BOOL result = NO;
    NSMutableArray *listArr       = [self.dataSourceArr[self.leftSelectedIndex] objectForKey:kList];
    if (index == listArr.count - 1 && index > 0) {   //当前编辑的班次是最新的班次 && 至少是从第2个开始
        BOOL oneBool              = [self arrangeIsLegalWithBeginTime:beginTime endTime:endTime]; //1.结束时间 - 开始时间  >= 60min  ?
        NSMutableDictionary *dict = listArr[index - 1];
        NSString *lastEndTime     = dict[kEndTime];
        BOOL twoBool              = [self arrangeIsLegalWithBeginTime:lastEndTime endTime:beginTime]; //2.开始时间 - 上个结束时间 >= 60min ?
        if (oneBool && twoBool) {   // 两个都合法 --> 则返回合法
            result = YES;
        } else if (!oneBool) {
            OCMLog(@"开始时间与结束必须大于60分钟");
            result = NO;
        } else if (!twoBool) {
            OCMLog(@"当前班次开始时间必须与上一个班次的结束时间间隔大于60分钟");
            result = NO;
        } else {
            result = NO;
        }
    } else { //当前编辑的班次不是最新的班次,需要考虑到与别的区间的时间作比较
        if (index == 0) { //不是最新班次,但是编辑的是第一个班次
            BOOL oneBool = [self arrangeIsLegalWithBeginTime:beginTime endTime:endTime]; //1.结束时间 - 开始时间  >= 60min  ?
            if (listArr.count > 1) {
                NSMutableDictionary *dict = listArr[index + 1];
                NSString *nextBeginTime = dict[kBeginTime];
                BOOL twoBool = [self arrangeIsLegalWithBeginTime:endTime endTime:nextBeginTime];
                if (oneBool && twoBool) {
                    result    = YES;
                } else {
                    result    = NO;
                }
            } else {
                if (oneBool) {
                    result   = YES;
                } else {
                    result   = NO;
                }
            }
        } else { //中间的位置班次,需要同时与上一个班次和下一个班次作比较
            BOOL oneBool                  = [self arrangeIsLegalWithBeginTime:beginTime endTime:endTime]; //1.结束时间 - 开始时间  >= 60min  ?
            NSMutableDictionary *lastDict = listArr[index - 1];
            NSString *lastEndTime         = lastDict[kEndTime];
            BOOL twoBool                  = [self arrangeIsLegalWithBeginTime:lastEndTime endTime:beginTime]; // 开始时间 - 上个结束时间 >= 60min?
            NSMutableDictionary *nextDict = listArr[index + 1];
            NSString *nextBeginTime       = nextDict[kBeginTime];
            BOOL threeBool                = [self arrangeIsLegalWithBeginTime:endTime endTime:nextBeginTime]; // 下个开始时间 - 现在结束时间 >= 60min ?
            if (oneBool && twoBool && threeBool) {  // 3个都合法 -- > 则返回合法
                result                    = YES;
            } else if (!oneBool) {
                OCMLog(@"开始时间与结束时间间隔必须大于60分钟");
                result                    = NO;
            } else if (!twoBool) {
                OCMLog(@"开始时间必须与上个结束时间间隔大于60分钟");
                result                    = NO;
            } else if (!threeBool) {
                OCMLog(@"结束时间必须与下个开始时间间隔大于60分钟");
                result                    = NO;
            } else {
                result                    = NO;
            }
        }
    }
    return result;
}
/**
 计算开始时间和结束时间的间隔
 */
- (CGFloat)caculateWithBeginTime:(NSString *)beginTime endTime:(NSString *)endTime {
    NSArray *beginArr               = [beginTime componentsSeparatedByString:@":"];
    NSArray *endArr                 = [endTime componentsSeparatedByString:@":"];
    NSInteger totalMin              = ([endArr[0] integerValue] - [beginArr[0] integerValue]) * 60 + ([endArr[1] integerValue] - [beginArr[1] integerValue]);
    CGFloat timeF                   = totalMin / 60.f;
    return timeF;
}

/**
 计算总时间
 */
- (NSString *)getTotalTime {
    CGFloat total                   = 0.f;
    NSMutableArray *listArr         = [self.dataSourceArr[self.leftSelectedIndex] objectForKey:kList];
    for (NSMutableDictionary *dict in listArr) {
        NSString *beginTime         = dict[kBeginTime];
        NSString *endTime           = dict[kEndTime];
        CGFloat tempTime            = [self caculateWithBeginTime:beginTime endTime:endTime];
        total                       += tempTime;
    }
    return [NSString stringWithFormat:@"%.2f",total];
}

#pragma mark -- 点击事件
- (void)leftClickAdd {
    OCMLog(@"leftClickAdd");
    if (self.isRightSaved) {
        NSMutableArray *tempArr                 = [NSMutableArray array];
        NSMutableDictionary *dict               = [NSMutableDictionary dictionary];
        [dict setObject:@"班次1" forKey:kArrangeStr];
        [dict setObject:kTime forKey:kBeginTime];
        [dict setObject:kTime forKey:kEndTime];
        [tempArr addObject:dict];
        NSMutableDictionary *bigDict            = [NSMutableDictionary dictionary];
        [bigDict setObject:@(self.dataSourceArr.count + 1) forKey:kID];
        [bigDict setObject:[NSString stringWithFormat:@"班制%ld",self.dataSourceArr.count + 1] forKey:kShiftName];
        [bigDict setObject:tempArr forKey:kList];
        [_dataSourceArr addObject:bigDict];
        [self.leftTableView reloadData];
        NSIndexPath *indexP                     = [NSIndexPath indexPathForRow:self.dataSourceArr.count - 1 inSection:0];
        [self.leftTableView selectRowAtIndexPath:indexP animated:NO scrollPosition:UITableViewScrollPositionBottom];
        self.leftSelectedIndex                  = indexP.row;
        [self.rightTableView reloadData];
        self.totoalL.text                       = [self getTotalTime];
        
        _titleL.text                            = [NSString stringWithFormat:@"班制(%ld)",self.dataSourceArr.count];
        self.isRightSaved                       = NO;
        [self rightClickEdit]; //刚添加 右侧默认编辑状态
    } else {
        MBProgressHUD *hud              = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode                        = MBProgressHUDModeText;
        hud.label.text                  = @"请先保存好当前的班制^_^";
        [hud hideAnimated:YES afterDelay:2];
    }
}
- (void)leftClickEdit {
    OCMLog(@"leftClickEdit");
    __weak typeof(self) weakSelf = self;
    NSString *placeText          = [self.dataSourceArr[self.leftSelectedIndex] objectForKey:kShiftName];
    UIAlertController *alertC    = [UIAlertController alertControllerWithTitle:@"编辑班制" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder    = placeText;
    }];
    UIAlertAction *cancelAction  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *okAction      = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __weak typeof(weakSelf) theSelf = weakSelf;
        [theSelf.dataSourceArr[theSelf.leftSelectedIndex] setObject:alertC.textFields.firstObject.text forKey:kShiftName];
        [theSelf.leftTableView reloadData];
        [theSelf.rightTableView reloadData];
        [theSelf.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:theSelf.dataSourceArr.count - 1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionBottom];
    }];
    [alertC addAction:cancelAction];
    [alertC addAction:okAction];
    [self presentViewController:alertC animated:YES completion:nil];
}
- (void)rightClickEdit {
    self.rightEditBtn.hidden            = YES;
    self.rightAddBtn.hidden             = NO;
    self.rightSaveBtn.hidden            = NO;
    self.isRightCanEdit                 = YES;
    self.isRightSaved                   = NO;
    self.isHaveArrange                  = NO; // 当前没保存好,或者正处于编辑状态
    [self.rightTableView reloadData];
}
- (void)rightClickAdd {
    OCMLog(@"添加");
    NSMutableArray *listArr             = [self.dataSourceArr[self.leftSelectedIndex] objectForKey:kList];
    if (listArr.count > 0) {
        NSMutableDictionary *dict       = [listArr lastObject];
        NSString *beginTime             = dict[kBeginTime];
        NSString *endTime               = dict[kEndTime];
        _canAddFlag                     = [self arrangeIsLegalWithBeginTime:beginTime endTime:endTime];
    }
    if (!_canAddFlag && listArr.count > 0) {
        MBProgressHUD *hud              = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode                        = MBProgressHUDModeText;
        hud.label.text                  = @"请先设置好当前班次^_^";
        [hud hideAnimated:YES afterDelay:2];
    } else {
        //新增班次后,之前的flag还原
        _canAddFlag                     = NO;
        _beginTemp                      = nil;
        _endTemp                        = nil;
        NSMutableDictionary *dict       = [NSMutableDictionary dictionary];
        [dict setObject:[NSString stringWithFormat:@"班次%ld",(listArr.count + 1)] forKey:kArrangeStr];
        [dict setObject:kTime forKey:kBeginTime];
        [dict setObject:kTime forKey:kEndTime];
        [dict setObject:@1 forKey:kImgType];
        [dict setObject:@"外出走访" forKey:kSuperworkType];
        [dict setObject:@"外出走访1" forKey:kSubWorkType];
        [listArr addObject:dict];
        
        [self.rightTableView reloadData];
        NSIndexPath *indexP             = [NSIndexPath indexPathForRow:(listArr.count - 1) inSection:0];
        [self.rightTableView scrollToRowAtIndexPath:indexP atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}
- (void)rightClickSave {
    NSMutableArray *listArr             = [self.dataSourceArr[self.leftSelectedIndex] objectForKey:kList];
    if (listArr.count > 0) {
        NSMutableDictionary *dict       = [listArr lastObject];
        NSString *beginTime             = dict[kBeginTime];
        NSString *endTime               = dict[kEndTime];
        _canAddFlag                     = [self arrangeIsLegalWithBeginTime:beginTime endTime:endTime];
    }
    if (!_canAddFlag && listArr.count > 0) {
        MBProgressHUD *hud              = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode                        = MBProgressHUDModeText;
        hud.label.text                  = @"请先设置好当前班次^_^";
        [hud hideAnimated:YES afterDelay:2];
    } else {
        MBProgressHUD *hud              = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode                        = MBProgressHUDModeText;
        hud.label.text                  = @"保存成功^_^";
        [hud hideAnimated:YES afterDelay:2];
        
        
        self.rightEditBtn.hidden        = NO;
        self.rightAddBtn.hidden         = YES;
        self.rightSaveBtn.hidden        = YES;
        self.isRightCanEdit             = NO;
        self.isRightSaved               = YES;
        self.isHaveArrange              = YES;          //当前编辑好了
        [self.rightTableView reloadData];
    }
}
- (void)setWorkTime:(UIButton *)sender {
    if (_selectedBtn) {
        ViewBorder(_selectedBtn, 1, [UIColor colorWithHexString:@"999999"], 5);
        [_selectedBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    }
    _selectedBtn                     = nil;
    _selectedBtn                     = sender;
    [_selectedBtn setTitleColor:[UIColor colorWithHexString:@"009dec"] forState:UIControlStateNormal];
    ViewBorder(_selectedBtn, 1, [UIColor colorWithHexString:@"009dec"], 5);
    __weak typeof(self) weakSelf     = self;
    OCMTimePickerView *pickerV       = [[OCMTimePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds mode:modeCustom];
    [pickerV show];
    [pickerV setDefaultPosition:sender.titleLabel.text];    //设置默认滚动位置
    
    __block BOOL isLegal                = NO;        //是否合法时间
    __block BOOL isLegal2               = YES;
    pickerV.clickBtnBlock = ^(NSString *str) {
        __strong typeof(weakSelf)  theSelf = weakSelf;
        OCMLog(@"设置的时间为-->%@", str);
        NSString *str1                      = [str substringToIndex:2];
        NSString *str2                      = [str substringWithRange:NSMakeRange(4, 2)];
        str                                 = [NSString stringWithFormat:@"%@:%@",str1,str2];
        OCMCustomArrangeTableViewCell1 *cell = (OCMCustomArrangeTableViewCell1 *)[sender superview];
        NSInteger index                     = [cell.reuseIdentifier integerValue];
        BOOL isFirstArrange                 = NO;
        if (index == 0) isFirstArrange      = YES;
        NSMutableDictionary *currentDict    = self.dataSourceArr[self.leftSelectedIndex];
        NSMutableArray *listArr             = [currentDict objectForKey:kList];
        NSMutableDictionary *dict           = listArr[index];
        
        if (sender.tag == 101) {
            [dict setValue:str forKey:kBeginTime];
            theSelf.beginTemp               = str;
            NSString *beginTemp             = dict[kBeginTime];
            NSString *endTemp               = dict[kEndTime];
            if (!([beginTemp isEqualToString:kTime] || [endTemp isEqualToString:kTime])) {
                isLegal                     = [theSelf timeIsLegalWithBeginTime:beginTemp endTime:endTemp index:index];
            } else {
                isLegal2                    = NO;
            }
        } else if (sender.tag == 102) {
            [dict setValue:str forKey:kEndTime];
            theSelf.endTemp                 = str;
            NSString *beginTemp             = dict[kBeginTime];
            NSString *endTemp               = dict[kEndTime];
            if (!([beginTemp isEqualToString:kTime] || [endTemp isEqualToString:kTime])) {
                isLegal                     = [theSelf timeIsLegalWithBeginTime:beginTemp endTime:endTemp index:index];
            } else {
                isLegal2                    = NO;
            }
        }
        [theSelf.rightTableView reloadData];
        if (!isLegal2) {
            MBProgressHUD *hud    = [MBProgressHUD showHUDAddedTo:theSelf.view animated:YES];
            hud.label.text        = @"请继续添加时间";
            hud.mode              = MBProgressHUDModeText;
            [hud hideAnimated:YES afterDelay:1];
        } else if (!isLegal) {
            MBProgressHUD *hud    = [MBProgressHUD showHUDAddedTo:theSelf.view animated:YES];
            hud.label.text        = @"排班时间不合法";
            hud.mode              = MBProgressHUDModeText;
            [hud hideAnimated:YES afterDelay:1];
        } else {
            MBProgressHUD *hud    = [MBProgressHUD showHUDAddedTo:theSelf.view animated:YES];
            hud.label.text        = @"编辑班次成功";
            hud.mode              = MBProgressHUDModeText;
            [hud hideAnimated:YES afterDelay:1];
            theSelf.canAddFlag   = YES;
            //计算总时间
            theSelf.totoalL.text = [theSelf getTotalTime];
            ViewBorder(theSelf.selectedBtn, 1, [UIColor colorWithHexString:@"999999"], 5);
            [theSelf.selectedBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        }
    };
}
- (void)setNetworkType:(UIButton *)sender {
    __weak typeof(self) weakSelf                  = self;
    CGFloat w                                     = 120.;
    CGFloat h                                     = 100.;
    OCMCustomArrangeTableViewCell1 *cell          = (OCMCustomArrangeTableViewCell1 *)[sender superview];
    NSInteger indexP                              = [cell.reuseIdentifier integerValue];
    CGRect rect1                                  = [sender convertRect:sender.bounds toView:self.view];
    CGFloat x                                     = rect1.origin.x + rect1.size.width - 11;
    CGRect rect                                   = [cell convertRect:cell.bounds toView:self.view];
    CGFloat y                                     = CGRectGetMaxY(rect) - 5;
    CGPoint point                                 = CGPointMake(x, y);
    WBPopOverView *popV                           = [[WBPopOverView alloc] initWithOrigin:point Width:w Height:h Direction:WBArrowDirectionUp4 onView:self.view];
    popV.canHidden                                = YES;
    popV.backView.backgroundColor                 = [UIColor lightGrayColor];
    popV.backView.layer.cornerRadius              = 5;
    [popV popViewToView:self.view];
    OCMTaskTypeTableViewController *areaTableView = [[OCMTaskTypeTableViewController alloc] init];
    OCMSubTaskTableViewController *subTableView   = [[OCMSubTaskTableViewController alloc] init];
    [self addChildViewController:sender.tag       == 103 ?  areaTableView : subTableView];
    areaTableView.dataSourceArr                   = self.taskDataArr; //数据源
    areaTableView.view.frame                      = CGRectMake(0, 0, w, h);
    areaTableView.view.layer.cornerRadius         = 5;
    ViewBorder(areaTableView.view, 1, [UIColor colorWithHexString:@"#cccccc"], 5);
    
    subTableView.dataSourceArr                    = self.subTaskTempArr;
    subTableView.view.frame                       = CGRectMake(0, 0, w, h);
    subTableView.view.layer.cornerRadius          = 5;
    ViewBorder(subTableView.view, 1, [UIColor colorWithHexString:@"#cccccc"], 5);
    
    [popV.backView addSubview:sender.tag          == 103 ? areaTableView.view : subTableView.view];
    __block NSMutableDictionary *dict             = ((NSMutableArray *)[self.dataSourceArr[self.leftSelectedIndex] objectForKey:kList])[indexP];
    areaTableView.taskContentBlock = ^(OCMTaskTypeItem *item) {
        __strong typeof(weakSelf) theSelf         = weakSelf;
        cell.superLabel1.text                     = item.name;
        [dict setObject:item.name forKey:kSubWorkType];
        [dict setObject:@(item.imgType) forKey:kImgType];
        NSArray *arr                              = [theSelf.taskDataArr[item.imgType -1] objectForKey:@"subArr"];
        cell.subLabel2.text                       = arr[0];
        [dict setObject:arr[0] forKey:kSubWorkType];
        [theSelf.rightTableView reloadData];
        switch (item.imgType) {
            case 1:
                cell.superImgV1.image             = ImageIs(@"icon_attence_office");
                break;
            case 2:
                cell.superImgV1.image             = ImageIs(@"icon_attence_out");
                break;
            case 3:
                cell.superImgV1.image             = ImageIs(@"icon_attence_rest");
                break;
            case 4:
                cell.superImgV1.image             = ImageIs(@"icon_attence_train");
                break;
            default:
                break;
        }
        self.subTaskTempArr                       = [NSMutableArray arrayWithArray:item.subArr]; //数据源
    };
    subTableView.subTaskBlock = ^(NSString *subTaskName) {
        cell.subLabel2.text                       = subTaskName;
        [dict setObject:subTaskName forKey:kSubWorkType];
    };
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.leftTableView]) {
        return self.dataSourceArr.count;
    } else {
        NSMutableArray *tempArr = [self.dataSourceArr[self.leftSelectedIndex] objectForKey:kList];
        return tempArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.leftTableView]) {
        static NSString *cellID = @"cellLeft";
        UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text     = (NSString *)[self.dataSourceArr[indexPath.row] objectForKey:kShiftName];
        return cell;
    } else {
        NSString *cellID                        = [NSString stringWithFormat:@"%ld",indexPath.row];
        OCMCustomArrangeTableViewCell1 *cell    = [tableView dequeueReusableCellWithIdentifier:cellID];
        cell.userInteractionEnabled             = self.isRightCanEdit ? YES : NO;
        if (!cell) {
            cell                                = [[OCMCustomArrangeTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.userInteractionEnabled         = self.isRightCanEdit ? YES : NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.textField1 addTarget:self action:@selector(setWorkTime:) forControlEvents:UIControlEventTouchUpInside];
            [cell.textField2 addTarget:self action:@selector(setWorkTime:) forControlEvents:UIControlEventTouchUpInside];
            [cell.superTaskL addTarget:self action:@selector(setNetworkType:) forControlEvents:UIControlEventTouchUpInside];
            [cell.subTaskL addTarget:self action:@selector(setNetworkType:) forControlEvents:UIControlEventTouchUpInside];
            cell.superImgV1.image = ImageIs(@"icon_attence_office");
            cell.superLabel1.text = @"外出走访";
            cell.subLabel2.text   = @"外出走访1";
        }
        NSMutableArray *tempArr    = [self.dataSourceArr[self.leftSelectedIndex] objectForKey:kList];
        NSDictionary *dict         = tempArr[indexPath.row];
        OCMCustomArrangeItem *item = [OCMCustomArrangeItem mj_objectWithKeyValues:dict];
        cell.item                  = item;
        cell.arrangeLabel.text     = [NSString stringWithFormat:@"班次%ld",(indexPath.row + 1)];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.leftTableView]) {
        self.leftSelectedIndex = indexPath.row;
        [self.rightTableView reloadData];
        self.totoalL.text = [self getTotalTime];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.leftTableView]) {
        return 50;
    } else {
        return 100;
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isRightCanEdit && tableView == self.rightTableView) {
        return UITableViewCellEditingStyleNone;//如果不能编辑状态的时候,也不能删除了
    }
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (!_isRightCanEdit) {
//        return;//如果不能编辑状态的时候,也不能删除了
//    }
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([tableView isEqual:self.leftTableView]) {
            if (self.dataSourceArr.count > 1) {
                [self.dataSourceArr removeObjectAtIndex:indexPath.row];
                [self.leftTableView reloadData];
                self.leftSelectedIndex = self.dataSourceArr.count - 1;
                [self.rightTableView reloadData];
                _titleL.text                            = [NSString stringWithFormat:@"班制(%ld)",self.dataSourceArr.count];
            } else {
                MBProgressHUD *hud    = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.label.text        = @"至少要有一个班制吧???";
                hud.mode              = MBProgressHUDModeText;
                [hud hideAnimated:YES afterDelay:1];
            }
        } else {
            NSMutableArray *listArr = [self.dataSourceArr[self.leftSelectedIndex] objectForKey:kList];
            [listArr removeObjectAtIndex:indexPath.row];
            [self.rightTableView reloadData];
            self.totoalL.text                       = [self getTotalTime];
            if (listArr.count == 0) { //如果右侧当前的班次删除完了,左侧选中的也应该删除,刷新左侧
                if (self.dataSourceArr.count > 1) {
                    [self.dataSourceArr removeObjectAtIndex:self.leftSelectedIndex];
                    [self.leftTableView reloadData];
                }
            }
        }
        if (self.dataSourceArr.count == 0) {
            self.isHaveArrange                      = NO;
        }
    }
}
#pragma mark -- lazyInit
- (NSMutableArray *)taskDataArr {
    if (!_taskDataArr) {
        NSArray *arr = @[@{
                             @"imgType":@1,
                             @"name":@"外出走访",
                             @"subArr":@[@"外出走访1",@"外出走访2",@"外出走访3",@"外出走访4"]
                             },
                         @{
                             @"imgType":@2,
                             @"name":@"后台办公",
                             @"subArr":@[@"后台办公1",@"后台办公2",@"后台办公3",@"后台办公4"]
                             },
                         @{
                             @"imgType":@3,
                             @"name":@"外出培训",
                             @"subArr":@[@"外出培训1",@"外出培训2",@"外出培训3",@"外出培训4"]
                             },
                         @{
                             @"imgType":@4,
                             @"name":@"休假",
                             @"subArr":@[@"休假1",@"休假2",@"休假3",@"休假4"]
                             }
                         ];
        _taskDataArr = [NSMutableArray arrayWithArray:arr];
    }
    return _taskDataArr;
}
- (NSMutableArray *)dataSourceArr {
    if (!_dataSourceArr) {
        NSMutableArray *tempArr   = [NSMutableArray array];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"班次1" forKey:kArrangeStr];
        [dict setObject:kTime forKey:kBeginTime];
        [dict setObject:kTime forKey:kEndTime];
        [dict setObject:@1 forKey:kImgType];
        [dict setObject:@"外出走访" forKey:kSuperworkType];
        [dict setObject:@"外出走访1" forKey:kSubWorkType];
        [tempArr addObject:dict];
        NSMutableDictionary *bigDict = [NSMutableDictionary dictionary];
        [bigDict setObject:@1 forKey:kID];
        [bigDict setObject:@"班制1" forKey:kShiftName];
        [bigDict setObject:tempArr forKey:kList];
        _dataSourceArr            = [NSMutableArray arrayWithObject:bigDict];
    }
    return _dataSourceArr;
}
@end
