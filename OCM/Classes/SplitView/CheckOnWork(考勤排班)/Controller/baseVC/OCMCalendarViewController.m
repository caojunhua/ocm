//
//  OCMCalendarViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/4/12.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMCalendarViewController.h"
#import "OCMCalendarCollectionViewCell.h"
#import "OCMCalendarHeaderView.h"
#import "OCMCalendarItem.h"
#import "OCMCalendarHeaderViewForSection.h"


@interface OCMCalendarViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) OCMCalendarHeaderView         *headerView;                             //头部view
@property (nonatomic, strong) NSCalendar                    *calendar;                               //日历
@property (nonatomic, strong) NSData                        *currentData;                            //当前日期
/*日历组件相关*/
@property (nonatomic, copy)   NSString                      *startDay;                               //开始日期
@property (nonatomic, copy)   NSString                      *endDay;                                 //结束日期
///激活开始和结束时间内的颜色
@property (nonatomic, assign) BOOL                          actvityColor;
///格式：2018-1-17
@property (nonatomic, copy)   NSString                      *selectedDate;
///默认："%zd年%zd月"
@property (nonatomic, copy)   NSString                      *yearMonthFormat;                        //显示年月格式
///默认："%zd月"
@property (nonatomic, copy)   NSString                      *monthFormat;                            //显示年月格式
@property (nonatomic, strong) NSIndexPath                   *lastIndexPath;

/*日历数据源*/
@property (nonatomic, strong) NSMutableArray                *dataSource;

@property (nonatomic, strong) UILongPressGestureRecognizer  *longPressGes;                           //长按手势
@end

