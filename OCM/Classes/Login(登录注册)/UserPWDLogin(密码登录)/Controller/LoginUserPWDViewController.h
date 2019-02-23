//
//  LoginUserPWDViewController.h
//  OCM
//
//  Created by 曹均华 on 2017/11/29.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UserLoginMode) {
    UserLoginModeByNormal,
    UserLoginModeBySMS,
    UserLoginModeByGesture
};

@interface LoginUserPWDViewController : UIViewController

@end
