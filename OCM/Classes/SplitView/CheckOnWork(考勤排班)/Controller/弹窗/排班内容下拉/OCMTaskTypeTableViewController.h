//
//  OCMTaskTypeTableViewController.h
//  OCM
//
//  Created by 曹均华 on 2018/5/7.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OCMTaskTypeItem;
typedef void(^taskContentBlock)(OCMTaskTypeItem *item);
@interface OCMTaskTypeTableViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray<NSArray *> *dataSourceArr;
@property (nonatomic, copy)   taskContentBlock          taskContentBlock;
@end
