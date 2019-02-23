//
//  OCMHomePageViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/1.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMHomePageViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "OCMLeftTopViewController.h"
#import "OCMRightTopViewController.h"
#import "OCMLeftBottomViewController.h"
#import "OCMRightBottomViewController.h"
#import "OCMMapV.h"
#import "ReGeocodeAnnotation.h"
#import "MANaviAnnotationView.h"
#import "OCMHomeCustomAnnotationView.h"
#import "OCMNetInfoStruct.h"
#import "MANaviRoute.h"
#import "OCMFromRightViewController.h"
#import "OCMDetailNetViewController.h"
#import "OCMDetailModalViewController.h"
#import "OCMModalSplitViewController.h"
#import <AMapNavi/AMapNaviKit/AMapNaviKit.h>
#import "OCMAllNetItem.h"
#import "OCMAllNetDetailItem.h"
#import "CoordinateQuadTree.h"
#import "ClusterAnnotation.h"
#import "ClusterAnnotationView.h"
#import "OCMNetAnnotation.h"
#import "OCMSeaAnnotation.h"

@interface OCMHomePageViewController ()<AMapSearchDelegate,AMapLocationManagerDelegate,AMapGeoFenceManagerDelegate,AMapNearbySearchManagerDelegate,MAMapViewDelegate,CLLocationManagerDelegate,AMapNaviCompositeManagerDelegate,MAMultiPointOverlayRendererDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;                                        // 搜索类
@property (nonatomic, strong) AMapReGeocodeSearchRequest *regeo;                            //逆地理编码请求
@property (nonatomic, strong) UIView *leftTopView;                                          //左上角的view
@property (nonatomic, strong) OCMLeftTopViewController *leftTopVC;
@property (nonatomic, strong) UIView *rightTopView;                                         //右上角的view
@property (nonatomic, strong) UIView *leftBottomView;                                       //左下角的view
@property (nonatomic, strong) UIView *rightBottomView;                                      //右下角的view

@property (nonatomic, assign) BOOL isBigLeftWidth;

@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;
@property (nonatomic, assign) BOOL isSearchFromDragging;                                    //是否拖拽搜索
@property (nonatomic, strong) NSMutableArray *annotations;                                  //大头针坐标数组
@property (nonatomic, strong) ReGeocodeAnnotation *annotation;

@property (nonatomic, strong) CLLocationManager *locationMgr;
@property (nonatomic, strong) AMapLocationManager *aMapLocationMgr;
@property (nonatomic, assign) CLLocationCoordinate2D currentLocation;                       // 当前位置
@property (nonatomic, strong) OCMNetInfoStruct *ocmNetInfo;                                 //包含网点详细信息
@property (nonatomic, strong) OCMHomeCustomAnnotationView *annotationView;                  //自定义的详细信息的大头针
@property (nonatomic, assign) CLLocationCoordinate2D destination;                           // 目的地
/*路径规划相关*/
@property (nonatomic, strong) AMapRoute *route;                                             //路径规划
@property (nonatomic, assign) NSInteger totalCourse;                                        //路线方案个数
@property (nonatomic, assign) NSInteger currentCourse;                                      //当前路线方案索引值
@property (nonatomic, strong) MANaviRoute *naviRoute;                                       //用于显示当前路线方案
@property (nonatomic ,strong) AMapNaviCompositeManager *compositeManager;                   //实时导航
/*右侧抽屉*/
@property (nonatomic, strong) OCMFromRightViewController *rightVC;                          //右侧vc
@property (nonatomic, strong) UIView *drawerView;                                           //右侧view
@property (nonatomic, copy) NSString *titleStr;                                             //标题
@property (nonatomic, copy) NSString *contacts;                                             //联系人
@property (nonatomic, copy) NSString *QDid;                                                 //请求更多信息的参数
@property (nonatomic, assign) BOOL isClickMoreInfo;
@property (nonatomic, assign) NSInteger modalIndex;                                         //进入modal界面直接跳转哪个界面
/*海量网点信息*/
@property (nonatomic, strong) MAMultiPointOverlay *overlay;                                 //多家网点信息
@property (nonatomic, strong) NSMutableArray *allNetInfoArr;                                //全部9000多家网点信息数组
/*聚合海量网点信息*/
@property (nonatomic, strong) CoordinateQuadTree* coordinateQuadTree;
//@property (nonatomic, strong) CustomCalloutView *customCalloutView;
@property (nonatomic, strong) NSMutableArray *selectedPoiArray;
@property (nonatomic, assign) BOOL shouldRegionChangeReCalculate;
@property (nonatomic, assign) BOOL isShowSeaAnno;                                           //是否显示海量网点
@end

