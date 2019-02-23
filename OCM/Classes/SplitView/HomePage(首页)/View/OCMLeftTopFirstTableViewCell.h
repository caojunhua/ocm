//
//  OCMLeftTopFirstTableViewCell.h
//  OCM
//
//  Created by 曹均华 on 2017/12/18.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCMLeftTopFirstTableViewCell : UITableViewCell
//@property (nonatomic,strong)UILabel *titleL;
//@property (nonatomic,strong)UILabel *detailL;
@property (weak, nonatomic) IBOutlet UILabel *netLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberL;
@property (weak, nonatomic) IBOutlet UILabel *detailNumberL;
@property (weak, nonatomic) IBOutlet UILabel *detailNetL;

@end
