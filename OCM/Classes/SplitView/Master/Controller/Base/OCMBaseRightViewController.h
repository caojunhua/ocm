//
//  OCMBaseRightViewController.h
//  OCM
//
//  Created by 曹均华 on 2017/12/8.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCMBaseRightViewController : UIViewController
@property (nonatomic,assign)CGFloat referWidht;

/**
 NO-->代表向左滑动了,YES-->代表向右滑动了
 */
@property (nonatomic, assign) BOOL isStretch;
@end
