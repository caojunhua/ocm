//
//  ReadLeftTableViewCell.h
//  OCM
//
//  Created by 曹均华 on 2017/12/6.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReadLeftSubItem;
@interface ReadLeftTableViewCell : UITableViewCell

@property (nonatomic,strong)ReadLeftSubItem *item;
@property (nonatomic,strong)UIImageView *iconView;

@end
