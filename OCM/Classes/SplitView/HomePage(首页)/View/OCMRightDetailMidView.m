//
//  OCMRightDetailMidView.m
//  OCM
//
//  Created by 曹均华 on 2018/2/24.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMRightDetailMidView.h"
#import "rightMidDetailItem.h"

@implementation OCMRightDetailMidView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"OCMRightDetailMidView" owner:self options:nil] objectAtIndex:0];
        [self addSubview:view];
    }
    return self;
}
- (void)setItem:(rightMidDetailItem *)item {
    self.label1.text = item.ID;                 //渠道代码
    self.labelStatus.text = item.chStatus;      //渠道状态
    self.label3.text = item.townName;           //镇区
    self.label4.text = item.storeAccountName;   //总店名称
    self.label5.text = item.chainLevel;         //班组
    self.label6.text = item.chName;             //渠道户名
    self.label8.text = item.cooperStartTime;    //合作年限
    self.label10.text = item.mngrId;            //渠道经理
    self.label11.text = item.chAddr;             //渠道地址 
    self.label15.text = item.mngrPhone;         //渠道经理电话
}
@end
