//
//  OCMSheetArrangeCellItem.h
//  OCM
//
//  Created by 曹均华 on 2018/4/23.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCMSheetArrangeCellItem : NSObject
@property (nonatomic, assign) NSInteger         arrangeNumber;
@property (nonatomic, copy)   NSString          *timeStr;
@property (nonatomic, assign) NSInteger         iconType;
@property (nonatomic, copy)   NSString          *tasKTheme;
@property (nonatomic, copy)   NSString          *taskDetail;
@property (nonatomic, copy)   NSString          *totalTime;

@property (nonatomic, copy)   NSString          *today;
@end
