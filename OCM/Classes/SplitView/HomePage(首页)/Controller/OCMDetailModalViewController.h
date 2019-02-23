//
//  OCMDetailModalViewController.h
//  OCM
//
//  Created by 曹均华 on 2018/3/12.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "OCMBaseRightViewController.h"
//#import "OCMRightBaseNavigationViewController.h"

@interface OCMDetailModalViewController : UIViewController
//@interface OCMDetailModalViewController : OCMRightBaseNavigationViewController
@property (nonatomic, assign) NSInteger indexP;
//请求参数
@property (nonatomic, copy) NSString *QDid;
@end
