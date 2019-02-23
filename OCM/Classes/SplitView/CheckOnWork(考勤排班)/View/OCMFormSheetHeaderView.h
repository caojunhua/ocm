//
//  OCMFormSheetHeaderView.h
//  OCM
//
//  Created by 曹均华 on 2018/4/20.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCMFormSheetHeaderView : UIView
@property (nonatomic, strong) UILabel           *dateLabel;    //时间文本
@property (nonatomic, strong) UILabel           *statusLabel;  //状态 --> 通过, 待审核, 不通过
@property (nonatomic, strong) UIView            *rightV;       //右侧部分view ,作为一个整体
@property (nonatomic, strong) UILabel           *label1;       //固定写 --> 总时长:
@property (nonatomic, strong) UILabel           *realityTimeL; //实际总时间
@property (nonatomic, strong) UILabel           *label2;       //固定写 --> 小时
@end
