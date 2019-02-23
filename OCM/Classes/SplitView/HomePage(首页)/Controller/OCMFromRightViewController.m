//
//  OCMFromRightViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/2/9.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMFromRightViewController.h"
#import "OCMRightDetailMidView.h"
#import "OCMRightDetailTableViewCell.h"
#import "rightMidDetailItem.h"

@interface OCMFromRightViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) OCMRightDetailMidView *midV;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) rightMidDetailItem *item;
@end

@implementation OCMFromRightViewController

#define kwidth 240
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, kwidth, screenHeight);
    self.view.backgroundColor = [UIColor blueColor];
    [self config];
    [self getData];
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.label.text = @"加载中";
    dispatch_time_t delayT = GCD_delayT(5);
//    dispatch_time_t dellayT1 = GCD_delayT(2);
    dispatch_after(delayT, dispatch_get_main_queue(), ^{
        self.hud.label.text = @"请求超时";
        self.hud.hidden = YES;
    });
}
- (void)getData {
    OCMApiRequest *request = [OCMApiRequest sharedOCMApiRequest];
    NSString *url = @"/channel/detail";
    NSString *path = [BaseURL stringByAppendingString:url];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = self.QDid;
    [request POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        OCMLog(@"success--%@", responseObject);
        rightMidDetailItem *item = [rightMidDetailItem mj_objectWithKeyValues:responseObject[@"data"]];
        self.midV.item = item;
        self.titleLabel.text = item.chName;
        self.stars = 3;
//        OCMLog(@"ite--%@", item.rankCode);  //星级
        dispatch_async(dispatch_get_main_queue(), ^{
            self.hud.hidden = YES;
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        OCMLog(@"failure--%@", error);
        self.hud.label.text = @"加载失败";
        dispatch_time_t delayT = GCD_delayT(1);
        dispatch_after(delayT, dispatch_get_main_queue(), ^{
            self.hud.hidden = YES;
        });
    }];
}
- (void)config {
    //第一部分view
    self.titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 34, 190, 20)];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:self.titleLabel];
    
    self.dismissBtn = [[UIButton alloc] initWithFrame:CGRectMake(185, 35, 15, 15)];
    [self.dismissBtn setImage:ImageIs(@"icon_home_list_delete") forState:UIControlStateNormal];
    [self.view addSubview:self.dismissBtn];
    
    self.starImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 62, 92, 16)];
    self.starImg.image = ImageIs(@"icon_home_list_star4");
    [self.view addSubview:self.starImg];
    
    self.moreDetailBtn = [[UIButton alloc] initWithFrame:CGRectMake(155, 60, 55, 23)];
    ViewBorder(self.moreDetailBtn, 1, [UIColor colorWithHexString:@"53b8eb"], 5);
    [self.moreDetailBtn setTitle:@"更多详情" forState:UIControlStateNormal];
    [self.moreDetailBtn setTitleColor:[UIColor RGBColorWithRed:0 withGreen:157 withBlue:236 withAlpha:0.85] forState:UIControlStateNormal];
    [self.moreDetailBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [self.view addSubview:self.moreDetailBtn];
    
    //第二部分
    //...
    
    //第三部分
    OCMRightDetailMidView *midV = [[OCMRightDetailMidView alloc] initWithFrame:CGRectMake(0, 200, kwidth, 330)];
    _midV = midV;
    [self.view addSubview:midV];
    
    //第四部分
    self.tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 530, kwidth, screenHeight - 530) style:UITableViewStylePlain];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    [self.view addSubview:self.tabelView];
}
- (void)addImgScrollV:(NSInteger)imgCounts {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    __weak typeof(self) weakSelf = self;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.starImg.mas_left);
        make.top.mas_equalTo(weakSelf.starImg.mas_bottom).offset(12);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(80);
    }];
    CGFloat width;
    if ((int)imgCounts <= 1) {
        width = 120;
    } else {
        width = 150 * (int)(imgCounts - 1) + 120;
    }
    self.scrollView.contentSize = CGSizeMake(width, 80);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i < imgCounts; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(130 * i, 0, 120, 80)];
        imageV.image = [UIImage createImageWithColor:[UIColor randomColor]];
        [self.scrollView addSubview:imageV];
        imageV.tag = i;
        ViewBorder(imageV, 0, [UIColor clearColor], 5);
    }
}
#pragma mark -- UITableViewDateSoruce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"OCMRightDetailTableViewCell";
    OCMRightDetailTableViewCell *cell = [self.tabelView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[OCMRightDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
#pragma mark -- data
- (void)setImgCounts:(NSInteger)imgCounts {
    [self addImgScrollV:imgCounts];
}
- (NSString *)titleStr {
    return self.titleLabel.text;
}
- (void)setTitleStr:(NSString *)titleStr {
    self.titleLabel.text = titleStr;
}
- (void)setStars:(NSInteger)stars {
    switch (stars) {
        case 0:
            self.starImg.image = ImageIs(@"icon_home_list_star1");
            break;
        case 1:
            self.starImg.image = ImageIs(@"icon_home_list_star2");
            break;
        case 2:
            self.starImg.image = ImageIs(@"icon_home_list_star3");
            break;
        case 3:
            self.starImg.image = ImageIs(@"icon_home_list_star4");
            break;
        case 4:
            self.starImg.image = ImageIs(@"icon_home_list_star5");
            break;
        case 5:
            self.starImg.image = ImageIs(@"icon_home_list_star6");
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