@implementation OCMHomePageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hiddenNavigationBar];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initAnno];
        _allNetInfoArr = [NSMutableArray array];
        [self loadSixThounsandNet]; //请求6000家网点信息
        self.coordinateQuadTree = [[CoordinateQuadTree alloc] init];   //聚合四叉树
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isBigLeftWidth = YES;
    _isClickMoreInfo = NO;
    _isShowSeaAnno = YES; //一开始设置不显示海量网点
    [self addNotify];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setMap];
    [self addFourView];
}
- (void)addFromRightV {
    CGRect rect = CGRectMake(screenWidth, 0, 240, screenHeight);
    UIView *rightV = [[UIView alloc] initWithFrame:rect];
    rightV.tag = 200;
    _drawerView = rightV;
    _drawerView.backgroundColor = [UIColor greenColor];
}
- (void)addFourView {
    [self addLeftTopView];
    [self addRightTopView];
    [self addLeftBottomView];
    [self addRightBottomView];
    [self addFromRightV];
}
- (void)setMap {
    _mapView = [OCMMapV shareInstance];
    OCMLog(@"首页_mapView--Address==%p", _mapView);
    _mapView.frame = self.view.bounds;
    [self.view addSubview:_mapView];
    _mapView.delegate = self;
    _mapView.userInteractionEnabled = YES;
    [AMapServices sharedServices].enableHTTPS = YES;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    [_mapView setZoomLevel:13.5 animated:YES]; // 3 ~ 19
    [self setHidden];
}
- (void)setHidden {
    [_mapView removeOverlays:_mapView.overlays];//移除大头针
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView removeAnnotations:self.annotations];
    [self searchPoint];
}
- (void)initAnno {
    return; //暂时不添加网点
    dispatch_time_t delayT = GCD_delayT(1);
    dispatch_after(delayT, dispatch_get_main_queue(), ^{
        [self addAnotation];
    });
}
#pragma mark -- 展示海量信息
- (void)addAnotation {
    self.annotations = [NSMutableArray array];
    OCMLog(@"总数据条数--%ld", self.allNetInfoArr.count);
    
    //----------------------------------添加overlay的方式添加----------------------------------//
//    for (OCMAllNetDetailItem *detaiItem in self.allNetInfoArr) {
//        @autoreleasepool {
//            MAMultiPointItem *item = [[MAMultiPointItem alloc] init];
//            item.coordinate = CLLocationCoordinate2DMake(detaiItem.chLatitude, detaiItem.chLogngitude);
//            [self.annotations addObject:item];
//        }
//    }
//    _overlay = [[MAMultiPointOverlay alloc] initWithMultiPointItems:self.annotations];
//    [_mapView addOverlay:_overlay];
    
    
    //-----------------------------------添加MAPointAnnotation的方式添加----------------------------------//
    for (OCMAllNetDetailItem *detailItem in self.allNetInfoArr) {
        @autoreleasepool {
            OCMSeaAnnotation *pointAnn = [[OCMSeaAnnotation alloc] init];
            pointAnn.coordinate = CLLocationCoordinate2DMake(detailItem.chLatitude, detailItem.chLogngitude);
            [self.annotations addObject:pointAnn];
        }
    }
    [_mapView addAnnotations:self.annotations];
    
    
    //-----------------------------------------------我是分割线---------------------------------------------------//
    if (self.allNetInfoArr.count > 0) {
        @synchronized(self)
        {
            self.shouldRegionChangeReCalculate = NO;
            
            // 清理
            [self.selectedPoiArray removeAllObjects];
            //        [self.customCalloutView dismissCalloutView];
            
            NSMutableArray *annosToRemove = [NSMutableArray arrayWithArray:self.mapView.annotations];
            [annosToRemove removeObject:self.mapView.userLocation];
            [self.mapView removeAnnotations:annosToRemove];
            
            __weak typeof(self) weakSelf = self;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                /* 建立四叉树. */
                [weakSelf.coordinateQuadTree buildTreeWithPOIs:self.allNetInfoArr];
                weakSelf.shouldRegionChangeReCalculate = YES;
                
                [weakSelf addAnnotationsToMapView:weakSelf.mapView];
            });
        }
    }

}
- (void)searchPoint {
    OCMLog(@"定位自己的经纬度");
    self.aMapLocationMgr = [[AMapLocationManager alloc] init];
    self.aMapLocationMgr.delegate = self;
    self.aMapLocationMgr.distanceFilter = 5; //单位:m
    // 最适合导航 kCLLocationAccuracyBestForNavigation
    // 百米 kCLLocationAccuracyHundredMeters
    [self.aMapLocationMgr startUpdatingLocation];
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self; // 暂时不添加长按点击大头针
}
- (void)addNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLeftWidth) name:NswipeLeftGes object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRightWidth) name:NswipeRightGes object:nil];
}
- (void)setLeftWidth {
    _isBigLeftWidth = NO; // 左侧收缩了
    [self addRightBottomView];
    [self showNetInfoView];
}
- (void)setRightWidth {
    _isBigLeftWidth = YES; // 左侧伸展了
    [self addRightBottomView];
    [self showNetInfoView];
}
- (void)hiddenNavigationBar {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark -- 添加4个角落的view
- (void)addLeftTopView {
    __weak typeof(self) weakSelf = self;
    _leftTopView = [[UIView alloc] init];
    [self.view addSubview:_leftTopView];
    _leftTopView.backgroundColor = [UIColor clearColor];
//    ViewBorder(_leftTopView, 0.5, [UIColor clearColor], 10);
    _leftTopView.layer.cornerRadius = 10;
    _leftTopView.layer.shadowColor = [UIColor grayColor].CGColor;
    _leftTopView.layer.shadowOffset = CGSizeMake(0, 0);
    _leftTopView.layer.shadowOpacity = 0.5;
    _leftTopView.layer.shadowRadius = 10;

//    _leftBottomView.layer.masksToBounds = YES;
    
    if (self.childViewControllers) {
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[OCMLeftTopViewController class]]) {
                [obj removeFromParentViewController];
            }
        }];
    }
    OCMLeftTopViewController *leftTopVC = [[OCMLeftTopViewController alloc] init];
    _leftTopVC = leftTopVC;
    leftTopVC.view.frame = _leftTopView.bounds;
    [_leftTopView addSubview:leftTopVC.view];
    [self addChildViewController:leftTopVC];
    ViewBorder(leftTopVC.view, 0.5, [UIColor clearColor], 10);
    leftTopVC.view.layer.masksToBounds = YES;
    
    _leftTopView.frame = CGRectMake(24, 24, kLeftTopWidth, kLeftTopHeight1);
    leftTopVC.clickHiddenBtn = ^(BOOL isHidden) {
        if (isHidden) {
            [UIView animateWithDuration:0.5 animations:^{
                _leftTopView.frame = CGRectMake(24, 24, kLeftTopWidth, kLeftTopHeight2);
            }];
        } else {
            [UIView animateWithDuration:0.5 animations:^{
                _leftTopView.frame = CGRectMake(24, 24, kLeftTopWidth, kLeftTopHeight1);
            }];
        }
    };
    leftTopVC.selLocation = ^(CGFloat chLati, CGFloat chLongitu) { //点击了某个网点,获取该网点的经纬度
        [weakSelf.mapView removeAnnotations:weakSelf.mapView.annotations];
        [weakSelf addNetPoint:chLati longitude:chLongitu];
    };
    leftTopVC.ocmNetInfo = ^(OCMNetInfoStruct *ocmNetInfoStruct) {
        __strong typeof(weakSelf) theSelf = weakSelf;
        NSString *str = [[NSString alloc] initWithCString:ocmNetInfoStruct.netDetailInfo.chName encoding:NSUTF8StringEncoding];
        self.titleStr = str;
        NSString *contacts = [[NSString alloc] initWithCString:ocmNetInfoStruct.netDetailInfo.contacts encoding:NSUTF8StringEncoding];
        self.contacts = contacts;
        theSelf.ocmNetInfo = ocmNetInfoStruct;
        [theSelf clear];
        [theSelf addNetInfo:ocmNetInfoStruct];
    };
}
- (void)addRightTopView {
    _rightTopView = [[UIView alloc] init];
    [self.view addSubview:_rightTopView];
    ViewBorder(_rightTopView, 0, [UIColor clearColor], 10);
    _rightTopView.backgroundColor = [UIColor whiteColor];
    
    OCMRightTopViewController *rightTopVC = [[OCMRightTopViewController alloc] init];
    if (self.childViewControllers) {
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[OCMRightTopViewController class]]) {
                [obj removeFromParentViewController];
            }
        }];
    }
    [self addChildViewController:rightTopVC];
    
    rightTopVC.view.frame = _rightTopView.bounds;
    [_rightTopView addSubview:rightTopVC.view];
    
    [_rightTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(120);
    }];
    //添加点击,定位到当前所在位置
    [rightTopVC.locationBtn addTarget:self action:@selector(gpsAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)addLeftBottomView {
    _leftBottomView = [[UIView alloc] init];
    [self.view addSubview:_leftBottomView];
    ViewBorder(_leftBottomView, 0, [UIColor clearColor], 10);
    _leftBottomView.layer.masksToBounds = YES;
    if (self.childViewControllers) {
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[OCMLeftBottomViewController class]]) {
                [obj removeFromParentViewController];
            }
        }];
    }
    OCMLeftBottomViewController *leftBottomVC = [[OCMLeftBottomViewController alloc] init];
    leftBottomVC.tableView.hidden = YES;
    [self addChildViewController:leftBottomVC];
    leftBottomVC.view.frame = _leftBottomView.bounds;
    [_leftBottomView addSubview:leftBottomVC.view];
    
    __weak typeof(leftBottomVC) weakLeftBottomVC = leftBottomVC;
    _leftBottomView.frame = CGRectMake(24, screenHeight - 50, kLeftTopWidth, 25);
    leftBottomVC.swipeUpOrDown = ^(BOOL isUp) {
        if (isUp) {
            [UIView animateWithDuration:0.5 animations:^{
                _leftBottomView.frame = CGRectMake(24, screenHeight - 200 - 24, kLeftTopWidth, 200);
                weakLeftBottomVC.view.frame = _leftTopView.bounds;
                weakLeftBottomVC.tableView.hidden = NO;
                weakLeftBottomVC.imgV.image =[UIImage imageNamed:@"downRow"];
            }];
        } else {
            [UIView animateWithDuration:0.5 animations:^{
                _leftBottomView.frame = CGRectMake(24, screenHeight - 50, kLeftTopWidth, 25);
                weakLeftBottomVC.view.frame = _leftTopView.bounds;
                weakLeftBottomVC.tableView.hidden = YES;
                weakLeftBottomVC.imgV.image =[UIImage imageNamed:@"ggsla-1"];
            }];
        }
    };
}
- (void)addRightBottomView {
    if (_rightBottomView && _rightBottomView.subviews) {
        [_rightBottomView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [_rightBottomView removeFromSuperview];
    }
    _rightBottomView = [[UIView alloc] init];
//    ViewBorder(_rightBottomView, 0, [UIColor clearColor], 10);
    
    _rightBottomView.layer.cornerRadius = 10;
    _rightBottomView.layer.shadowColor = [UIColor grayColor].CGColor;
    _rightBottomView.layer.shadowOffset = CGSizeMake(0, 0);
    _rightBottomView.layer.shadowOpacity = 0.5;
    _rightBottomView.layer.shadowRadius = 10;
//    _rightBottomView.layer.masksToBounds = YES;  //加了没阴影
    
    [self.view addSubview:_rightBottomView];
    if (self.childViewControllers) {
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[OCMRightBottomViewController class]]) {
                [obj removeFromParentViewController];
            }
        }];
    }
    OCMRightBottomViewController *rightBottomVC = [[OCMRightBottomViewController alloc] init];
    [self addChildViewController:rightBottomVC];
    rightBottomVC.view.frame = _rightBottomView.bounds;
    [_rightBottomView addSubview:rightBottomVC.view];
    ViewBorder(rightBottomVC.view, 0.5, [UIColor clearColor], 10);
    rightBottomVC.view.layer.masksToBounds = YES;
    
    __block BOOL isAdded = NO;
    if (self.view.subviews) {
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.tag == 201) {
                isAdded = YES;
            }
        }];
    }
    if (isAdded) {
        [self.view insertSubview:_rightBottomView belowSubview:_rightVC.view];
    } else {
        [self.view addSubview:_rightBottomView];
    }
    if (_rightBottomView.subviews) {
        [_rightBottomView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj == rightBottomVC.view) {
                [obj removeFromSuperview];
            }
        }];
    }
    [_rightBottomView addSubview:rightBottomVC.view];
    if (_isBigLeftWidth) { // 左侧伸展开了
        _rightBottomView.frame = CGRectMake(screenWidth - kRightBottomWidth - 10 - kLeftBigWidth, screenHeight - kRightBottomHeight - 10, kRightBottomWidth, kRightBottomHeight);
    } else { //左侧收缩
        _rightBottomView.frame = CGRectMake(screenWidth - kRightBottomWidth - 10 - kLeftSmallWidth, screenHeight - kRightBottomHeight - 10, kRightBottomWidth, kRightBottomHeight);
    }
    rightBottomVC.hiddenOrShow = ^(BOOL isUp) {
        if (isUp) { // 显示
            [UIView animateWithDuration:0.5 animations:^{
                if (_isBigLeftWidth) { // 左侧伸展开了
                    _rightBottomView.frame = CGRectMake(screenWidth - kRightBottomWidth - 10 - kLeftBigWidth, screenHeight - kRightBottomHeight - 10, kRightBottomWidth, kRightBottomHeight);
                } else { //左侧收缩
                    _rightBottomView.frame = CGRectMake(screenWidth - kRightBottomWidth - 10 - kLeftSmallWidth, screenHeight - kRightBottomHeight - 10, kRightBottomWidth, kRightBottomHeight);
                }
            }];
        } else { // 隐藏
            [UIView animateWithDuration:0.5 animations:^{
                CGFloat changeHeight = 200.0;
                if (_isBigLeftWidth) { // 左侧伸展开了
                    _rightBottomView.frame = CGRectMake(screenWidth - kRightBottomWidth - 10 - kLeftBigWidth, screenHeight - kRightBottomHeight - 10 + changeHeight, kRightBottomWidth, kRightBottomHeight - changeHeight);
                } else { //左侧收缩
                    _rightBottomView.frame = CGRectMake(screenWidth - kRightBottomWidth - 10 - kLeftSmallWidth, screenHeight - kRightBottomHeight - 10 + changeHeight, kRightBottomWidth, kRightBottomHeight - changeHeight);
                }
            }];
        }
    };
}
#pragma mark -- 点击事件
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate // 长按地图某个点
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension            = YES;
//    [self.search AMapReGoecodeSearch:regeo]; //暂时不让长按地图某个点出现大头针
    OCMLog(@"长按的点--%f\n--%f", coordinate.latitude,coordinate.longitude);
}
- (void)gpsAction {
    if(self.mapView.userLocation.updating && self.mapView.userLocation.location) {
        [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
//        [self.gpsButton setSelected:YES];//添加箭头方向
    }
    if (_isShowSeaAnno) {
        NSMutableSet *before = [NSMutableSet setWithArray:self.mapView.annotations];
        [before removeObject:[self.mapView userLocation]];
        for (MAPointAnnotation *anno in self.mapView.annotations) {
            if ([anno isKindOfClass:[OCMSeaAnnotation class]]) {
                [before removeObject:anno];
            }
        }
        NSMutableSet *toRemove = [NSMutableSet setWithSet:before];
//        [toRemove minusSet:after];
        /* 更新. */
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mapView removeAnnotations:[toRemove allObjects]];
        });
    } else {
        [self addAnotation];
    }
    _isShowSeaAnno = !_isShowSeaAnno;
}

