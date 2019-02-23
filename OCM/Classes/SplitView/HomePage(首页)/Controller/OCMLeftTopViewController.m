//
//  OCMLeftTopViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/15.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMLeftTopViewController.h"
#import "OCMProgressView.h"
#import "OCMButton.h"
#import "OCMTopFirstViewController.h"
#import "OCMTopSecondViewController.h"
#import "OCMTopThirdViewController.h"
#import "OCMTopFourthViewController.h"
#import "OCMSearchBar.h"
#import "OCMNetInfoStruct.h"

#define kMiddleViewHeight 285
@interface OCMLeftTopViewController ()<UISearchBarDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *oneTableView;
@property (nonatomic, strong) UITableView *twoTableView;
@property (nonatomic, strong) UITableView *threeTableView;
@property (nonatomic, strong) UITableView *fourTableView;
//头部view
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *kilometresLabel;//走访公里数
@property (nonatomic, strong) UILabel *kiloL;
@property (nonatomic, strong) UILabel *timesLabel;//走访次数
@property (nonatomic, strong) UILabel *timesL;
@property (nonatomic, strong) UILabel *netTimesLabel;//网点走访次数
@property (nonatomic, strong) UILabel *netTimesL;
@property (nonatomic, strong) OCMProgressView *ocmProgressV;
//searchBar
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) OCMSearchBar *ocmSearchBar;
//底部view
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) OCMButton *oneButton;
@property (nonatomic, strong) UIView *dragV;

@property (nonatomic, strong) UILabel *detailL;

@property (nonatomic, assign) BOOL isHidden;

//dataArr
@property (nonatomic, strong) NSArray *imgNormalArr;
@property (nonatomic, strong) NSArray *imgSelectedArr;
@end

@implementation OCMLeftTopViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor RGBColorWithRed:241 withGreen:241 withBlue:241 withAlpha:0.8];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpUI];
    self.isHidden = YES;
}

