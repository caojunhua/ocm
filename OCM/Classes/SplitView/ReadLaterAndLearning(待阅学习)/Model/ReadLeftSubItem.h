//
//  ReadLeftSubItem.h
//  OCM
//
//  Created by 曹均华 on 2017/12/6.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadLeftSubItem : NSObject
@property (nonatomic,assign)BOOL isParentCell;
@property (nonatomic,assign)BOOL subCell;
@property (nonatomic,copy)NSString *bigTitle;

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *auther;
@property (nonatomic,copy)NSString *dateStr;

+ (instancetype)itemWithDict:(NSDictionary *)dict;
@end
