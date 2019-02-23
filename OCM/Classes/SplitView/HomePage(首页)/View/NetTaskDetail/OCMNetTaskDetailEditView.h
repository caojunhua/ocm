//
//  OCMNetTaskDetailEditView.h
//  OCM
//
//  Created by JianFeng_Ma on 2018/4/17.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    0 文本
    1 图片
 */
typedef void(^editViewCompleteHandler)(NSInteger handleType,id content);

@class OCMNetTaskDetailModel;

@interface OCMNetTaskDetailEditView : UIView

- (void)setModel:(OCMNetTaskDetailModel *)model;

- (void)getLocation:(NSString *)location;

@end
