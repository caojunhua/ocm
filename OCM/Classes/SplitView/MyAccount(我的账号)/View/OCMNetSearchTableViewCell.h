//
//  OCMNetSearchTableViewCell.h
//  OCM
//
//  Created by 曹均华 on 2018/3/1.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCMNetSearchTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;
@property (nonatomic, strong) UILabel *label5;
@property (nonatomic, strong) UILabel *label6;
@property (nonatomic, strong) UILabel *label7;
@property (nonatomic, assign) CGFloat width;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(CGFloat)width;
@end
