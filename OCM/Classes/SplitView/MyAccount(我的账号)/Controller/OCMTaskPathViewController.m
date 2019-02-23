//
//  OCMTaskPathViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/27.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMTaskPathViewController.h"
#import "OCMMapV.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"

@interface OCMTaskPathViewController ()<AMapSearchDelegate,AMapLocationManagerDelegate,AMapGeoFenceManagerDelegate,AMapNearbySearchManagerDelegate,MAMapViewDelegate,CLLocationManagerDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) NSArray *lines;
@property (nonatomic, strong) NSMutableArray *annotations;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *numberArr;
@property (nonatomic, strong) NSArray *connectPeopleArr;
@property (nonatomic, strong) NSArray *starsInfoArr;
@property (nonatomic, strong) NSArray *phoneNumberArr;
@property (nonatomic, strong) MAPointAnnotation *selectAnno;
@end

@implementation OCMTaskPathViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initData];
    [self setMapView];
    [self addLine];
    [self addAnnotation];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"任务轨迹";
    self.view.backgroundColor = [UIColor whiteColor];
    _mapView.delegate = self;
}
- (void)clickBack {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addAnnotation {
    self.annotations = [NSMutableArray array];
    CLLocationCoordinate2D coordinates[4] = {
        {23.030476, 113.657755},
        {23.130476, 113.757755},
        {23.230476, 113.757755},
        {23.230476, 113.857755}
    };
    for (int i = 0; i < 4; i++) {
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = coordinates[i];
        [self.annotations addObject:pointAnnotation];
    }
    [_mapView addAnnotations:self.annotations];
}
- (void)setMapView {
    _mapView = [[MAMapView alloc] initWithFrame:self.view.frame];
    _mapView.delegate = self;
    _mapView.frame = self.view.bounds;
    [self.view addSubview:_mapView];
    _mapView.userInteractionEnabled = YES;
    [AMapServices sharedServices].enableHTTPS = YES;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    [_mapView setZoomLevel:13.5 animated:YES]; // 3 ~ 19
}
- (void)addLine {
    NSMutableArray *arr = [NSMutableArray array];
    //构造折线数据对象
    CLLocationCoordinate2D commonPolylineCoords[4];
    commonPolylineCoords[0].latitude = 23.030476;
    commonPolylineCoords[0].longitude = 113.657755;
    
    commonPolylineCoords[1].latitude = 23.130476;
    commonPolylineCoords[1].longitude = 113.757755;
    
    commonPolylineCoords[2].latitude = 23.230476;
    commonPolylineCoords[2].longitude = 113.757755;
    
    commonPolylineCoords[3].latitude = 23.230476;
    commonPolylineCoords[3].longitude = 113.857755;
    //构造折线对象
//    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:4];
    MAMultiPolyline *coloredPolyline = [MAMultiPolyline polylineWithCoordinates:commonPolylineCoords count:4 drawStyleIndexes:@[@1,@2,@3]];
    [arr addObject:coloredPolyline];
    //在地图上添加折线对象
    [_mapView addOverlay: coloredPolyline];
}
#pragma mark -- MAMapViewDelegate
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAMultiPolyline class]]) {
        MAMultiColoredPolylineRenderer *polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:overlay];
        polylineRenderer.lineWidth = 10.f;
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        polylineRenderer.strokeColors = @[[UIColor blueColor],[UIColor redColor],[UIColor yellowColor], [UIColor greenColor]];
        polylineRenderer.gradient = YES;
        return polylineRenderer;
    }
    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]] && ![annotation isKindOfClass:[MAUserLocation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            // must set to NO, so we can show the custom callout view.
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            annotationView.calloutOffset = CGPointMake(0, -5);
        }
        NSInteger index = [self.annotations indexOfObject:annotation];
        if (index > 100) { // 防止地图滑动过快,还没加载到annotation的时候的崩溃
//            OCMLog(@"index > 100");
            index = 0;
        }
        annotationView.name = [NSString stringWithFormat:@"%ld",(long)index];
        annotationView.title = self.titleArr[index];
        annotationView.number = self.numberArr[index];
        annotationView.connectPeople = self.connectPeopleArr[index];
        annotationView.starsInfo = self.starsInfoArr[index];
        annotationView.phoneNumber = self.phoneNumberArr[index];
//        [annotationView.moreBtn addTarget:self action:@selector(clickMoreBtn) forControlEvents:UIControlEventTouchUpInside];
//        self.selectAnno = self.annotations[index];
        __weak typeof(self) weakSelf = self;
        annotationView.clickMoreBlock = ^(CLLocationCoordinate2D coorinate) {
            __strong typeof(self) theSelf = weakSelf;
            CLLocationCoordinate2D co = coorinate;
//            NSLog(@"--->coordinate = {%f, %f}", co.latitude, co.longitude);
            [theSelf addRightView:co];
        };
        if (index == 0 || index == 3) {
            annotationView.portrait = [UIImage imageNamed:@"hollow_red_net"];
            annotationView.nameLabel.textColor = [UIColor colorWithHexString:@"#ef285e"];
        } else {
            annotationView.portrait = [UIImage imageNamed:@"hollow_green_net"];
            annotationView.nameLabel.textColor = [UIColor colorWithHexString:@"#31d7b1"];
        }
        //红色#ef285e，平方粗体，32px
        //绿色#31d7b1
        
        
        return annotationView;
    }
    return nil;
}
- (void)addRightView:(CLLocationCoordinate2D)co{
    
}
- (void)initData {
    self.titleArr = @[@"兴达百货",@"美宜佳便利店",@"沃尔玛超市",@"珠穆朗玛峰"];
    self.numberArr = @[@"QD72495",@"QD11111",@"QD22222",@"QD33333"];
    self.connectPeopleArr = @[@"张三",@"李四",@"王五五",@"陈六六"];
    self.starsInfoArr = @[@"1星级",@"4星级",@"8星级",@"6星级"];
    self.phoneNumberArr = @[@"13611112222",@"15833334444",@"15955556666",@"18077778888"];
}
- (void)clickMoreBtn {
    CLLocationCoordinate2D coorinate = [self.selectAnno coordinate];
//    NSLog(@"--->coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
//    OCMLog(@"selecAnno--%@--", self.selectedAnno.debugDescription);
}
#pragma mark -- deallc
- (void)dealloc {
    OCMLog(@"taskPath--dealloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