- (void)setUpUI {
    [self setTopViewUI];
    [self setUpMidUI];
    [self setUpBottomUI];
}
- (void)setTopViewUI {
    __weak typeof(self) weakSelf = self;
    {
        _topView = [[UIView alloc] init];
        [self.view addSubview:_topView];
        _topView.alpha = 0.45;
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#1976d2"].CGColor, (__bridge id)[UIColor colorWithHexString:@"#00b358"].CGColor];
        gradientLayer.locations = @[@0.5];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1.0);
        gradientLayer.frame = CGRectMake(0, 0, 290, 90);
        [_topView.layer addSublayer:gradientLayer];
        
        
        _headView = [[UIImageView alloc] init]; // 头像
        [self.topView addSubview:_headView];
        _headView.image = [UIImage createImageWithColor:[UIColor randomColor]];
        _headView = [UIImageView createWithImageView:_headView width:60 height:60 BorderWidth:2.0 borderColor:[UIColor whiteColor]];
        
        _kilometresLabel = [[UILabel alloc] init];
        [self.topView addSubview:_kilometresLabel];
        _kilometresLabel.font = [UIFont systemFontOfSize:10];
        _kilometresLabel.text = @"走访公里数 :";
        _kilometresLabel.textColor = [UIColor whiteColor];
        
        _kiloL = [[UILabel alloc] init];
        [self.topView addSubview:_kiloL];
        _kiloL.font = [UIFont boldSystemFontOfSize:10];
        _kiloL.textColor = [UIColor colorWithHexString:@"ffffff"];
        _kiloL.text = @"30公里"; // 数据临时写的
        
        _timesLabel = [[UILabel alloc] init];
        [self.topView addSubview:_timesLabel];
        _timesLabel.font = [UIFont systemFontOfSize:10];
        _timesLabel.text = @"走访次数 :";
        _timesLabel.textColor = [UIColor whiteColor];
        
        _timesL = [[UILabel alloc] init];
        [self.topView addSubview:_timesL];
        _timesL.font = [UIFont boldSystemFontOfSize:10];
        _timesL.textColor = [UIColor colorWithHexString:@"ffffff"];
        _timesL.text = @"10/100/200";
        
        _netTimesLabel = [[UILabel alloc] init];
        [self.topView addSubview:_netTimesLabel];
        _netTimesLabel.font = [UIFont systemFontOfSize:10];
        _netTimesLabel.text = @"走访网点次数 :";
        _netTimesLabel.textColor = [UIColor whiteColor];
        
        _netTimesL = [[UILabel alloc] init];
        [self.topView addSubview:_netTimesL];
        _netTimesL.font = [UIFont boldSystemFontOfSize:10];
        _netTimesL.textColor = [UIColor colorWithHexString:@"ffffff"];
        _netTimesL.text = @"50/70";
        
        _ocmProgressV = [[OCMProgressView alloc] initWithFrame:CGRectMake(87, 80, 190, 6)];
        [self.topView addSubview:_ocmProgressV];
        CGFloat progress = 0.7;
        if (progress < 1) {
            _ocmProgressV.progress = 0.7;
        } else {
            OCMLog(@"进度条的值不能大于1");
        }
    }
    {
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(weakSelf.view);
            make.width.mas_equalTo(580 * 0.5);
            make.height.mas_equalTo(180 * 0.5);
        }];
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(13);
            make.top.mas_equalTo(21);
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(60);
        }];
        [_kilometresLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.headView).offset(2);
            make.left.mas_equalTo(weakSelf.headView.mas_right).offset(14);
        }];
        [_kiloL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.kilometresLabel.mas_centerY);
            make.left.mas_equalTo(weakSelf.kilometresLabel.mas_right).offset(5);
        }];
        [_timesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.kilometresLabel.mas_bottom).offset(8);
            make.left.mas_equalTo(weakSelf.kilometresLabel);
        }];
        [_timesL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.timesLabel);
            make.left.mas_equalTo(weakSelf.timesLabel.mas_right).offset(5);
        }];
        [_netTimesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.timesLabel.mas_bottom).offset(8);
            make.left.mas_equalTo(weakSelf.timesLabel);
        }];
        [_netTimesL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.netTimesLabel);
            make.left.mas_equalTo(weakSelf.netTimesLabel.mas_right).offset(5);
        }];
        
    }
    
    
}
- (void)setUpMidUI {
    _ocmSearchBar = [[OCMSearchBar alloc] initWithFrame:CGRectMake(0, 90, kLeftTopWidth, 38)];
    _ocmSearchBar.contentInset = UIEdgeInsetsMake(6.5, 5, 6.5, 5);
    _ocmSearchBar.delegate = self;
    _ocmSearchBar.placeholder = @"搜索";
    _ocmSearchBar.barStyle = UISearchBarStyleDefault;
    ViewBorder(_ocmSearchBar, 0, [UIColor clearColor], 3);
    _ocmSearchBar.alpha = 0.7;
    _ocmSearchBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_ocmSearchBar];
}
- (void)setUpBottomUI {
    [self addBtnAndViewController];
    [self addScrollView];
    [self addHiddenBtn];
}
- (void)addBtnAndViewController {
    UIView *titleView = [[UIView alloc] init];
    _titleView = titleView;
    [self.view addSubview:titleView];
    __weak typeof(self) weakSelf = self;
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(128);
        make.height.mas_equalTo(43);
        make.left.right.mas_equalTo(weakSelf.view);
    }];
    titleView.backgroundColor = [UIColor RGBColorWithRed:255 withGreen:255 withBlue:255 withAlpha:0.7];
