//
//  OCMArrangeViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/4/12.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMArrangeViewController.h"
#import "OCMCalendarCollectionViewCell.h"
#import "OCMCalendarHeaderView.h"
#import "OCMCalendarItem.h"
/**
 *长按出来的
 */
#import "OCMPresentFormSheetViewController.h"   //导航控制器
#import "OCMSheetArrangeViewController.h"
/**
 *点击排班的
 */
#import "OCMArrangeNavViewController.h"
#import "OCMCustomArrangeVC.h"

#import "OCMTimePickerView.h"
#import "OCMShiftViewController.h"

@interface OCMArrangeViewController ()
/***长按出来的*/
@property (nonatomic, strong) OCMPresentFormSheetViewController *sheetVC;
@property (nonatomic, strong) OCMSheetArrangeViewController     *arrangeVC;
/***点击排班的*/
@property (nonatomic, strong) OCMArrangeNavViewController       *arrangeNaviVC;
@property (nonatomic, strong) OCMCustomArrangeVC                *customArrangeVC;
/**班制数据源*/
@property (nonatomic, strong) NSMutableArray                    *attendArr;
@property (nonatomic, assign) BOOL                              isNewSet;
@property (nonatomic, strong) NSMutableArray                    *arrNewSetArr; //根据班制选中的数据源
@end

@implementation OCMArrangeViewController

