//
//  OCMLeftTopTaskTableViewCell.h
//  OCM
//
//  Created by 曹均华 on 2018/3/22.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCMLeftTopTaskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *netL;
@property (weak, nonatomic) IBOutlet UILabel *numberL;

/**
 网点编号
 */
@property (weak, nonatomic) IBOutlet UILabel *detailL;

/**
 网点名字
 */
@property (weak, nonatomic) IBOutlet UILabel *detailNetL;

@end