//    titleView.backgroundColor = [UIColor redColor];
    NSArray *titleArr = @[@"任务",@"网点",@"同事",@"标记点"];
    NSArray *imgNormalArr = @[@"img_home_task",@"icon_task_net",@"img_home_workmate",@"img_home_sign"];
    _imgNormalArr = imgNormalArr;
    NSArray *imgSelectedArr = @[@"img_home_task_highlight",@"img_home_net_highlight",@"img_home_workmate_highlight",@"img_home_sign_highlight"];
    _imgSelectedArr = imgSelectedArr;
    for (int i = 0; i < 4; i++) {
        OCMButton *btn = [[OCMButton alloc] initWithFrame:CGRectMake(25 + (i)*65, 3, 34, 34)];
        btn.tag = i + 101;
        btn.selected = NO;
        btn.nameLabel.text = titleArr[i];
        btn.detailLabel.layer.cornerRadius = 5;
        btn.iconImgV.image = [UIImage imageNamed:imgNormalArr[i]];
        btn.nameLabel.textColor = [UIColor colorWithHexString:@"#bababa"];
        [btn setBackgroundColor:[UIColor RGBColorWithRed:255 withGreen:255 withBlue:255 withAlpha:0.7]];
        if (btn.tag == 101) {
            btn.detailLabel.text = @"2";
            btn.iconImgV.image = [UIImage imageNamed:imgSelectedArr[0]];
            btn.nameLabel.textColor = [UIColor colorWithHexString:@"f64b30"];
        } else {
            btn.detailLabel.hidden = YES;
        }
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];
    }
}
- (void)addScrollView {
    __weak typeof(self) weakSelf = self;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 171,kLeftTopWidth, kMiddleViewHeight)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(kLeftTopWidth * 4, kMiddleViewHeight);
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    NSArray *vcNameArr = @[@"OCMTopFirstViewController",@"OCMTopSecondViewController",@"OCMTopThirdViewController",@"OCMTopFourthViewController"];
    for (int i = 0; i < vcNameArr.count; i++) {
        NSString *str = vcNameArr[i];
        Class class = NSClassFromString([NSString stringWithFormat:@"%@",str]);
        UIViewController *vc = [[class alloc] init];
        vc.view.frame = CGRectMake(kLeftTopWidth * i, 0, kLeftTopWidth, kMiddleViewHeight);
//        vc.view.alpha = 0.5;
        vc.view.alpha = 0.8;
        [_scrollView addSubview:vc.view];
        [self addChildViewController:vc];
        if (i == 1) { // 第二个vc
            OCMTopSecondViewController *secondVC = (OCMTopSecondViewController *)vc;
            secondVC.netLocation = ^(CGFloat chLati, CGFloat chLongitu) {
                __strong typeof(weakSelf) theSelf = weakSelf;
                theSelf.selLocation(chLati, chLongitu);
            };
            secondVC.ocmNetInfo = ^(OCMNetInfoStruct *ocmNetInfoStruct) {
                __strong typeof(weakSelf) theSelf = weakSelf;
                theSelf.ocmNetInfo(ocmNetInfoStruct);
            };
            self.secondVC = secondVC;
        }
    }
}
- (void)addHiddenBtn {
    UIView *sepV = [UIView new];
    sepV.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:sepV];
    
    UIView *dragV = [UIView new];
    _dragV = dragV;
    dragV.backgroundColor = [UIColor RGBColorWithRed:241 withGreen:241 withBlue:241 withAlpha:0.8];
    [self.view addSubview:dragV];
    UISwipeGestureRecognizer *swipGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction:)];
    swipGes.direction = UISwipeGestureRecognizerDirectionUp;
    
    UISwipeGestureRecognizer *swipGes1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction:)];
    swipGes1.direction = UISwipeGestureRecognizerDirectionDown;
    
    [dragV addGestureRecognizer:swipGes];
    [dragV addGestureRecognizer:swipGes1];
    
    UIButton *hiddenBtn = [UIButton new];
    hiddenBtn.tag = 200;
    _hiddenBtn = hiddenBtn;
    hiddenBtn.backgroundColor = [UIColor colorWithHexString:@"#bcc4cc"];
    ViewBorder(hiddenBtn, 0, [UIColor clearColor], 3);
    [dragV addSubview:hiddenBtn];
    
    [hiddenBtn addTarget:self action:@selector(clickToHiddenOrShow) forControlEvents:UIControlEventTouchUpInside];
    
    __weak typeof(self) weakSelf = self;
    [sepV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(weakSelf.scrollView.mas_bottom);
    }];
    
    [hiddenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(dragV);
        make.height.mas_equalTo(5);
        make.width.mas_equalTo(34);
    }];
    [dragV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25);
        make.left.right.bottom.mas_equalTo(weakSelf.view);
    }];
}
#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pointX = _scrollView.contentOffset.x;
    NSNumber *cur = [NSNumber numberWithInt:(pointX / kLeftTopWidth)];
    [_titleView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == [cur integerValue]) {
            OCMButton *btn = obj;
            [btn setSelected:YES];
            btn.iconImgV.image = [UIImage imageNamed:_imgSelectedArr[(int)idx]];
            btn.nameLabel.textColor = [UIColor colorWithHexString:@"#f64b30"];
        } else {
            OCMButton *btn = obj;
            [btn setSelected:NO];
            btn.iconImgV.image = [UIImage imageNamed:_imgNormalArr[(int)idx]];
            btn.nameLabel.textColor = [UIColor colorWithHexString:@"#bababa"];
        }
    }];
}
#pragma mark -- 点击事件
- (void)clickBtn:(OCMButton *)sender {
    for (int i = 0; i < 4; i++) {
        OCMButton *btn = (OCMButton *)[[sender superview] viewWithTag:101 + i];
        [btn setSelected:NO];
        btn.iconImgV.image = [UIImage imageNamed:_imgNormalArr[i]];
        btn.nameLabel.textColor = [UIColor colorWithHexString:@"#bababa"];
    }
    OCMButton *btn = (OCMButton *)sender;
    [btn setSelected:YES];
    
    
    switch (sender.tag) {
        case 101:
            OCMLog(@"点击事件");
            CGPoint point = CGPointMake(0, 0);
            [_scrollView setContentOffset:point];
            btn.iconImgV.image = [UIImage imageNamed:_imgSelectedArr[0]];
            btn.nameLabel.textColor = [UIColor colorWithHexString:@"#f64b30"];
            break;
        case 102:
            OCMLog(@"网点");
            CGPoint point1 = CGPointMake(kLeftTopWidth, 0);
            [_scrollView setContentOffset:point1];
            btn.iconImgV.image = [UIImage imageNamed:_imgSelectedArr[1]];
            btn.nameLabel.textColor = [UIColor colorWithHexString:@"#f64b30"];
            break;
        case 103:
            OCMLog(@"同事");
            CGPoint point2 = CGPointMake(kLeftTopWidth * 2, 0);
            [_scrollView setContentOffset:point2];
            btn.iconImgV.image = [UIImage imageNamed:_imgSelectedArr[2]];
            btn.nameLabel.textColor = [UIColor colorWithHexString:@"#f64b30"];
            break;
        case 104:
            OCMLog(@"标记点");
            CGPoint point3 = CGPointMake(kLeftTopWidth * 3, 0);
            [_scrollView setContentOffset:point3];
            btn.iconImgV.image = [UIImage imageNamed:_imgSelectedArr[3]];
            btn.nameLabel.textColor = [UIColor colorWithHexString:@"#f64b30"];
            break;
        default:
            break;
    }
}
- (void)swipAction:(UISwipeGestureRecognizer *)swip {
    OCMLog(@"swip");
    if (swip.direction == UISwipeGestureRecognizerDirectionUp) {
        OCMLog(@"up--收起");
        __weak typeof(self) weakSelf = self;
        self.isHidden = YES;
        self.clickHiddenBtn(self.isHidden);
        
//        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if (_dragV == obj) {
//                OCMLog(@"_dragV");
//            } else if (_searchBar == obj) {
//                [obj mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.top.left.right.mas_equalTo(weakSelf.view);
//                }];
//            } else {
//                obj.hidden = NO;
//            }
//        }];
        int count = (int)self.view.subviews.count;
        int i = 1;
        for (UIView *view in self.view.subviews) {
            if (i == count ) {
                view.hidden = NO;
            } else if (i == count - 1) {
                view.hidden = NO;
//                [view mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.left.right.bottom.mas_equalTo(weakSelf.view);
//                    make.height
//                }];
            } else if (i == 2) { //搜索框
//                view.hidden = NO;
//                [view mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.top.left.right.mas_equalTo(weakSelf.view);
//                }];
                view.hidden = YES;
            } else if ([view isEqual:self.topView]) {
                view.hidden = NO;
            }
            else {
                view.hidden = YES;
            }
            i ++;
        }
    }
    if (swip.direction == UISwipeGestureRecognizerDirectionDown) {
        OCMLog(@"down--展开");
//        __weak typeof(self) weakSelf = self;
        self.isHidden = NO;
        self.clickHiddenBtn(self.isHidden);
//        self.view.subviews.
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.hidden = NO;
            if (_searchBar == obj) {
                OCMLog(@"searchbar");
//                [obj mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.right.left.mas_equalTo(weakSelf.view);
//                    make.top.mas_equalTo(weakSelf.topView.mas_bottom);
//                }];
            }
        }];
