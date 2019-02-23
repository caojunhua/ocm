//
//  OCMTaskListCellTableViewCell.h
//  OCM
//
//  Created by 曹均华 on 2017/12/7.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaskListItem;
@interface OCMTaskListTableViewCell : UITableViewCell
@property (nonatomic,strong)TaskListItem *item;
@end
