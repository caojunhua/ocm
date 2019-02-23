//
//  GestureLoginViewController.h
//  OCM
//
//  Created by 曹均华 on 2017/12/12.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GestureLoginViewController : UIViewController
@property (nonatomic,strong)UIButton *resetBtn;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic, strong) UIButton *cancelBtn;
- (void)resetGes;
+ (instancetype)sharedInstance;
@end