/**
 根据经纬度显示网点位置
 */
- (void)addNetPoint:(CGFloat)chLatitude longitude:(CGFloat)chLongitude {
//    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//    pointAnnotation.coordinate = CLLocationCoordinate2DMake(chLatitude, chLongitude);
//    [_mapView addAnnotation:pointAnnotation];
//    CLLocationCoordinate2D loaction = CLLocationCoordinate2DMake(chLatitude, chLongitude);
//    [self.mapView setCenterCoordinate:loaction animated:YES];
}

- (void)addNetInfo:(OCMNetInfoStruct *)netInfo {   //添加网点大头针,并把当前地图中心定位到网点位置
    OCMLog(@"111==");
    __weak typeof(self) weakSelf = self;
//    self.ocmNetInfo = netInfo;
    CGFloat chLatitude = netInfo.netDetailInfo.chLatitude;
    CGFloat chLongitude = netInfo.netDetailInfo.chLogngitude;
    OCMNetAnnotation *pointAnnotation = [[OCMNetAnnotation alloc] init];
//    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(chLatitude, chLongitude);
    [weakSelf.mapView addAnnotation:pointAnnotation];
    CLLocationCoordinate2D loaction = CLLocationCoordinate2DMake(chLatitude, chLongitude);
    [weakSelf.mapView setCenterCoordinate:loaction animated:YES];
    
    NSString *str = [[NSString alloc] initWithCString:netInfo.netDetailInfo.chName encoding:NSUTF8StringEncoding];
    self.titleStr = str;
    NSString *contacts = [[NSString alloc] initWithCString:self.ocmNetInfo.netDetailInfo.contacts encoding:NSUTF8StringEncoding];
    self.contacts = contacts;
    self.QDid = [[NSString alloc] initWithCString:self.ocmNetInfo.netDetailInfo.qdid encoding:NSUTF8StringEncoding];
    OCMLog(@"11--大头针的--str--%@--地址--%@", str,self.ocmNetInfo);
}
- (void)naviToNet { //规划驾车路线
    OCMLog(@"导航--%f",self.destination.latitude);
//    self.startAnnotation.coordinate = self.startCoordinate;
//    self.destination.coordinate = self.destinationCoordinate;
    AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
    navi.requireExtension = YES;
    navi.strategy = 5;
    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:self.currentLocation.latitude
                                           longitude:self.currentLocation.longitude];
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:self.destination.latitude
                                                longitude:self.destination.longitude];
    [self.search AMapDrivingRouteSearch:navi];
    
    //
    self.compositeManager = [[AMapNaviCompositeManager alloc] init];
    // 如果需要使用AMapNaviCompositeManagerDelegate的相关回调（如自定义语音、获取实时位置等），需要设置delegate
    self.compositeManager.delegate = self;
    // 通过present的方式显示路线规划页面, 在不传入起终点启动导航组件的模式下，options需传入nil
