//
//  OCMHomeLeftSubViewController.h
//  OCM
//
//  Created by 曹均华 on 2017/12/1.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMBaseLeftViewController.h"

@class OCMMasterViewController;
typedef void(^showBtn)(BOOL isShow);
@interface OCMMyAccountLeftSubViewController : OCMBaseLeftViewController
@property (nonatomic, copy) showBtn showBtn;
@end
