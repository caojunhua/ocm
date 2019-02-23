//
//  OCM_PCH.h
//  OCM
//
//  Created by 曹均华 on 2017/11/29.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#ifndef OCM_PCH_h
#define OCM_PCH_h

#import "Category.h"
#import <Masonry.h>
#import "Definitions.h"
#import "Tools.h"
#import "MacroDefinition.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "single.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "OCMConst.h"
#import "OCMApiRequest.h"
#import <MJRefresh/MJRefresh.h>
#import "DataBase.h"
/**
 打印信息
 */
#ifdef DEBUG    // 调试状态, 打开LOG功能
#define __DFILE__  ([[NSString stringWithFormat:@"%s",__FILE__] LogFileName]) //文件名
#define OCMLog(format, args...) (NSLog(@"[当前文件%@:第%d行]: " format "\n", __DFILE__, __LINE__, ## args))
#else       // 发布状态, 关闭LOG功能
#define OCMLog(...)
#endif


/**
 获取设备的系统版本
 */
#define ios_system_version [[[UIDevice currentDevice] systemVersion] floatValue]

/**
 屏幕尺寸
 */
#define screenBounds [UIScreen mainScreen].bounds
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

/**按当前屏幕比例设置不同大小,看起来更协调*/
#define kBaseLine(a) (CGFloat)a * SCREEN_WIDTH / 375.0
/** 设置边框*/
#define ViewBorder(View,Width,Color,Radius)\
\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]];\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];

/**GCD延迟时间设置*/
#define GCD_delayT(time) dispatch_time(DISPATCH_TIME_NOW, (int64_t)((time)*NSEC_PER_SEC));

/*首页左上角标签宽度 高度*/
#define kLeftTopWidth 290
#define kLeftTopHeight1 480
#define kLeftTopHeight2 115 // 74
/*首页右下角 */
#define kRightBottomWidth 250
#define kRightBottomHeight 300


#endif /* OCM_PCH_h */