@implementation OCMCalendarViewController
static NSString *cellID       = @"cell";
static NSString *headerViewID = @"headerViewID";
static NSString *footerViewID = @"footerViewID";
- (instancetype)init {
    if (self = [super init]) {
        self.startDay        = @"2017-3-1";
        self.endDay          = @"2020-12-31";
        self.yearMonthFormat = @"%zd年%02zd月";
        self.monthFormat     = @"%02zd月";
        self.actvityColor    = YES;
        [self configDataSource];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)longPressGestrue:(UILongPressGestureRecognizer *)gesRecgonizer {
    CGPoint pointTouch = [gesRecgonizer locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pointTouch];
    if (gesRecgonizer.state == UIGestureRecognizerStateBegan) {
        OCMLog(@"长按开始");
        if (indexPath == nil) {
            OCMLog(@"点击空");
        } else {
            OCMLog(@"indexPath--%ld\%ld", indexPath.section,indexPath.row);
            if (indexPath != nil) {
                OCMCalendarCollectionViewCell *item = (OCMCalendarCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
                self.selectedItem.selected          = NO;
                item.selected                       = YES;
                self.selectedItem                   = item;
                [self clickItem:item];
            }
        }
    }
    if (gesRecgonizer.state == UIGestureRecognizerStateChanged) {
        OCMLog(@"长按改变");
        
    }
    if (gesRecgonizer.state == UIGestureRecognizerStateEnded) {
        OCMLog(@"长按结束");
        
    }
}
#pragma mark -- dataSource
- (void)configDataSource {
    NSArray   *startArray = [self.startDay componentsSeparatedByString:@"-"];
    NSArray   *endArray   = [self.endDay componentsSeparatedByString:@"-"];
    //总共展示多少个月
    NSInteger month       = ([endArray[0] integerValue] - [startArray[0] integerValue]) * 12 + ([endArray[1] integerValue] - [startArray[1] integerValue]) + 1;
    
    for (int i = 0; i < month; i++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [self.dataSource addObject:array];
    }
    
    for (int i = 0; i < month; i++) {
        int              currentM       = ((int)[NSDate month:self.startDay] + i) % 12;
        NSDateComponents *components = [[NSDateComponents alloc] init];
        
        //获取下个月的年月日信息,并将其转为date
        components.month = currentM ? currentM : 12;   //如果取余等于0,就是12月
        components.year  = [startArray[0] integerValue] + ((int)[NSDate month:self.startDay] + i - 1)/12; //获取年
        components.day   = 1;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate     *nextDate = [calendar dateFromComponents:components];
        
        //获取该月第一天星期几
        NSInteger firstDayInThisMounth = [NSDate firstWeekdayInThisMonth:nextDate];
        
        //该月的有多少天daysInThisMounth
        NSInteger daysInThisMounth = [NSDate totaldaysInMonth:nextDate];
        NSString  *string          = [[NSString alloc] init];
        for (int j = 0; j < (daysInThisMounth > 29 && (firstDayInThisMounth == 6 || (firstDayInThisMounth == 5 && daysInThisMounth == 31)) ? 42 : 35); j++) {//如果这个月第一天就周日,并且大于29天,那么这个月会占据6行,就是42个格子,否则就是占据5行,就是35个格子
            OCMCalendarItem *model = [[OCMCalendarItem alloc] init];
            model.year             = components.year;
            model.month            = components.month;
            if (j < firstDayInThisMounth || j > daysInThisMounth + firstDayInThisMounth - 1) {
                string    = @"";
                model.day = string;
            } else {
                string    = [NSString stringWithFormat:@"%ld", j - firstDayInThisMounth + 1];
                model.day = string;
                
                NSString *dateStr = [NSString stringWithFormat:@"%zd-%02zd-%@",model.year, model.month, model.day];
                if ([self isActivity:dateStr]) {
                    model.activityColor = [UIColor blackColor];
                }
                if (self.selectedDate.length) {
                    if ([NSDate isEqualBetweenWithDate:self.selectedDate toDate:dateStr]) {
                        model.isSelected = YES;
                        self.lastIndexPath = [NSIndexPath indexPathForRow:j inSection:i];
                    }
                    if ([NSDate isToday:dateStr]) {
                        model.isToday = YES;
                    }
                } else {
                    if ([NSDate isToday:dateStr]) {
                        model.isToday = YES;
                        model.isSelected = YES;
                        self.lastIndexPath = [NSIndexPath indexPathForRow:j inSection:i];
                    }
                }
            }
            [[self.dataSource objectAtIndex:i] addObject:model];
        }
    }
    [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx0, BOOL * _Nonnull stop) {
        NSMutableArray *arr = self.dataSource[idx0];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx1, BOOL * _Nonnull stop) {
            OCMCalendarItem *item = arr[idx1];
            if (item.isToday) {
                _todayIndexPath = [NSIndexPath indexPathForItem:idx1 inSection:idx0];
                OCMLog(@"_todayIndexP--%@", _todayIndexPath);
            }
        }];
    }];
}
- (void)setData { //修改显示月份
    self.headerV.yearMonthLabel.text = @"2018年05月";
}
- (BOOL)isActivity:(NSString *)date {
    BOOL activity = NO;
    
    NSTimeInterval startInterval   = [NSDate timeIntervalFromDateString:[NSString stringWithFormat:@"%@ 00:00:00", self.startDay]];
    NSTimeInterval endInterval     = [NSDate timeIntervalFromDateString:[NSString stringWithFormat:@"%@ 00:00:00", self.endDay]];
    NSTimeInterval currentInterval = [NSDate timeIntervalFromDateString:[NSString stringWithFormat:@"%@ 00:00:00", date]];
    if (currentInterval >= startInterval && currentInterval <= endInterval) {
        activity = YES;
    }
    return activity;
}
- (void)loadSubView:(CGFloat)currentW {
    if (self.view.subviews) {
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
            obj = nil;
        }];
    }
    [self initHeaderView:CGRectMake(0, 0, currentW, 85)];
    [self initCollectionView:currentW];
}
- (void)initHeaderView:(CGRect)rect {
    OCMCalendarHeaderView *headerV = [[OCMCalendarHeaderView alloc] initWithFrame:rect];
    _headerV                       = headerV;
    [self.view addSubview:headerV];
    [self setHeadSubviewHidden];
}
- (void)initCollectionView:(CGFloat)currentW {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth                      = (currentW - 3.7) / 7;
    flowLayout.itemSize                    = CGSizeMake(itemWidth,itemWidth);
    [flowLayout setHeaderReferenceSize:CGSizeMake(self.collectionView.width, 25)]; //需要设置头部Size,才能回调对应方法
    flowLayout.minimumInteritemSpacing     = 0.5;
    flowLayout.minimumLineSpacing          = 0.5;
    flowLayout.sectionInset                = UIEdgeInsetsMake(0.5, 0, 0.5, 0);
    CGFloat y                              = 85.f; //头部headerView的高度为85,y值从85开始
    _collectionView                        = [[UICollectionView alloc] initWithFrame:
                                              CGRectMake(0, y, currentW, screenHeight - y- 64)
                                              collectionViewLayout:flowLayout];
    _collectionView.delegate               = self;
    _collectionView.dataSource             = self;
    _collectionView.backgroundColor        = [UIColor colorWithHexString:@"e5e5e5"];
    [_collectionView registerClass:[OCMCalendarCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [_collectionView registerClass:[OCMCalendarHeaderViewForSection class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewID];
    [self.view addSubview:_collectionView];
    
    _longPressGes                          = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestrue:)];
    _longPressGes.minimumPressDuration     = 1.0f;
    [self.collectionView addGestureRecognizer:_longPressGes];
    
//    _collectionView.scrollEnabled          = NO;  //禁止滚动
    [self.collectionView scrollToItemAtIndexPath:self.todayIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
}
#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OCMCalendarCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [self setItemStyle:item indexP:indexPath]; //设置子类共有属性
    [self setOtherStyle:item indexP:indexPath]; //设置子类特有属性
    
    return item;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        OCMCalendarHeaderViewForSection *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewID forIndexPath:indexPath];
        OCMCalendarItem *item = self.dataSource[indexPath.section][indexPath.item];
        [headerV addObserver:self forKeyPath:@"frame" options:0 context:NULL];
        self.headerV.yearMonthLabel.text = [NSString stringWithFormat:self.yearMonthFormat.length ? self.yearMonthFormat : @"%zd年%zd月", item.year, item.month];
        headerV.monthL.text = [NSString stringWithFormat:self.monthFormat.length ? self.monthFormat : @"%zd月", item.month];
        reusableview = headerV;
    }
    return reusableview;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    OCMCalendarCollectionViewCell *item = (OCMCalendarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.selectedItem.selected          = NO;
    item.selected                       = YES;
    self.selectedItem                   = item;
    self.selectedIndexPath              = indexPath;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    self.offSetY = point.y;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    CGRect rect = CGRectNull;
    if ([keyPath isEqualToString:@"frame"]) {
        
        if ([object valueForKey:keyPath] != [NSNull null]) {
            rect = [[object valueForKey:keyPath] CGRectValue];
            OCMLog(@"rect-->%f", rect.origin.y);
        }
    }
}
/**
设置样式
 @param item 设置子类共有属性
 */
