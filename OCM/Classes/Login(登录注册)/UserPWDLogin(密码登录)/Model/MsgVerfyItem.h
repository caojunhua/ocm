//
//  MsgVerfyItem.h
//  OCM
//
//  Created by 曹均华 on 2018/1/29.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>


@class MsgData;
@interface MsgVerfyItem : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) MsgData *data;
@end