//    [self.compositeManager presentRoutePlanViewControllerWithOptions:nil];
    
    //导航组件配置类 since 5.2.0
    AMapNaviCompositeUserConfig *config = [[AMapNaviCompositeUserConfig alloc] init];
    //传入终点坐标
    [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:[AMapNaviPoint locationWithLatitude:self.destination.latitude longitude:self.destination.longitude] name:@"目的地" POIId:nil];
//    [config setStartNaviDirectly:YES];
    //启动
    [self.compositeManager presentRoutePlanViewControllerWithOptions:config];
}
- (void)clickMoreInfo { // 弹出右侧界面
    _isClickMoreInfo = YES;
    [self showNetInfoView];
}
- (void)showNetInfoView {//右侧弹出的界面
    if (!_isClickMoreInfo) {
        return;
    }
    OCMLog(@"展示网点更多详细信息");
    CGFloat w = 250;
    [self.view addSubview:self.drawerView];
    
    if (self.childViewControllers) {
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[OCMFromRightViewController class]]) {
                [obj removeFromParentViewController];
            }
        }];
    }
    _rightVC = [[OCMFromRightViewController alloc] init];
    _rightVC.QDid = self.QDid;
    OCMLog(@"id--%@", self.QDid);
    [self addChildViewController:_rightVC];
    _rightVC.view.frame = self.drawerView.bounds;
    [self.drawerView addSubview:_rightVC.view];
    _rightVC.view.backgroundColor = [UIColor whiteColor];
    _rightVC.view.tag = 201;
    /**/
    [_rightVC.dismissBtn addTarget:self action:@selector(hiddenRightView) forControlEvents:UIControlEventTouchUpInside];
    [_rightVC.moreDetailBtn addTarget:self action:@selector(clickModalMoreInfo) forControlEvents:UIControlEventTouchUpInside];
    
    __block BOOL isAdded = NO;
    if (self.view.subviews) {
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.tag == 200) {
                isAdded = YES;
            }
        }];
    }
    if (!isAdded) {
        [self.view insertSubview:_rightVC.view aboveSubview:_rightBottomView];
    }
    if (_isBigLeftWidth) {
        [UIView animateWithDuration:0 animations:^{
            self.drawerView.frame = CGRectMake(screenWidth - 2 * w + kLeftSmallWidth, 0, w, screenHeight);
        }];
    } else {
        [UIView animateWithDuration:0 animations:^{
            self.drawerView.frame = CGRectMake(screenWidth - 2 * w + kLeftBigWidth, 0, w, screenHeight);
        }];
    }
    //设置数据
    _rightVC.titleLabel.text = @"芙蓉王广场网点";
    _rightVC.stars = 1;
    _rightVC.imgCounts = 1; //一张图片
    
}
- (void)clickModalMoreInfo {  //点击更多信息
    self.modalIndex = 1;
    [self showMoreDetailNetInfo:self.modalIndex];
}
- (void)clickModalTask {
    self.modalIndex = 0;
    [self showMoreDetailNetInfo:self.modalIndex];
}
//展示更多详细信息  底部弹出大界面
- (void)showMoreDetailNetInfo:(NSInteger)index {
//    OCMDetailModalViewController *modalVC = [[OCMDetailModalViewController alloc] init];
//    modalVC.indexP = index;
    OCMModalSplitViewController *modalVC = [[OCMModalSplitViewController alloc] init];
    modalVC.selectIndex = index;
    [self presentViewController:modalVC animated:YES completion:nil];
}
- (void)hiddenRightView { //隐藏右侧抽屉界面
    [UIView animateWithDuration:0.5 animations:^{
        self.drawerView.frame = CGRectMake(screenWidth, 0, 240, screenHeight);
    }];
    _isClickMoreInfo = NO;
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

/* 清空地图上已有的路线. */
- (void)clear {
    [self.naviRoute removeFromMapView];
}
#pragma mark -- 网络请求
- (void)loadSixThounsandNet {
    return; //暂时不添加网点
    DataBase *db = [DataBase shareInstance];
    NSMutableArray *tempArr = [db getSixThousandNetInfo];
    if (tempArr.count > 0) {
        _allNetInfoArr = tempArr;
        [self addAnotation];
        OCMLog(@"本地有缓存,不请求网络数据了");
        return; //如果数据库中有数据,就不做网络请求
    }
    OCMLog(@"本地没有缓存,开始请求网络数据");
    __weak typeof(self) weakSelf = self;
    OCMApiRequest *request = [OCMApiRequest sharedOCMApiRequest];
    NSString *path = [BaseURL stringByAppendingString:@"/v1/channel/all"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Authorization"] = NULL;
    [request POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *arr = [NSMutableArray array];
        OCMAllNetItem *allItem = [OCMAllNetItem mj_objectWithKeyValues:responseObject];
        arr = allItem.data;
        
        dispatch_time_t delayT = GCD_delayT(5); //尽量延迟操作,保证数据库关闭,防止closing leaked stmt错误
        dispatch_after(delayT, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [db batchAddData:arr];
        });
        
        for (OCMAllNetDetailItem *detailItem in arr) {
            [weakSelf.allNetInfoArr addObject:detailItem];
        }
        [weakSelf addAnotation];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        OCMLog(@"failure--%@", error);
    }];
}
#pragma mark -- 处理方法
/* 展示当前路线方案. */
- (void)presentCurrentCourse
{
    if (self.naviRoute) {
        [self clear];
    }
    OCMLog(@"展示当前路线方案");
    MANaviAnnotationType type = MANaviAnnotationTypeDrive;
//    MANaviAnnotationTypeDrive = 0,
//    MANaviAnnotationTypeWalking = 1,
//    MANaviAnnotationTypeBus = 2,
//    MANaviAnnotationTypeRailway = 3,
//    MANaviAnnotationTypeRiding = 4
    self.naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[self.currentCourse] withNaviType:type showTraffic:YES startPoint:[AMapGeoPoint locationWithLatitude:self.currentLocation.latitude longitude:self.currentLocation.longitude] endPoint:[AMapGeoPoint locationWithLatitude:self.destination.latitude longitude:self.destination.longitude]];
    [self.naviRoute addToMapView:self.mapView];
    
    /* 缩放地图使其适应polylines的展示. */
    NSInteger RoutePlanningPaddingEdge = 20;
    [self.mapView showOverlays:self.naviRoute.routePolylines edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge) animated:YES];
}
- (void)addAnnotationsToMapView:(MAMapView *)mapView
{
    @synchronized(self)
    {
        if (self.coordinateQuadTree.root == nil || !self.shouldRegionChangeReCalculate)
        {
//            OCMLog(@"tree is not ready.");
            return;
        }
        
        /* 根据当前zoomLevel和zoomScale 进行annotation聚合. */
//        __block MAMapRect visibleRect;
//        __block double zoomScale;
//        __block double zoomLevel;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            visibleRect = self.mapView.visibleMapRect;
//            zoomScale = self.mapView.bounds.size.width / visibleRect.size.width;
//            zoomLevel = self.mapView.zoomLevel;
//        });
//        if ([[NSThread currentThread] isMainThread]) {
        
            MAMapRect visibleRect = self.mapView.visibleMapRect;
            double zoomScale = self.mapView.bounds.size.width / visibleRect.size.width;
            double zoomLevel = self.mapView.zoomLevel;
        
//        OCMLog(@"thread--->%@", [NSThread currentThread]);
        
        /* 也可根据zoomLevel计算指定屏幕距离(以50像素为例)对应的实际距离 进行annotation聚合. */
        /* 使用：NSArray *annotations = [weakSelf.coordinateQuadTree clusteredAnnotationsWithinMapRect:visibleRect withDistance:distance]; */
        //double distance = 50.f * [self.mapView metersPerPointForZoomLevel:self.mapView.zoomLevel];
        
            __weak typeof(self) weakSelf = self;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSArray *annotations = [weakSelf.coordinateQuadTree clusteredAnnotationsWithinMapRect:visibleRect
                                                                                        withZoomScale:zoomScale
                                                                                         andZoomLevel:zoomLevel];
                /* 更新annotation. */
                [weakSelf updateMapViewAnnotationsWithAnnotations:annotations];
            });