- (void)setItemStyle:(OCMCalendarCollectionViewCell *)item indexP:(NSIndexPath *)indexPath {
    //防止复用问题
    [item.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
        obj = nil;
    }];
    
    if (indexPath.row % 7 == 0 || indexPath.row % 7 == 6) {
        item.backgroundColor = [UIColor RGBColorWithRed:252 withGreen:252 withBlue:252 withAlpha:1.0];
    } else {
        item.backgroundColor = [UIColor whiteColor];
    }
    item.style = 1;
    item.calendarItem = self.dataSource[indexPath.section][indexPath.item];
    

}

/**
 子类 -->额外布局

 @param item cell
 @param indexPath 下标
 */
- (void)setOtherStyle:(OCMCalendarCollectionViewCell *)item indexP:(NSIndexPath *)indexPath {
    
}

/**
 子类 -->设置头部隐藏或显示状态
 */
- (void)setHeadSubviewHidden {
    
}
/**
 * 点击了某一天  --> 子类去实现,弹出窗口
 */
- (void)clickItem:(OCMCalendarCollectionViewCell *)item {
    
}
#pragma mark -- lazyInit
- (NSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; //公历日历算法
    }
    return _calendar;
}
- (NSData *)currentData {
    if (!_currentData) {
        _currentData = [NSData data];
    }
    return _currentData;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
#pragma mark -- dealloc
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
}

@end
