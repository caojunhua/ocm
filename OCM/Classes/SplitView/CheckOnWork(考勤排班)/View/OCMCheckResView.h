//
//  OCMCheckResView.h
//  OCM
//
//  Created by 曹均华 on 2018/4/25.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCMCheckResView : UIView
@property (nonatomic, strong) UIImageView *pointView;               //蓝色点  or  红色点
@property (nonatomic, strong) UILabel     *checkerLabel;            //审核人
@property (nonatomic, strong) UILabel     *checkTimeLabel;          //审核时间
@property (nonatomic, strong) UILabel     *suggestLabel;            //审核建议
@end
