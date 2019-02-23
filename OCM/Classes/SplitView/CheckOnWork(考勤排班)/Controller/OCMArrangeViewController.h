//
//  OCMArrangeViewController.h
//  OCM
//
//  Created by 曹均华 on 2018/4/12.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "OCMCalendarViewController.h"


@interface OCMArrangeViewController : OCMCalendarViewController
@property (nonatomic, strong) NSMutableArray<NSArray *>      *arrangeArr;                  //排班数据源
@property (nonatomic, strong) NSMutableArray<NSArray *>      *checkerArr;                  //审核人意见数据源

@end
