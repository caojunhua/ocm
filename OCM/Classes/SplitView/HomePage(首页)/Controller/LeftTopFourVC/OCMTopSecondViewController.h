//
//  OCMTopSecondViewController.h
//  OCM
//
//  Created by 曹均华 on 2017/12/16.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@class OCMNetInfoStruct;
typedef void(^OCMNetInfo)(OCMNetInfoStruct *ocmNetInfoStruct);
typedef void(^netLocation)(CGFloat chLati,CGFloat chLongitu);
@interface OCMTopSecondViewController : UIViewController
@property (nonatomic, copy) netLocation netLocation;
@property (nonatomic, copy) OCMNetInfo ocmNetInfo;
@property (nonatomic, assign) CLLocationCoordinate2D currentLocation;
@end