//        }
    }
}
/* 更新annotation  聚合. */
- (void)updateMapViewAnnotationsWithAnnotations:(NSArray *)annotations
{
    /* 用户滑动时，保留仍然可用的标注，去除屏幕外标注，添加新增区域的标注 */
    NSMutableSet *before = [NSMutableSet setWithArray:self.mapView.annotations];
    [before removeObject:[self.mapView userLocation]];
    for (MAPointAnnotation *anno in self.mapView.annotations) {
        if ([anno isKindOfClass:[OCMNetAnnotation class]]) {
            [before removeObject:anno];
        }
    }
    
    NSSet *after = [NSSet setWithArray:annotations];
    
    /* 保留仍然位于屏幕内的annotation. */
    NSMutableSet *toKeep = [NSMutableSet setWithSet:before];
    [toKeep intersectSet:after];
    
    /* 需要添加的annotation. */
    NSMutableSet *toAdd = [NSMutableSet setWithSet:after];
    [toAdd minusSet:toKeep];
    
    /* 删除位于屏幕外的annotation. */
    NSMutableSet *toRemove = [NSMutableSet setWithSet:before];
    [toRemove minusSet:after];
    
    /* 更新. */
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mapView addAnnotations:[toAdd allObjects]];
        [self.mapView removeAnnotations:[toRemove allObjects]];
    });
}
#pragma mark -- 地图MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[ReGeocodeAnnotation class]]) // 点击添加逆地理信息大头针
    {
        static NSString *invertGeoIdentifier = @"invertGeoIdentifier";

        MANaviAnnotationView *poiAnnotationView = (MANaviAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:invertGeoIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MANaviAnnotationView alloc] initWithAnnotation:annotation
                                                                 reuseIdentifier:invertGeoIdentifier];
        }

        poiAnnotationView.animatesDrop   = YES;
        poiAnnotationView.canShowCallout = YES;
        poiAnnotationView.draggable      = YES;

        //show detail by right callout accessory view.
        poiAnnotationView.rightCalloutAccessoryView     = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        poiAnnotationView.rightCalloutAccessoryView.tag = RightCallOutTag;

        //call online navi by left accessory.
