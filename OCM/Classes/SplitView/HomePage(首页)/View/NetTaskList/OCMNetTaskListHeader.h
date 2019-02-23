//
//  OCMNetTaskListHeader.h
//  OCM
//
//  Created by JianFeng_Ma on 2018/4/13.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ocmNetTaskListHeaderClickHandle)(NSInteger index);

@interface OCMNetTaskListHeader : UIView

+(instancetype)createHeaderWithDataSource:(NSArray *)titles clickButtonWithHandle:(ocmNetTaskListHeaderClickHandle)handle;

@end
