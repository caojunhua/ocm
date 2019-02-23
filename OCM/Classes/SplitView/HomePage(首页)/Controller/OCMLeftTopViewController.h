//
//  OCMLeftTopViewController.h
//  OCM
//
//  Created by 曹均华 on 2017/12/15.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@class OCMNetInfoStruct,OCMTopSecondViewController;
typedef void(^OCMNetInfo)(OCMNetInfoStruct *ocmNetInfoStruct);
typedef void(^clickHiddenBtn)(BOOL isHidden);
typedef void(^selLocation)(CGFloat chLati,CGFloat chLongitu);
@interface OCMLeftTopViewController : UIViewController
@property (nonatomic, copy) clickHiddenBtn clickHiddenBtn;
@property (nonatomic, strong) UIButton *hiddenBtn;
@property (nonatomic, copy) selLocation selLocation;
@property (nonatomic, copy) OCMNetInfo ocmNetInfo;
@property (nonatomic, assign) CLLocationCoordinate2D currentLocation;
@property (nonatomic, strong) OCMTopSecondViewController *secondVC;
//- (void)setCurrentLocation:(CLLocationCoordinate2D)currentLocation;
@end


