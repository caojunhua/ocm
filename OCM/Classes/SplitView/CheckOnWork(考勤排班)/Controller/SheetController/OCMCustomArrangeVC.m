//
//  OCMCustomArrangeVC.m
//  OCM
//
//  Created by 曹均华 on 2018/4/26.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMCustomArrangeVC.h"
#import "OCMCustomArrangeTableViewCell.h"
#import "OCMTimePickerView.h"
#import "OCMCustomArrangeItem.h"
#import "WBPopOverView.h"
#import "OCMTaskTypeTableViewController.h"
#import "OCMTaskTypeItem.h"
#import "OCMSubTaskTableViewController.h"

@interface OCMCustomArrangeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, assign) BOOL                               canAddFlag;         //当前能否继续添加班次
@property (nonatomic, copy)   NSString                           *beginTemp;         //开始计算时间
@property (nonatomic, copy)   NSString                           *endTemp;           //结束计算时间
@property (nonatomic, strong) UIButton                           *selectedBtn;
@property (nonatomic, assign) CGFloat                            totalTime;
@property (nonatomic, strong) UILabel                            *totalTimeLabel;       //总时间
@property (nonatomic, strong) NSMutableArray                     *subTaskTempArr;       //子任务展示的数据
@end

@implementation OCMCustomArrangeVC
#define kWidth          700
#define kHeight         400
#define kTime           @"00:00"
#define kBeginTime      @"beginTime"
#define kEndTime        @"endTime"
#define kArrangeStr     @"arrangeStr"
#define kImgType        @"imgType"
#define kSuperworkType  @"superworkType"
#define kSubWorkType    @"subWorkType"
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame           = CGRectMake(0, 0, kWidth, kHeight);
    _canAddFlag               = NO;
    _totalTime                = 0.f;
    _subTaskTempArr           = [NSMutableArray array];
    [self setHeaderView];
    [self configTableView];
    [self configBottomUI];
}
- (void)setHeaderView {
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addArrange)];
    UILabel *titleL                        = [[UILabel alloc] init];
    titleL.text                            = @"自定义考情排班";
    titleL.textColor                       = [UIColor colorWithHexString:@"333333"];
    titleL.font                            = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView          = titleL;
}
- (void)configTableView {
    _tableView                = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 100) style:UITableViewStylePlain];
    _tableView.delegate       = self;
    _tableView.dataSource     = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
