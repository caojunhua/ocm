//
//  OCMSubTaskTableViewController.h
//  OCM
//
//  Created by 曹均华 on 2018/5/8.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^subTaskBlock)(NSString *subTaskName);
@interface OCMSubTaskTableViewController : UITableViewController
@property (nonatomic, strong) NSArray      *dataSourceArr;
@property (nonatomic, copy)   subTaskBlock subTaskBlock;
@end
