//
//  OCMRightBottomViewController.h
//  OCM
//
//  Created by 曹均华 on 2017/12/19.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^hiddenOrShow)(BOOL isUp);
@interface OCMRightBottomViewController : UIViewController
@property (nonatomic,copy)hiddenOrShow hiddenOrShow;
@end