- (void)configBottomUI {
    CGFloat       y         = CGRectGetMaxY(_tableView.frame);
    UIView *bottomV         = [[UIView alloc] initWithFrame:CGRectMake(0, y + 40, kWidth, kHeight - y)];
    bottomV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:bottomV];
    
    UIView *sepV            = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bottomV.width, 1)];
    sepV.backgroundColor    = [UIColor colorWithHexString:@"333333"];
    [bottomV addSubview:sepV];
    
    UIButton *btn           = [[UIButton alloc] init];
    [bottomV addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomV.mas_centerX);
        make.bottom.mas_equalTo(bottomV.mas_bottom).offset(-20);
        make.width.mas_equalTo(170);
        make.height.mas_equalTo(35);
    }];
    ViewBorder(btn, 1, [UIColor clearColor], 5);
    [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"009dec"]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(submitArrange) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label1         = [[UILabel alloc] init];
    label1.textColor        = [UIColor colorWithHexString:@"333333"];
    label1.text             = @"总时长:";
    label1.font             = [UIFont systemFontOfSize:14];
    [bottomV addSubview:label1];
    
    _totalTimeLabel         = [[UILabel alloc] init];
    _totalTimeLabel.font    = [UIFont systemFontOfSize:14];
    _totalTimeLabel.textColor = KRedColor;
    _totalTimeLabel.text    = @"0.00";
    [bottomV addSubview:_totalTimeLabel];
    
    UILabel *label2         = [[UILabel alloc] init];
    label2.textColor        = [UIColor colorWithHexString:@"333333"];
    label2.font             = [UIFont systemFontOfSize:14];
    label2.text             = @"小时";
    [bottomV addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sepV.mas_bottom).offset(8);
        make.right.mas_equalTo(bottomV.mas_right).offset(-20);
    }];
    [_totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label2.mas_centerY);
        make.right.mas_equalTo(label2.mas_left);
    }];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label2.mas_centerY);
        make.right.mas_equalTo(_totalTimeLabel.mas_left);
    }];
}
#pragma mark -- 相关时间算法
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
    if (index == self.dataSourceArr.count - 1 && index > 0) {   //当前编辑的班次是最新的班次 && 至少是从第2个开始
        BOOL oneBool              = [self arrangeIsLegalWithBeginTime:beginTime endTime:endTime]; //1.结束时间 - 开始时间  >= 60min  ?
        NSMutableDictionary *dict = self.dataSourceArr[index - 1];
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
            if (self.dataSourceArr.count > 1) {
                NSMutableDictionary *dict = self.dataSourceArr[index + 1];
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
            NSMutableDictionary *lastDict = self.dataSourceArr[index - 1];
            NSString *lastEndTime         = lastDict[kEndTime];
            BOOL twoBool                  = [self arrangeIsLegalWithBeginTime:lastEndTime endTime:beginTime]; // 开始时间 - 上个结束时间 >= 60min?
            NSMutableDictionary *nextDict = self.dataSourceArr[index + 1];
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
    NSArray *beginArr  = [beginTime componentsSeparatedByString:@":"];
    NSArray *endArr    = [endTime componentsSeparatedByString:@":"];
    NSInteger totalMin = ([endArr[0] integerValue] - [beginArr[0] integerValue]) * 60 + ([endArr[1] integerValue] - [beginArr[1] integerValue]);
    CGFloat timeF      = totalMin / 60.f;
    return timeF;
}

/**
 计算总时间
 */
- (NSString *)getTotalTime {
    CGFloat total           = 0.f;
    for (NSMutableDictionary *dict in self.dataSourceArr) {
        NSString *beginTime = dict[kBeginTime];
        NSString *endTime   = dict[kEndTime];
        CGFloat tempTime    = [self caculateWithBeginTime:beginTime endTime:endTime];
        total              += tempTime;
    }
    return [NSString stringWithFormat:@"%.2f",total];
}
#pragma mark -- 点击事件
- (void)addArrange {
    OCMLog(@"添加");
    if (self.dataSourceArr.count > 0) {
        NSMutableDictionary *dict = [self.dataSourceArr lastObject];
        NSString *beginTime = dict[kBeginTime];
        NSString *endTime = dict[kEndTime];
        _canAddFlag = [self arrangeIsLegalWithBeginTime:beginTime endTime:endTime];
    }
    if (!_canAddFlag && self.dataSourceArr.count > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode           = MBProgressHUDModeText;
        hud.label.text     = @"请先设置好当前班次";
        [hud hideAnimated:YES afterDelay:2];
    } else {
        //新增班次后,之前的flag还原
        _canAddFlag               = NO;
        _beginTemp                = nil;
        _endTemp                  = nil;
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSString stringWithFormat:@"班次%ld",(self.dataSourceArr.count + 1)] forKey:@"arrangeStr"];
        [dict setObject:kTime forKey:kBeginTime];
        [dict setObject:kTime forKey:kEndTime];
        [self.dataSourceArr addObject:dict];
        [self.tableView reloadData];
        NSIndexPath *indexP = [NSIndexPath indexPathForRow:(self.dataSourceArr.count - 1) inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexP atScrollPosition:UITableViewScrollPositionBottom animated:NO];
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
        OCMCustomArrangeTableViewCell *cell = (OCMCustomArrangeTableViewCell *)[sender superview];
        NSInteger index                     = [cell.reuseIdentifier integerValue];
        BOOL isFirstArrange                 = NO;
        if (index == 0) isFirstArrange      = YES;
        NSMutableDictionary *dict           = self.dataSourceArr[index];
        
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
        [theSelf.tableView reloadData];
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
            theSelf.totalTimeLabel.text = [theSelf getTotalTime];
            ViewBorder(theSelf.selectedBtn, 1, [UIColor colorWithHexString:@"999999"], 5);
            [theSelf.selectedBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        }
    };
}
- (void)setNetworkType:(UIButton *)sender {
    __weak typeof(self) weakSelf                  = self;
    CGFloat w                                     = 120.;
    CGFloat h                                     = 100.;
    OCMCustomArrangeTableViewCell *cell           = (OCMCustomArrangeTableViewCell *)[sender superview];
    NSInteger indexP                              = [cell.reuseIdentifier integerValue];
    CGFloat x                                     = sender.tag == 103 ? 511 : 642;
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
    [self addChildViewController:sender.tag == 103 ?  areaTableView : subTableView];
    areaTableView.dataSourceArr                   = self.taskDataArr; //数据源
    areaTableView.view.frame                      = CGRectMake(0, 0, w, h);
    areaTableView.view.layer.cornerRadius         = 5;
    ViewBorder(areaTableView.view, 1, [UIColor colorWithHexString:@"#cccccc"], 5);
    
    subTableView.dataSourceArr                    = self.subTaskTempArr;
    subTableView.view.frame                       = CGRectMake(0, 0, w, h);
    subTableView.view.layer.cornerRadius          = 5;
    ViewBorder(subTableView.view, 1, [UIColor colorWithHexString:@"#cccccc"], 5);
    
    __block NSMutableDictionary *dict             = self.dataSourceArr[indexP];
    [popV.backView addSubview:sender.tag == 103 ? areaTableView.view : subTableView.view];
    areaTableView.taskContentBlock = ^(OCMTaskTypeItem *item) {
        __strong typeof(weakSelf) theSelf         = weakSelf;
        cell.superLabel1.text                     = item.name;
        [dict setObject:item.name forKey:kSubWorkType];
        [dict setObject:@(item.imgType) forKey:kImgType];
        NSArray *arr                              = [theSelf.taskDataArr[item.imgType -1] objectForKey:@"subArr"];
        cell.subLabel2.text                       = arr[0];
        [dict setObject:arr[0] forKey:kSubWorkType];
        [theSelf.tableView reloadData];
        switch (item.imgType) {
            case 1:
                cell.superImgV1.image = ImageIs(@"icon_attence_office");
                break;
            case 2:
                cell.superImgV1.image = ImageIs(@"icon_attence_out");
                break;
            case 3:
                cell.superImgV1.image = ImageIs(@"icon_attence_rest");
                break;
            case 4:
                cell.superImgV1.image = ImageIs(@"icon_attence_train");
                break;
            default:
                break;
        }
        self.subTaskTempArr           = [NSMutableArray arrayWithArray:item.subArr]; //数据源
    };
    subTableView.subTaskBlock = ^(NSString *subTaskName) {
        cell.subLabel2.text          = subTaskName;
    };
}

