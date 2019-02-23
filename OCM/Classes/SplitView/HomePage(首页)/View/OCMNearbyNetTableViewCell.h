//
//  OCMNearbyNetTableViewCell.h
//  OCM
//
//  Created by 曹均华 on 2017/12/25.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCMNearbyNetTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *titleL;
@property (nonatomic,strong)UILabel *detailL;
@property (nonatomic,strong)UILabel *distanceL;
@property (nonatomic,strong)UILabel *numberL;
@property (nonatomic,strong)UIButton *warningBtn;
@property (nonatomic,strong)UIButton *checkBtn;
@property (nonatomic,strong)UIButton *taskBtn;
@property (nonatomic,strong)UIButton *signBtn;
@end
