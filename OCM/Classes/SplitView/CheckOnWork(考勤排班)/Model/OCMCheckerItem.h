//
//  OCMCheckerItem.h
//  OCM
//
//  Created by 曹均华 on 2018/4/26.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCMCheckerItem : NSObject
@property (nonatomic, strong) NSString          *auditPerson;                   //审核人
@property (nonatomic, strong) NSString          *auditOpinion;                  //审核意见
@property (nonatomic, assign) NSInteger         auditDate;                      //审核时间戳
@end
