//
//  OCMTaskTableViewController.h
//  OCM
//
//  Created by 曹均华 on 2018/1/10.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^taskBlock)(NSString *task);
@interface OCMTaskTableViewController : UITableViewController
@property (nonatomic,copy)taskBlock taskBlock;
@property (nonatomic,strong)NSArray *dataArr;
@end