//        poiAnnotationView.leftCalloutAccessoryView.tag  = LeftCallOutTag;

        return poiAnnotationView;
    }
    if ([annotation isKindOfClass:[OCMNetAnnotation class]])
    {
//        return 0;
        OCMLog(@"222==");
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        OCMHomeCustomAnnotationView *annotationView = (OCMHomeCustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        _annotationView = annotationView;
        _annotationView.annotation = annotation;
        if (annotationView == nil) {
            annotationView = [[OCMHomeCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            annotationView.calloutOffset = CGPointMake(0, -5);
        }
//        annotationView.selected = YES; //默认弹出气泡,但是里面内容无法点击
        annotationView.portrait = [UIImage imageNamed:@"hollow_green_net"];
        annotationView.titleLabel.text = self.titleStr; //网点名字
        NSString *bossId = [[NSString alloc] initWithCString:self.ocmNetInfo.netDetailInfo.bossId encoding:NSUTF8StringEncoding];
        annotationView.numberLabel.text = bossId; // 网点编号
        if (self.contacts == nil) {
            self.contacts = @"";
        }
        annotationView.connetctLabel.text = [@"网点联系人 : " stringByAppendingString:self.contacts]; // 网点联系人
        NSString *star = [[NSString alloc] initWithCString:self.ocmNetInfo.netDetailInfo.rankCode encoding:NSUTF8StringEncoding];
        annotationView.starsLabel.text = [star stringByAppendingString:@"星级"]; //星级
        NSString *phone = [[NSString alloc] initWithCString:self.ocmNetInfo.netDetailInfo.phone encoding:NSUTF8StringEncoding];
        if (phone == nil) {
            phone = @"";
        }
        annotationView.telLabel.text = [@"联系电话 : " stringByAppendingString:phone];
        
        self.destination = CLLocationCoordinate2DMake(self.ocmNetInfo.netDetailInfo.chLatitude, self.ocmNetInfo.netDetailInfo.chLogngitude);
        [annotationView.naviBtn addTarget:self action:@selector(naviToNet) forControlEvents:UIControlEventTouchUpInside];
        [annotationView.netInfoBtn addTarget:self action:@selector(clickMoreInfo) forControlEvents:UIControlEventTouchUpInside];
        [annotationView.taskBtn addTarget:self action:@selector(clickModalTask) forControlEvents:UIControlEventTouchUpInside];
        return annotationView;
    }
    if ([annotation isKindOfClass:[ClusterAnnotation class]])
    {
        /* dequeue重用annotationView. */
        static NSString *const AnnotatioViewReuseID = @"AnnotatioViewReuseID";
        
        ClusterAnnotationView *annotationView = (ClusterAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotatioViewReuseID];
        
        if (!annotationView)
        {
            annotationView = [[ClusterAnnotationView alloc] initWithAnnotation:annotation
                                                               reuseIdentifier:AnnotatioViewReuseID];
        }
        
        /* 设置annotationView的属性. */
        annotationView.annotation = annotation;
        annotationView.count = [(ClusterAnnotation *)annotation count];
//        if (annotationView.count == 1) {
//            annotationView.image = [UIImage imageNamed:@"hollow_green_net"];//      <= 1个的时候,显示大头针
//        }
        /* 不弹出原生annotation */
        annotationView.canShowCallout = NO;
        
        return annotationView;
    }
    return nil;
}
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    MAAnnotationView *view = views[0];
    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.image = [UIImage imageNamed:@"direction"]; //增加方向箭头
        [self.mapView updateUserLocationRepresentation:pre];

        view.calloutOffset = CGPointMake(0, 0);
        view.canShowCallout = NO;
        self.userLocationAnnotationView = view;
    }
}