- (void)dismiss {
    self.dismissBlock();
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)submitArrange {
    if (self.dataSourceArr.count > 0) {
        NSMutableDictionary *dict = [self.dataSourceArr lastObject];
        NSString *beginTime = dict[kBeginTime];
        NSString *endTime = dict[kEndTime];
        _canAddFlag = [self arrangeIsLegalWithBeginTime:beginTime endTime:endTime];
    }
    if (!_canAddFlag && self.dataSourceArr.count > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode           = MBProgressHUDModeText;
        hud.label.text     = @"请先设置好当前班次";
        [hud hideAnimated:YES afterDelay:2];
    } else {
       //提交数据
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode           = MBProgressHUDModeText;
        hud.label.text     = @"提交成功";
        [hud hideAnimated:YES afterDelay:2];
        __weak typeof(self) weakSelf          = self;
        dispatch_time_t delayT                = GCD_delayT(2.5);
        dispatch_after(delayT, dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) theSelf = weakSelf;
            [theSelf dismiss];
        });
    }
}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID                    = [NSString stringWithFormat:@"%ld",indexPath.row];
    OCMCustomArrangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell                   = [[OCMCustomArrangeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.textField1 addTarget:self action:@selector(setWorkTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.textField2 addTarget:self action:@selector(setWorkTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.superTaskL addTarget:self action:@selector(setNetworkType:) forControlEvents:UIControlEventTouchUpInside];
        [cell.subTaskL addTarget:self action:@selector(setNetworkType:) forControlEvents:UIControlEventTouchUpInside];
        cell.superImgV1.image  = ImageIs(@"icon_attence_office");
        cell.superLabel1.text  = @"外出走访";
        cell.subLabel2.text    = @"外出走访1";
    }
    NSDictionary *dict         = self.dataSourceArr[indexPath.row];
    OCMCustomArrangeItem *item = [OCMCustomArrangeItem mj_objectWithKeyValues:dict];
    cell.item                  = item;
    cell.arrangeLabel.text     = [NSString stringWithFormat:@"班次%ld",(indexPath.row + 1)];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataSourceArr removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}
#pragma mark -- lazyInit
- (NSMutableArray *)dataSourceArr {
    if (!_dataSourceArr) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"班次1" forKey:kArrangeStr];
        [dict setObject:kTime forKey:kBeginTime];
        [dict setObject:kTime forKey:kEndTime];
        [dict setObject:@1 forKey:kImgType];
        [dict setObject:@"外出走访" forKey:kSuperworkType];
        [dict setObject:@"外出走访1" forKey:kSubWorkType];
        _dataSourceArr            = [NSMutableArray arrayWithObject:dict];
    }
    return _dataSourceArr;
}
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

#pragma mark -- dealloc
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    OCMLog(@"OCMCustomArrange释放");
}


@end
