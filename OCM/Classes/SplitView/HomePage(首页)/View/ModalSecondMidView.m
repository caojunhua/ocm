//
//  ModalSecondMidView.m
//  OCM
//
//  Created by 曹均华 on 2018/3/14.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "ModalSecondMidView.h"
#import "rightMidDetailItem.h"

@implementation ModalSecondMidView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        ModalSecondMidView *view = [[[NSBundle mainBundle] loadNibNamed:@"ModalSecondMidView" owner:self options:nil] lastObject];
        CGRect rect = frame;
        rect.origin.x = 0;
        rect.origin.y = 0;
        view.frame = rect;        
        [self addSubview:view];
    }
    return self;
}
- (void)setItem:(rightMidDetailItem *)item {
    self.QDNumberL.text = item.ID;                 //渠道代码
    self.QDStateL.text = item.chStatus;      //渠道状态
    self.TownAreaL.text = item.townName;           //镇区
    self.ShopNameL.text = item.storeAccountName;   //总店名称
    self.QDTeamL.text = item.chainLevel;         //班组
    self.ChainNameL.text = item.chName;             //渠道户名
    self.CooperateL.text = item.cooperStartTime;    //合作年限
    self.QDManagerL.text = item.mngrId;            //渠道经理
    self.QDAddress.text = item.chAddr;             //渠道地址
    self.QDManagerPhoneL.text = item.mngrPhone;         //渠道经理电话
}
@end
