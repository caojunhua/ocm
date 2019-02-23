//
//  OCMLeftBottomViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/19.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMLeftBottomViewController.h"

@interface OCMLeftBottomViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation OCMLeftBottomViewController
static NSString *CellID = @"cellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
    [self addTitleView];
    self.view.frame = CGRectMake(0, 0, kLeftTopWidth, 200);
    self.view.backgroundColor = [UIColor RGBColorWithRed:241 withGreen:241 withBlue:241 withAlpha:0.8];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self setData];
    });
}
- (void)addTitleView {
    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor RGBColorWithRed:255 withGreen:255 withBlue:255 withAlpha:0.8];
    view.frame = CGRectMake(0, 0, kLeftTopWidth, 25);
    [self.view addSubview:view];
    
    UISwipeGestureRecognizer *swipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipe1.direction = UISwipeGestureRecognizerDirectionUp;
    [view addGestureRecognizer:swipe1];
    
    UISwipeGestureRecognizer *swipe2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipe2.direction = UISwipeGestureRecognizerDirectionDown;
    [view addGestureRecognizer:swipe2];
    
    UILabel *titleL = [UILabel new];
    titleL.text = @"公告";
    titleL.font = [UIFont boldSystemFontOfSize:14];
    titleL.textColor = [UIColor colorWithHexString:@"#009dec"];
    titleL.frame = CGRectMake(kLeftTopWidth * 0.5 - 15, 0, 30, 25);
    [view addSubview:titleL];
    
    UIImageView *imgV = [[UIImageView alloc] init];
    _imgV = imgV;
    imgV.image = [UIImage imageNamed:@"ggsla-1"];
    [view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleL.mas_centerY);
        make.left.mas_equalTo(titleL.mas_right);
    }];
    
    UIView *sepV = [[UIView alloc] initWithFrame:CGRectMake(0, 25, kLeftTopWidth, 0.5)];
    sepV.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    [view addSubview:sepV];
}
- (void)addTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 25, kLeftTopWidth, 175) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.alpha = 0.5;
//    _tableView.backgroundColor = [UIColor RGBColorWithRed:216 withGreen:191 withBlue:216 withAlpha:0.5];
    _tableView.backgroundColor = [UIColor RGBColorWithRed:241 withGreen:241 withBlue:241 withAlpha:0.8];
    [self.view addSubview:_tableView];
}
#pragma mark -- 手势
- (void)swipe:(UISwipeGestureRecognizer *)swipe {
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        OCMLog(@"up");
        BOOL isUp = YES;
        self.swipeUpOrDown(isUp);
    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionDown) {
        OCMLog(@"down");
        BOOL isUp = NO;
        self.swipeUpOrDown(isUp);
    }
}
#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.backgroundColor = [UIColor RGBColorWithRed:241 withGreen:241 withBlue:241 withAlpha:0.8];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row]];
    return cell;
}
#pragma mark -- data
- (void)setData {
    self.dataArr = @[@"公告:2017营销政策讲解",
                     @"公告:2016营销政策讲解",
                     @"公告:2015营销政策讲解",
                     @"公告:2014营销政策讲解",
                     @"公告:2013营销政策讲解",
                     @"公告:2012营销政策讲解",
                     @"公告:2011营销政策讲解"];
}

#pragma mark -- didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