/**
 当前箭头旋转方向
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    if (!updatingLocation && self.userLocationAnnotationView != nil)
    {
        [UIView animateWithDuration:0.1 animations:^{
            double degree = userLocation.heading.trueHeading;
            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
        }];
    }
}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location { //位置发生变化
    OCMLog(@"location--%@\n经纬度--%f--%f", location.debugDescription,location.coordinate.latitude,location.coordinate.longitude);
    self.currentLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    [self.aMapLocationMgr stopUpdatingLocation];
    self.leftTopVC.currentLocation = self.currentLocation;
}
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    if (_isShowSeaAnno) {
        [self addAnnotationsToMapView:self.mapView];
    } else {
        
    }
}
- (void)mapView:(MAMapView *)mapView didLongPressedAtCoordinate:(CLLocationCoordinate2D)coordinate { //长按地图某个点
    _isSearchFromDragging = NO;
    [self searchReGeocodeWithCoordinate:coordinate];
}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    if ([overlay isKindOfClass:[LineDashPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        polylineRenderer.lineWidth   = 8;
//        polylineRenderer.lineDashPattern = @[@10, @15];
        polylineRenderer.strokeColor = [UIColor redColor];
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MANaviPolyline class]]) //导航
    {
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        
        polylineRenderer.lineWidth = 8;
        
        if (naviPolyline.type == MANaviAnnotationTypeWalking)
        {
            polylineRenderer.strokeColor = self.naviRoute.walkingColor;
        }
        else if (naviPolyline.type == MANaviAnnotationTypeRailway)
        {
            polylineRenderer.strokeColor = self.naviRoute.railwayColor;
        }
        else if (naviPolyline.type == MANaviAnnotationTypeDrive)
        {
            polylineRenderer.strokeColor = self.naviRoute.driveColor;
        }
        else
        {
            polylineRenderer.strokeColor = self.naviRoute.routeColor;
        }
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MAMultiPolyline class]])
    {
        MAMultiColoredPolylineRenderer * polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:overlay];
        
        polylineRenderer.lineWidth = 8;
        polylineRenderer.strokeColors = [self.naviRoute.multiPolylineColors copy];
        polylineRenderer.gradient = YES;
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MAMultiPointOverlay class]]) {
        OCMLog(@"MAMultiPointOverlay");
        if ([overlay isKindOfClass:[MAMultiPointOverlay class]])
        {
            MAMultiPointOverlayRenderer *renderer = [[MAMultiPointOverlayRenderer alloc] initWithMultiPointOverlay:overlay];
            ///设置图片
            renderer.icon = [UIImage imageNamed:@"hollow_red_net"];
            ///设置锚点
            renderer.anchor = CGPointMake(0.5, 1.0);
            renderer.delegate = self;
            return renderer;
        }

    }
    return nil;
}
#pragma mark -- AMapSearchDelegate
/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil && _isSearchFromDragging == NO)
    {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude);
        ReGeocodeAnnotation *reGeocodeAnnotation = [[ReGeocodeAnnotation alloc] initWithCoordinate:coordinate
                                                                                         reGeocode:response.regeocode];
        
        [self.mapView addAnnotation:reGeocodeAnnotation];
        [self.mapView selectAnnotation:reGeocodeAnnotation animated:YES];
    }
    else /* from drag search, update address */
    {
        [self.annotation setAMapReGeocode:response.regeocode];
        [self.mapView selectAnnotation:self.annotation animated:YES];
    }
    
}

