//
//  ModalFirstViewController.h
//  OCM
//
//  Created by 曹均华 on 2018/3/12.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    OCMTASKUNFINISH,//未完成（历史）
    OCMTASKFINISH,//已完成、历史
    OCMTASKHANDLING,//进行中
} OCMNetTaskDetailType;

@class OCMNetTaskDetailModel;
@interface ModalFirstViewController : UIViewController

- (void)setDetailModel:(OCMNetTaskDetailModel *)detailModel;

@end