//        for (UIView *view in self.view.subviews) {
//            view.hidden = NO;
//            if (view == _searchBar) {
//                [view mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.right.left.mas_equalTo(weakSelf.view);
//                    make.top.mas_equalTo(weakSelf.topView.mas_bottom);
//                }];
//            }
//        }
    }
}
- (void)clickToHiddenOrShow {
    OCMLog(@"clickToHiddenOrShow--%@",[self.view.subviews debugDescription]);
    self.clickHiddenBtn(self.isHidden);
    if (self.isHidden == YES) {
        int count = (int)self.view.subviews.count;
        int i = 1;
        for (UIView *view in self.view.subviews) {
            if (i == count ) {
                view.hidden = NO;
            } else if (i == count - 1) {
                view.hidden = NO;
                //                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                //                    make.left.right.bottom.mas_equalTo(weakSelf.view);
                //                    make.height
                //                }];
            } else if (i == 2) { //搜索框
                //                view.hidden = NO;
                //                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                //                    make.top.left.right.mas_equalTo(weakSelf.view);
                //                }];
                view.hidden = YES;
            } else if ([view isEqual:self.topView]) {
                view.hidden = NO;
            }
            else {
                view.hidden = YES;
            }
            i ++;
        }
    } else {
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.hidden = NO;
        }];
    }
    self.isHidden = !self.isHidden;
}
- (void)setCurrentLocation:(CLLocationCoordinate2D)currentLocation {
//    self.currentLocation = currentLocation;
    self.secondVC.currentLocation = currentLocation;
}
#pragma mark -- SearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    [_searchBar setShowsCancelButton:YES animated:YES];
}
#pragma mark -- dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