/**
 地理编码(传地点名字-->坐标)
 */
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response {
    [response.geocodes enumerateObjectsUsingBlock:^(AMapGeocode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        OCMLog(@"g-%@", [obj.location debugDescription]);
    }];
}
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response { //路径规划回调
    OCMLog(@"路径规划回调");
    if (response.route == nil)
    {
        return;
    }
    self.route = response.route;
//    [self updateTotal];
    self.totalCourse = self.route.paths.count;
    self.currentCourse = 0;
    
//    [self updateCourseUI];
//    [self updateDetailUI];
    
    if (response.count > 0)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentCurrentCourse];
        });
    }
}
#pragma mark -- 导航回调方法
// 发生错误时,会调用此方法
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager error:(NSError *)error {
    NSLog(@"error:{%ld - %@}", (long)error.code, error.localizedDescription);
}
// 算路成功后的回调函数,路径规划页面的算路、导航页面的重算等成功后均会调用此方法
- (void)compositeManagerOnCalculateRouteSuccess:(AMapNaviCompositeManager *)compositeManager {
    NSLog(@"onCalculateRouteSuccess,%ld",(long)compositeManager.naviRouteID);
}
// 算路失败后的回调函数,路径规划页面的算路、导航页面的重算等失败后均会调用此方法
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager onCalculateRouteFailure:(NSError *)error {
    NSLog(@"onCalculateRouteFailure error:{%ld - %@}", (long)error.code, error.localizedDescription);
}
// 开始导航的回调函数
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager didStartNavi:(AMapNaviMode)naviMode {
    NSLog(@"didStartNavi,%ld",(long)naviMode);
}
// 当前位置更新回调
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager updateNaviLocation:(AMapNaviLocation *)naviLocation {
    NSLog(@"updateNaviLocation,%@",naviLocation);
}
// 导航到达目的地后的回调函数
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager didArrivedDestination:(AMapNaviMode)naviMode {
    NSLog(@"didArrivedDestination,%ld",(long)naviMode);
}
#pragma mark -- dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.coordinateQuadTree clean];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark -- lazyInit
- (CoordinateQuadTree *)coordinateQuadTree {
    if (!_coordinateQuadTree) {
        self.coordinateQuadTree = [[CoordinateQuadTree alloc] init];   //聚合四叉树
    }
    return _coordinateQuadTree;
}
@end
