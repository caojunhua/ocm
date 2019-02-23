//
//  OCMTaskTypeTableViewCell.h
//  OCM
//
//  Created by 曹均华 on 2018/5/7.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OCMTaskTypeItem;
@interface OCMTaskTypeTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView     *imgV;
@property (nonatomic, strong) UILabel         *label;
@property (nonatomic, strong) OCMTaskTypeItem *item;
@end