- (void)viewDidLoad {
    [super viewDidLoad]; //排班
    self.view.backgroundColor = [UIColor blueColor];
    
    
    OCMSheetArrangeViewController *arrangeVC   = [[OCMSheetArrangeViewController alloc] init];
    OCMPresentFormSheetViewController *sheetVC = [[OCMPresentFormSheetViewController alloc] initWithRootViewController:arrangeVC];
    self.sheetVC                               = sheetVC;
    self.arrangeVC                             = arrangeVC;
    _isNewSet                                  = NO;
}
#pragma mark -- 点击事件
- (void)clikcArrangeBtn:(UIButton *)sender {
    if (self.selectedItem) {
        if ([sender.titleLabel.text isEqualToString:@"排班"]) {  //自定义排班
            _customArrangeVC                          = [[OCMCustomArrangeVC alloc] init];
            _arrangeNaviVC                            = [[OCMArrangeNavViewController alloc] initWithRootViewController:_customArrangeVC];
            self.arrangeNaviVC.modalPresentationStyle = UIModalPresentationFormSheet;
            self.arrangeNaviVC.modalTransitionStyle   = UIModalTransitionStyleFlipHorizontal;
            self.arrangeNaviVC.preferredContentSize   = CGSizeMake(700, 400);
            [self presentViewController:self.arrangeNaviVC animated:YES completion:nil];
            
            __weak typeof(self) weakSelf              = self;
            self.customArrangeVC.dismissBlock         = ^{
                typeof(weakSelf) theSelf              = weakSelf;
                theSelf.customArrangeVC               = nil;
                theSelf.arrangeNaviVC                 = nil;
            };
        } else { // 班制排班
            OCMTimePickerView *pickerV       = [[OCMTimePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds mode:modeAttendace];
            OCMShiftViewController *shiftVC  = [OCMShiftViewController sharedInstance];
            if (shiftVC.isHaveArrange) {
                NSMutableArray *tempArr          = [NSMutableArray array];
                NSMutableArray *dataArr          = [NSMutableArray array];
                for (NSMutableDictionary *dict in shiftVC.dataSourceArr) {
                    NSString *str = [dict objectForKey:@"shiftName"];
                    [tempArr addObject:str];
                    NSMutableDictionary *dataDict = [dict objectForKey:@"list"];
                    [dataArr addObject:dataDict];
                }
                pickerV.attendaceArr             = tempArr;
                [pickerV show];
                __weak typeof(self) weakSelf     = self;
                pickerV.indexBlock = ^(NSInteger index) {
                    typeof(weakSelf) theSelf     = weakSelf;
                    NSMutableArray *arr          = dataArr[index];
                    OCMLog(@"--index--%@", dataArr[index]);
                    NSMutableArray *newSetArr    = [NSMutableArray array];
                    for (NSMutableDictionary *dict in arr) {
                        NSString *beginTime      = [dict objectForKey:@"beginTime"];
                        NSString *endTime        = [dict objectForKey:@"endTime"];
                        NSString *str            = [NSString stringWithFormat:@"%@-%@",beginTime,endTime];
                        NSInteger imgType        = [[dict objectForKey:@"imgType"] integerValue];
                        NSArray *tempArr         = @[str,@(imgType)];
                        [newSetArr addObject:tempArr];
                    }
                    theSelf.selectedItem.calendarItem.arrangeInToday = newSetArr;
                    theSelf.arrNewSetArr         = newSetArr;
                    // 实际生产情况,应该根据选中的下标,替换数据源数组下标的该数据
                    theSelf.isNewSet             = YES;
                    [theSelf.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:self.selectedIndexPath]];
                };
            } else {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode           = MBProgressHUDModeText;
                hud.label.text     = @"请先编辑好班制";
                [hud hideAnimated:YES afterDelay:1];
            }
        }
    } else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode           = MBProgressHUDModeText;
        hud.label.text     = @"请选择日期";
        [hud hideAnimated:YES afterDelay:1];
    }
    
    
}
#pragma mark -- 加载后修改显示状态
- (void)setOtherStyle:(OCMCalendarCollectionViewCell *)item indexP:(NSIndexPath *)indexPath {
//    [self.collectionView setContentOffset:CGPointMake(0, self.offSetY)];
//    [self.collectionView setContentOffset:CGPointMake(0, self.todayFrameY)];
//    [self.collectionView scrollToItemAtIndexPath:self.todayIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    if (_isNewSet) {
        item.calendarItem.textColor      = arc4random() % 3;
        item.calendarItem.arrangeInToday = _arrNewSetArr;
        [item configSecondStylewithItem];
        _isNewSet                        = NO;
    } else {
        item.calendarItem.textColor      = arc4random() % 3;
        item.calendarItem.arrangeInToday = self.arrangeArr[arc4random() % 6];
        [item configSecondStylewithItem];
    }
}
//- (void)setNewStyle:(OCMCalendarCollectionViewCell *)item indexP:(NSIndexPath *)indexPath arr:(NSMutableArray *)newArr{
//    item.calendarItem.textColor      = arc4random() % 3;
//    item.calendarItem.arrangeInToday = self.arrangeArr[arc4random() % 6];
//    [item configSecondStylewithItem];
//}
- (void)setHeadSubviewHidden {
    self.headerV.reportBtn.hidden = YES;
    [self.headerV.arrangeBtn addTarget:self action:@selector(clikcArrangeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerV.selectShiftBtn addTarget:self action:@selector(clikcArrangeBtn:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)clickItem:(OCMCalendarCollectionViewCell *)item {
    self.sheetVC.modalPresentationStyle = UIModalPresentationFormSheet;
    self.sheetVC.modalTransitionStyle   = UIModalTransitionStyleFlipHorizontal;
    self.sheetVC.preferredContentSize   = CGSizeMake(420, 443);
    self.arrangeVC.calendarItem         = item.calendarItem;
    self.arrangeVC.iconArr              = item.iconTypeArr;
    [self presentViewController:self.sheetVC animated:YES completion:nil];
}

#pragma mark -- lazyInit
- (NSMutableArray<NSArray *> *)arrangeArr {
    if (!_arrangeArr) {
        _arrangeArr = [NSMutableArray arrayWithObjects:@[
                                                         @[@"08:03-12:24",@2],
                                                         @[@"14:23-16:47",@0],
                                                         @[@"16:51-17:13",@1],
                                                         @[@"17:28-18:24",@3],
                                                         @[@"18:45-19:09",@2]
                                                         ],
                                                       @[
                                                        @[@"08:17-12:14",@2],
                                                        @[@"14:29-16:41",@3],
                                                        @[@"16:47-17:11",@1],
                                                        @[@"17:27-18:13",@0]
                                                        ],
                                                       @[
                                                         @[@"08:27-12:17",@1],
                                                         @[@"14:39-16:14",@2],
                                                         @[@"16:16-17:23",@3]
                                                         ],
                                                       @[
                                                         @[@"08:24-12:18",@1],
                                                         @[@"14:47-16:23",@2]
                                                         ],
                                                       @[
                                                         @[@"08:21-12:34",@1]
                                                         ],
                                                       @[
                                                         ],
                                                           nil
                                                            ];
    }
    return _arrangeArr;
}
- (NSMutableArray *)attendArr {
    if (!_attendArr) {
        _attendArr = [NSMutableArray arrayWithObjects:@"班制1",@"班制2",@"班制3", nil];
    }
    return _attendArr;
}
#pragma mark -- dealloc
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
