//
//  OCMMoreDetailTableViewCell.h
//  OCM
//
//  Created by 曹均华 on 2018/3/7.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OCMNetTaskListModel;

typedef void(^signInHandle)(void);

@interface OCMMoreDetailTableViewCell : UITableViewCell

- (void)setModel:(OCMNetTaskListModel *)model;

- (void)clickSignButtonWithHandle:(signInHandle)handle;

@end

